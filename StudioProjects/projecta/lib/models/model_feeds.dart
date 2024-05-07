import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class ImageScrollPage extends StatefulWidget {
  @override
  _ImageScrollPageState createState() => _ImageScrollPageState();
}

class _ImageScrollPageState extends State<ImageScrollPage> {
  List<String> imageURLs = [];

  @override
  void initState() {
    super.initState();
    fetchImageURLs();
  }
  Future<void> fetchImageURLs() async {
    // Firebase Storage에서 이미지 URL들을 가져오는 함수
    ListResult result = await FirebaseStorage.instance.ref('images').listAll();

    // 각 이미지의 다운로드 URL을 가져오기 위해 Future<List<String>>
    List<Future<String>> downloadURLFutures = [];
    for (var item in result.items) {
      downloadURLFutures.add(item.getDownloadURL());
    }

    List<String> urls = await Future.wait(downloadURLFutures);

    setState(() {
      imageURLs = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: imageURLs.reversed.map((url) { // 거꾸로 매핑!!
            return Center(
              child: Container(
                margin: EdgeInsets.all(8),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}