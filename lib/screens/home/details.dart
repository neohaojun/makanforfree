import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'home.dart';

class DetailsPage extends StatefulWidget {
  final DocumentSnapshot buffet;
  DetailsPage({this.buffet});

  bool halalState = false;
  bool vegetarianState = false;
  DateTime expiry = DateTime.now();

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
              child: Text(
                'Buffet Details',
                // widget.buffet.data["title"],
                style: TextStyle(color: Colors.white),
              )
            )
          ],
        ),
        backgroundColor: Color(0xff224966),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0,),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.buffet.data["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(height: 5.0),
              Divider(color: Colors.grey[800],),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.pin_drop,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    widget.buffet.data["location"],
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.fastfood,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    widget.buffet.data["amount"],
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.list,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    widget.buffet.data["choices"],
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(height: 7.0),
              Divider(color: Colors.grey[800],),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.date_range,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    DateFormat("dd - MM - yyyy").format(widget.buffet.data["expiry"].toDate()).toString(),
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    DateFormat("kk : mm : ss").format(widget.buffet.data["expiry"].toDate()).toString(),
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(height: 7.0),
              Divider(color: Colors.grey[800],),
              SizedBox(height: 7.0),
            ],
          ),
        ),
      ),
    );
  }
}