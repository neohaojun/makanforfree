import 'package:flutter/material.dart';
import 'package:makanforfree/screens/wrapper.dart';
import 'package:makanforfree/services/auth.dart';
import 'package:provider/provider.dart'; 
import 'package:makanforfree/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
