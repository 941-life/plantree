import 'package:flutter/material.dart';


class yourPost extends StatelessWidget {
  final String message;
  final String user;
  final String time;

  const yourPost({
    Key? key,
    required this.message,
    required this.user,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top:25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[400]),
            child: Icon(Icons.person),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user,style: TextStyle(color: Colors.green[200]),),
              const SizedBox(height: 10),
              Text(message),
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}
