import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://172.18.33.23:5000/api/users'; // Replace with the URL once deployed

  // Register user
  Future<Map<String, dynamic>> registerUser(
      String username, String password, int age) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body:
          json.encode({'username': username, 'password': password, 'age': age}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  // Login user
  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Login');
    }
  }

  // Get user age
  Future<Map<String, dynamic>> getUserAge(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/get-age/$username'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user age');
    }
  }
}
