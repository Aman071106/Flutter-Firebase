import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

//signup
void signup(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    log("successfully created user in db");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      log(e.toString());
    } else if (e.code == "email-already-in-use") {
      log(e.toString());
    }
  } catch (e) {
    log(e.toString());
  }
}

//signin
void signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    log("successfully logging in");
  } catch (e) {
    log(e.toString());
  }
}
