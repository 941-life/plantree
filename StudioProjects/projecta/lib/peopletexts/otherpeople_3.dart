import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class OtherPeopleb extends StatefulWidget {
  const OtherPeopleb({Key? key}) : super(key: key);

  @override
  State<OtherPeopleb> createState() => _OtherPeoplebState();
}

class _OtherPeoplebState extends State<OtherPeopleb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '900 UP class 일기장',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            wordSpacing: 4,
          ),
        ),
      ),
      body: _buildBody(context), // Call a method to build the body
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('User texts_b').snapshots(),
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
            child: Text(text),
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
