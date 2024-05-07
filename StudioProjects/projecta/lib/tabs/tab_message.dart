import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';
import 'package:intl/intl.dart';
import 'package:projecta/screens/post.dart';


class QandaPage extends StatefulWidget {
  const QandaPage({super.key});

  @override
  State<QandaPage> createState() => _QandaPageState();
}

class _QandaPageState extends State<QandaPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  void sign0ut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    //only post if there is someting in the textfield
    if (textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message':textController.text,
        'TimeStamp': DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Center(child: Text("Q & A",
          style: TextStyle(
          color: Colors.brown.shade300,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          wordSpacing: 4,
        ),)),
        elevation: 0,
        actions: [
          IconButton(onPressed: sign0ut, icon: Icon(Icons.logout),),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy(
                      "TimeStamp",
                      descending: true, // true로 해야 순서 바뀜
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return yourPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          time: post['TimeStamp']
                        );

                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error:' + snapshot.error.toString()),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up))
                ],
              ),
            ),
            Text("Logged in as: " + currentUser.email!)
          ],
        ),
      ),
    );
  }
}
