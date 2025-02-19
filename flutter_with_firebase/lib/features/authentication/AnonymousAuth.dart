import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnonymousAuthScreen extends StatefulWidget {
  @override
  _AnonymousAuthScreenState createState() => _AnonymousAuthScreenState();
}

class _AnonymousAuthScreenState extends State<AnonymousAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> _signInAnonymously() async {
    try {
      // Sign in anonymously
      return await _auth.signInAnonymously();
    } catch (e) {
      print("Error signing in anonymously: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anonymous Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential? user = await _signInAnonymously();
            if (user != null) {
              print("User signed in: ${user.user?.uid}");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Entered Successfully")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error entering as guest")));
            }
          },
          child: Text('Continue as Guest'),
        ),
      ),
    );
  }
}
