import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/features/Screens/DatabaseView.dart';
import 'package:flutter_with_firebase/features/Screens/mongoscreen.dart';
import 'package:flutter_with_firebase/features/authentication/AnonymousAuth.dart';
import 'package:flutter_with_firebase/features/authentication/Authui/AuthenticationForm.dart';
import 'package:flutter_with_firebase/features/authentication/googleAuth.dart';
import 'package:flutter_with_firebase/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //appcheck
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity, // For Android
    appleProvider: AppleProvider.deviceCheck, // For iOS
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Signup());
  }
}
