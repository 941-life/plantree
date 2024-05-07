import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projecta/models/model_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';

class TabProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String userEmail = user != null ? user.email ?? 'No email' : 'No user logged in';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "PROFILE",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User Email: $userEmail',style: TextStyle(fontFamily: 'SUITE-Heavy',fontSize: 20),),
              LoginOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}



class LoginOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    return TextButton(
        onPressed: () async {
          await authClient.logout();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('logout!')));
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: Text('logout'));
  }
}