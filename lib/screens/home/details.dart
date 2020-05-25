import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatefulWidget {

  final DocumentSnapshot buffet;
  DetailsPage({this.buffet});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0), 
              child: Text(
                'Buffet Details',
                style: TextStyle(color: Colors.white),
              )
            )
          ],
        ),
        backgroundColor: Color(0xff224966),
      ),
      body: Container(),
    );
  }
}