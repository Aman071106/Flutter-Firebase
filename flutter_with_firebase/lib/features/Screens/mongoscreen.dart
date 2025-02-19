import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/Functions/mongoAPI/apimethods.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();

  String? _errorMessage;
  String? _userAge;

  // Register function
  Future<void> _registerUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final age = int.tryParse(_ageController.text);

    if (username.isEmpty || password.isEmpty || age == null) {
      setState(() {
        _errorMessage = "Please fill in all fields!";
      });
      return;
    }

    try {
      final response = await ApiService().registerUser(username, password, age);
      setState(() {
        _errorMessage = response['message'] ?? "Registration failed!";
      });
    } catch (error) {
      setState(() {
        log(error.toString());
        _errorMessage = "Error: $error";
      });
    }
  }

  // Login function
  Future<void> _loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in both fields!";
      });
      return;
    }

    try {
      final response = await ApiService().loginUser(username, password);
      setState(() {
        _errorMessage = response['message'] ?? "Login failed!";
      });
    } catch (error) {
      setState(() {
        log(error.toString());
        _errorMessage = "Error: $error";
      });
    }
  }

  // Get user age
  Future<void> _getUserAge() async {
    final username = _usernameController.text;

    if (username.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a username!";
      });
      return;
    }

    try {
      final response = await ApiService().getUserAge(username);
      setState(() {
        _userAge = response['age'].toString();
        _errorMessage = null;
      });
    } catch (error) {
      setState(() {
        log(error.toString());
        _errorMessage = "Error: $error";
        _userAge = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter User Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: _errorMessage,
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _errorMessage,
              ),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age (for registration)',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loginUser,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getUserAge,
              child: Text('Get Age'),
            ),
            SizedBox(height: 20),
            if (_userAge != null)
              Text(
                'User Age: $_userAge',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
