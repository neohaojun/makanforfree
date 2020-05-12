import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makanforfree/services/auth.dart';
import 'package:makanforfree/shared/constants.dart';
import 'package:makanforfree/shared/loading.dart';
// import 'package:makanforfree/shared/app_icons_icons.dart';

class Register  extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register > {
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
        title: Text('MakanForFree'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0,),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
                ),
                Divider(color: Colors.grey[600]),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  controller: _emailController,
                  validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password (> 6  characters)'),
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
                   color: Colors.pink[200],
                    label: Text(
                      'REGISTER WITH EMAIL',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[600])),
                    icon: Icon(
                    Icons.mail_outline,
                    color: Colors.black
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error1 = 'Please supply a valid email';
                            errorBox1 = 20.0;
                            errorBox2 = 20.0;
                            loading = false;
                          });
                        }
                      }
                    }
                  ),
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 40.0,
                  child: RaisedButton.icon(
                    color: Colors.white,
                      label: Text(
                        'CONTINUE WITH GOOGLE',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[600])),
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
                    'Have an Account? Sign In',
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
      ),
    );
  }
}