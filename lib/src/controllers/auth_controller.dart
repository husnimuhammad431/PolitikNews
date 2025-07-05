import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:politic_news/src/models/auth_model.dart';

class AuthService {
  final String baseUrl = 'http://45.149.187.204:3000/api/auth';

  Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final body = LoginRequest(email: email, password: password).toJson();

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(responseData);
    } else {
      final errorBody = responseData['body'] ?? responseData;
      throw Exception(errorBody['message'] ?? 'Login failed');
    }
  }

  Future<ProfileResponse> getProfile(String token) async {
    final url = Uri.parse('$baseUrl/me');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ProfileResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get profile: ${response.statusCode}');
    }
  }
}
