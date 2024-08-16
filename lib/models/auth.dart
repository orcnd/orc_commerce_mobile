import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orc_commerce_mobile/api_config.dart';

class Auth {
  static final Auth _instance = Auth._internal();

  factory Auth() {
    return _instance;
  }

  Auth._internal();

  String? token;
  User? user;

  Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse(ApiConfig.loginUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token = data;
        return await _fetchUser(); // Fetch user details after login
      } else {
        if (response.statusCode == 422 || response.statusCode == 401) {
          final data = jsonDecode(response.body);
          return AuthResponse(
            status: false,
            message: data['message'] ?? "Invalid credentials",
          );
        }
        return AuthResponse(
          status: false,
          message: "Server Error: ${response.statusCode}",
        );
      }
    } catch (e) {
      return AuthResponse(
        status: false,
        message: "Request failed: $e",
      );
    }
  }

  Future<AuthResponse> _fetchUser() async {
    final url = Uri.parse(ApiConfig.meUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user = User(
          name: data['name'],
          email: data['email'],
          role: 'admin',
        );
        return AuthResponse(
          status: true,
          message: "User details fetched successfully",
          user: user,
        );
      } else {
        return AuthResponse(
          status: false,
          message: "Failed to fetch user details: ${response.statusCode}",
        );
      }
    } catch (e) {
      return AuthResponse(
        status: false,
        message: "Request failed: $e",
      );
    }
  }

  void logout() {
    token = null;
    user = null;
  }
}

class User {
  final String? name;
  final String? email;
  final String? role;

  User({this.name, this.email, this.role});
}

class AuthResponse {
  bool status;
  String? message;
  User? user;

  AuthResponse({required this.status, this.message, this.user});
}
