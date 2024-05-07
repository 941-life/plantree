import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecta/models/model_instagram.dart';

class TabAlbum extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "FEED",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                wordSpacing: 4,
              ),
            ),
          ),
          body: InstagramPage(),),
    );
  }
}
