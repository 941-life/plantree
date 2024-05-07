import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecta/peopletexts/otherpeople_1.dart';
import 'package:projecta/peopletexts/otherpeople_2.dart';
import 'package:projecta/peopletexts/otherpeople_3.dart';
import 'package:path/path.dart' as path;
class TabSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "UPLOAD",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WordNudge(),
              Container(
                width: double.infinity,
                height: 460,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                color: Colors.blueGrey.shade300,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          height: 80,
                          child: Center(
                            child: Text(
                              '700+ room',
                              style: TextStyle(fontFamily: 'SUITE-ExtraBold', fontSize: 30,color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              '800+ room',
                              style: TextStyle(fontFamily: 'SUITE-ExtraBold', fontSize: 30, color: Colors.blueGrey),
                            ),
                          ),
                          height: 80,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThirdPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              '900+ room',
                              style: TextStyle(fontFamily: 'SUITE-ExtraBold', fontSize: 30,color: Colors.blueGrey),
                            ),
                          ),
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                ),

              ),
              Container(
                width: double.infinity,
                height: 80,
                color: Colors.green.shade100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WordNudge extends StatelessWidget {
  final List<String> texts = [
    'applicant - 지원자, 신청자',
    'associate - 관련시키다',
    'degree - 학위',
    'certification - 증명서',
    'eligible - 자격이 있는',
    'proficiency - 능숙, 숙달',
    'recruit - 모집하다'];
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(10.0),
      color: Colors.green.shade100,
      child: Container(
        margin: EdgeInsets.all(10.0),
        color: Colors.white,
        height: 50,
        child: Center(
          child: Text(texts[random.nextInt(texts.length)]),
        ),
      ),
    );
  }
}


//1st page

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final picker = ImagePicker();
  List<XFile?> images = [];

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = path.basename(imageFile.path); // path 패키지의 basename 함수 사용
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '700 up      ',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 100,
              child: Text(
                '오늘의 공부',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'bum'
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          images.add(image);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      List<XFile>? xFiles =
                      await picker.pickMultiImage();
                      if (xFiles != null && xFiles.isNotEmpty) {
                        for (XFile xFile in xFiles) {
                          String imageUrl =
                          await uploadImageToFirebase(File(xFile.path));
                          setState(() {
                            images.add(XFile(imageUrl));
                          });
                        }
                      }
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (images[index] != null) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:FileImage(File(images[index]!.path)),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() {
                                images.remove(images[index]);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(); // 이미지가 없는 경우 공백 위젯 반환
                  }
                },
              ),

            ),
            Container(
              child: Text(
                '오늘의 기록',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'bum'
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: UserText(),
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Center(
                child: Text(
                  '다른 챌린저들의 일기 확인하기', style: TextStyle(
                  fontFamily: 'bum', fontSize: 20, color: Colors.blueGrey
                ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              child: IconButton(
                icon: Icon(
                  Icons.people,
                  color: Colors.green.shade200,
                  size: 100,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtherPeople()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}



//2nd page


class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final picker = ImagePicker();
  List<XFile?> images = [];

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = path.basename(imageFile.path); // path 패키지의 basename 함수 사용
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '800 up      ',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            Container(
              height: 100,
              child: Text(
                '오늘의 공부',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          images.add(image);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      List<XFile>? xFiles =
                      await picker.pickMultiImage();
                      if (xFiles != null && xFiles.isNotEmpty) {
                        for (XFile xFile in xFiles) {
                          String imageUrl =
                          await uploadImageToFirebase(File(xFile.path));
                          setState(() {
                            images.add(XFile(imageUrl));
                          });
                        }
                      }
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (images[index] != null) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(images[index]!.path)),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() {
                                images.remove(images[index]);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(); // 이미지가 없는 경우 공백 위젯 반환
                  }
                },
              ),

            ),
            Container(
              child: Text(
                '오늘의 기록',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: UserText(),
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: IconButton(
                icon: Icon(
                  Icons.people,
                  color: Colors.green.shade200,
                  size: 100,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtherPeoplea()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 3th page

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final picker = ImagePicker();
  List<XFile?> images = [];

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = path.basename(imageFile.path); // path 패키지의 basename 함수 사용
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '900 up      ',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 100,
              child: Text(
                '오늘의 공부',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          images.add(image);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () async {
                      List<XFile>? xFiles =
                      await picker.pickMultiImage();
                      if (xFiles != null && xFiles.isNotEmpty) {
                        for (XFile xFile in xFiles) {
                          String imageUrl =
                          await uploadImageToFirebase(File(xFile.path));
                          setState(() {
                            images.add(XFile(imageUrl));
                          });
                        }
                      }
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (images[index] != null) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(images[index]!.path)),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              setState(() {
                                images.remove(images[index]);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(); // 이미지가 없는 경우 공백 위젯 반환
                  }
                },
              ),

            ),
            Container(
              child: Text(
                '오늘의 기록',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: UserText(),
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: IconButton(
                icon: Icon(
                  Icons.people,
                  color: Colors.green.shade200,
                  size: 100,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtherPeopleb()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserText extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference collection = FirebaseFirestore.instance.collection('User texts');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '공부 일기를 기록해주세요.',
                  fillColor: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await collection.add({'text': _controller.text});
                _controller.clear();
              },
              child: Text('저장하기'),
            ),
          ],
        ),
      ),
    );
  }
}
