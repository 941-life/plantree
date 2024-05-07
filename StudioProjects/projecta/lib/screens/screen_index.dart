//screens/screen_index.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecta/tabs/tab_album.dart';
import 'package:projecta/tabs/tab_profile.dart';
import 'package:projecta/tabs/tab_upload.dart';
import 'package:projecta/tabs/tab_community.dart';
import 'package:projecta/tabs/tab_tree.dart';


class IndexScreen extends StatefulWidget {

  @override
  _IndexScreenState createState() {
    return _IndexScreenState();
  }
}

class _IndexScreenState extends State<IndexScreen> {

  int _currentIndex = 0;

  final List<Widget> tabs = [
    TabHome(),
    TabSearch(),
    TabTree(),
    TabAlbum(),
    TabProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true, // 선택된 라벨 보이기/숨기기
        showUnselectedLabels: false, // 선택되지 않은 라벨 보이기/숨기기

        type: BottomNavigationBarType.fixed,
        iconSize: 44,
        selectedItemColor: Color(0xff446e45),
        unselectedItemColor: Color(0xffB7B3B3),
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'community'),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: 'upload'),
          BottomNavigationBarItem(icon: CustomTreeIcon(),label: 'tree'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'album'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}
class CustomTreeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55, // 원하는 너비 설정
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffB7B3B3),
      ),// 원하는 높이 설정
      child: Icon(
        CupertinoIcons.tree,
        size: 46, //// 위에서 설정한 너비와 높이와 동일한 값으로 설정
      ),
    );
  }
}