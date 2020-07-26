// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makanforfree/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool googleTrue = false;

  //create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with google
  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult result =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      googleTrue = true;
      // FirebaseUser user = result.user;
      if (result.user == null) return false;
      return true;
    } catch (e) {
      print(e.toString());
      print("Error logging with google");
      return false;
    }
  }

  //sign out
  Future signOut() async {
    try {
      if (googleTrue == true) {}
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      googleTrue = false;
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
