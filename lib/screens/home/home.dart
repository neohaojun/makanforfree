import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makanforfree/services/auth.dart';
import 'form_material.dart';
// import 'package:makanforfree/shared/loading.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home | MakanForFree'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
              setState(() => loading = true);
            },
          )
        ],
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
              // MaterialPageRoute(builder: (context) => FormMaterial())
              PageRouteBuilder(
                // transitionDuration: Duration(seconds: 1),
                transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
                  
                  animation = CurvedAnimation(parent: animation, curve: Curves.linear);
                  
                  return ScaleTransition(
                    alignment: Alignment.bottomRight,
                    scale: animation,
                    child: child,
                  );
                },
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
                  return FormMaterial();
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
    