import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makanforfree/services/auth.dart';
import 'package:makanforfree/shared/constants.dart';
import 'package:makanforfree/shared/loading.dart';
// import 'package:makanforfree/shared/app_icons_icons.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() { 
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error1 = '';
  String error2 = '';
  double errorBox1 = 0.0;
  double errorBox2 = 0.0;
  double errorBox3 = 0.0;
  double errorBox4 = 0.0;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.red,
      //   elevation: 0.0,
      //   title: Text('MakanForFree'),
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0,),
        child: Form(
          key: _formKey,
          // child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: 20.0),
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0, color: Color(0xff224966)),
                  ),
                ),
                SizedBox(height: 3.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Sign in to Continue',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Email', 
                    prefixIcon: Icon(Icons.mail_outline),
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600], width: 1.0)
                    ),
                  ),
                  controller: _emailController,
                  validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600], width: 1.0)
                    ),
                  ),
                  controller: _passwordController,
                  validator: (val) => val.length < 6 ? 'Password must be at least 6 characters' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  }
                ),
                SizedBox(height: errorBox1),
                Text(
                  error1,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                SizedBox(height: errorBox2),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 40.0,
                  child: RaisedButton.icon(
                   color: Color(0xff224966),
                    label: Text(
                      'SIGN IN WITH EMAIL',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[600]),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error1 = 'Sorry, your password or email was incorrect.';
                            errorBox1 = 20.0;
                            errorBox2 = 20.0;
                            loading = false;
                          });
                        }
                      }
                    }
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(color: Colors.grey[600],)
                    ),
                    Text("       OR       "),
                    Expanded(
                      child: Divider(color: Colors.grey[600],)
                    ),
                  ]
                ),
                SizedBox(height: 10.0),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 40.0,
                  child: RaisedButton.icon(
                    color: Colors.white,
                    label: Text(
                      'CONTINUE WITH GOOGLE',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[600]),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/google_search.svg",
                      height: 18.0
                    ),
                    onPressed: () async {
                    bool res = await _auth.signInWithGoogle();
                    if(!res)
                      error2 = "Error signing in with google";
                      errorBox3 = 20.0;
                      errorBox4 = 20.0;
                      setState(() => loading = false);
                    },
                  ),
                ),
                SizedBox(height: errorBox3),
                Text(
                  error2,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                SizedBox(height: errorBox4),
                FlatButton(
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: Colors.blue),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  onPressed: () {
                   widget.toggleView();
                  }
                ),
              ],
            ),
          ),
        ),
      );
    // );
  }
}