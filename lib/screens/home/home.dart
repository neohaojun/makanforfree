import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:makanforfree/services/auth.dart';
import 'form.dart';
import 'details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:makanforfree/shared/loading.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;
  DateTime now =  DateTime.now();
  DateTime expiry = DateTime.now();
  String expiryString = '';
  var circleColour = Colors.green;

  Future getBuffets() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("buffets").orderBy("expiry", descending: true).getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot buffet) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(buffet: buffet,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   fit: BoxFit.contain,
            //   height: 33.0,
            // ),
            Container(
              padding: const EdgeInsets.all(8.0), 
              child: Text(
                'MakanForFree',
                style: TextStyle(color: Color(0xff224966)),
              )
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Color(0xff224966),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0,),
        child: FutureBuilder(
          future: getBuffets(),
          builder: (_, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  now =  DateTime.now();
                  expiry = snapshot.data[index].data["expiry"].toDate();
                  expiryString = DateFormat("dd-MM-yyyy kk:mm:ss").format(expiry);
                  if (now.isAfter(expiry)) {
                    circleColour = Colors.red;
                  } else if (now.isAtSameMomentAs(expiry)) {
                    circleColour = Colors.green;
                  } else if (now.isBefore(expiry)) {
                    circleColour= Colors.blue;
                  }

                  return ListTile(
                    leading: CircleAvatar(backgroundColor: circleColour),
                    title: Text(snapshot.data[index].data["title"]),
                    subtitle: Text("Expiry: $expiryString"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => navigateToDetail(snapshot.data[index]),
                  );
                }
              );
            }

        }),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(.26),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
              // MaterialPageRoute(builder: (context) => BuffetForm())
              PageRouteBuilder(
                transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
                  
                  animation = CurvedAnimation(parent: animation, curve: Curves.linear);
                  
                  return ScaleTransition(
                    alignment: Alignment.bottomRight,
                    scale: animation,
                    child: child,
                  );
                },
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
                  return BuffetForm();
                }
              )
            );
          },
          child: SvgPicture.asset(
            "assets/icons/plus.svg",
            height: 20.0,
          ),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
    