import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/features/authentication/AuthFunctions/AuthenticationFunctions.dart';
import 'package:flutter_with_firebase/features/authentication/Authui/fadeanimation.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  createState() => _Signup();
}

class _Signup extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  bool _isLogin = false;
  String _email = "";
  String _password = "";
  String _username = "";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Scale factor based on screen width
    double scaleFactor = screenWidth / 375; // 375 is the base width for design

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FadeAnimation(
            delay: 2.3,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://img.freepik.com/premium-vector/drawing-plant-with-pink-flowers-green-leaves_948128-1093.jpg?w=900"),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.grey,
                    Colors.blueGrey.withOpacity(0.2),
                  ]),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            child: Form(
              key: _formkey,
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          screenHeight * 0.3, // Scale based on screen height
                      child: Center(
                        child: FadeAnimation(
                          delay: 1.4,
                          child: Text(
                            !_isLogin ? "Signup" : "Login",
                            style: TextStyle(
                              fontSize: 46 * scaleFactor, // Scale font size
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Username input
                    !_isLogin
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40 * scaleFactor,
                                vertical: 10 * scaleFactor),
                            child: Container(
                              padding: EdgeInsets.only(left: 20 * scaleFactor),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.lightGreen, Colors.green]),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(17 * scaleFactor)),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return "Too small Username";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    _username = newValue!;
                                  });
                                },
                                key: ValueKey('username'),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize:
                                        18 * scaleFactor, // Scale font size
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: "Username",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    // Email input
                    FadeAnimation(
                      delay: 1.5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40 * scaleFactor,
                            vertical: 40 * scaleFactor),
                        child: Container(
                          padding: EdgeInsets.only(left: 20 * scaleFactor),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.lightGreen, Colors.green]),
                            borderRadius: BorderRadius.all(
                                Radius.circular(17 * scaleFactor)),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (!(value.toString().contains("@"))) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                _email = newValue!;
                              });
                            },
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18 * scaleFactor, // Scale font size
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: "Email",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Password input
                    FadeAnimation(
                      delay: 1.6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40 * scaleFactor,
                            vertical: 40 * scaleFactor),
                        child: Container(
                          padding: EdgeInsets.only(left: 20 * scaleFactor),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.lightGreen, Colors.green]),
                            borderRadius: BorderRadius.all(
                                Radius.circular(17 * scaleFactor)),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value.toString().length < 6) {
                                return "Too small Password";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                _password = newValue!;
                              });
                            },
                            key: ValueKey('password'),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18 * scaleFactor, // Scale font size
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: "Password",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Submit button
                    FadeAnimation(
                      delay: 1.6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40 * scaleFactor,
                            vertical: 40 * scaleFactor),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[300]),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();
                              !_isLogin
                                  ? signup(_email, _password)
                                  : signin(_email, _password);
                            } else {
                              log("form not validated");
                            }
                          },
                          child: Text(
                            _isLogin ? "Login" : "Signup",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    // Toggle login/signup text
                    FadeAnimation(
                      delay: 1.6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40 * scaleFactor,
                            vertical: 40 * scaleFactor),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            !_isLogin
                                ? "Already Signed Up? Login"
                                : "Don't have an account? Signup",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14 * scaleFactor, // Scale font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
