import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecta/tabs/tab_message.dart';
import 'package:projecta/models/model_feeds.dart';
import 'dart:math';

class TabHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "COMMUNITY",
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
              Container(
                color: Colors.green.shade100,
                width: double.infinity,
                height: 220,
                child: ImageScrollPage(),
              ),
              Container(
                height: 40,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "챌린저들의 인증 사진입니다.",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                          child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QandaPage()),
                          );
                        },
                        icon: const Icon(Icons.question_answer,
                            color: Color(0xff80C583), size: 100),
                      )),
                    ),
                    Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          "클릭하면 Q&A 페이지로 이동합니다.",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Center(
                    child: Text(
                  "오늘의 명언",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                )),
              ),
              StudyCode(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyCode extends StatelessWidget {
  final List<String> texts = [
    '오늘 걷지 않는다면 내일은 뛰어야한다.',
    '고난이란 최선을 다 할 기회이다.',
    '나만이 내 인생을 바꿀 수 있다. 아무도 날 대신해줄 수 없다.',
    '실패는 넘어지는 것이 아니다. 넘어진 자리에 머무는 것이다.',
    '사람은 믿는 것만을 해낼 수 있다.'
  ];
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
