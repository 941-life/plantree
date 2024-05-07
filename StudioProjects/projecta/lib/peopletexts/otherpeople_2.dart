import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class OtherPeoplea extends StatefulWidget {
  const OtherPeoplea({Key? key}) : super(key: key);

  @override
  State<OtherPeoplea> createState() => _OtherPeopleaState();
}

class _OtherPeopleaState extends State<OtherPeoplea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '800 UP class 일기장',
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
              fontFamily: 'SUITE-Medium'
          ),
        ),
      ),
      body: _buildBody(context), // Call a method to build the body
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('User texts_a').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Widget> widgets = []; // List to hold widgets

        snapshot.data!.docs.forEach((doc) {
          String text =
          doc['text']; // Assuming 'text' is the field name in Firestore
          widgets.add(Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(text, style: TextStyle(
                fontFamily: 'bum', fontSize: 20
            ),),
          ));
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets, // Add all widgets to the column
          ),
        );
      },
    );
  }
}
