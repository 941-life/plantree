import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InstagramPage extends StatefulWidget {
  @override
  _InstagramPageState createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  List<Map<String, dynamic>> imageData = [];

  @override
  void initState() {
    super.initState();
    fetchImageData();
  }

  Future<void> fetchImageData() async {
    // Firebase Storage에서 이미지 URL들을 가져오는 함수
    ListResult result = await FirebaseStorage.instance.ref('images').listAll();
    // 각 이미지의 다운로드 URL을 가져오기 위해 Future<List<String>>
    List<Future<String>> downloadURLFutures = [];
    for (var item in result.items) {
      downloadURLFutures.add(item.getDownloadURL());
    }

    List<String> urls = await Future.wait(downloadURLFutures);

    setState(() {
      imageData =
          urls.map((url) => {"url": url, "text": "Your Text Here"}).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageData.reversed.map((data) {
          // 거꾸로 매핑!!
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        child: Icon(Icons.person),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                          child: Text(
                        'TRUZWW',
                        style: TextStyle(
                          fontSize: 20,
                            fontFamily: 'SUITE-Regular'
                        ),
                      ))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["url"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: HeartButton(),
                      ),
                      Expanded(
                        child: Text('2/19 오늘의 토익', style: TextStyle(
                            fontFamily: 'SUITE-Regular', fontSize: 20
                        ),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class HeartButton extends StatefulWidget {
  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  User? user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> _loadFavoriteStatus() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .get();
    bool isFavorited = doc['isFavorited'];
    int favoriteCount = doc['favoriteCount'];
    return {'isFavorited': isFavorited, 'favoriteCount': favoriteCount};
  }

  void _toggleFavorite(bool isFavorited, int favoriteCount) async {
    isFavorited = !isFavorited;
    isFavorited ? favoriteCount++ : favoriteCount--;
    await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .set({
      'isFavorited': isFavorited,
      'favoriteCount': favoriteCount,
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadFavoriteStatus(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          bool isFavorited = snapshot.data!['isFavorited'];
          int favoriteCount = snapshot.data!['favoriteCount'];
          return Center(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: isFavorited
                      ? Icon(Icons.favorite, color: Colors.red, size: 30,)
                      : Icon(Icons.favorite_border, size: 30,),
                  onPressed: () => _toggleFavorite(isFavorited, favoriteCount),
                ),
                Text('좋아요 $favoriteCount 개',style: TextStyle(fontSize: 20,fontFamily: 'SUITE-Regular'),),
              ],
            ),
          );
        }
      },
    );
  }
}
