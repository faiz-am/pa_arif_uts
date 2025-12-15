import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Pastikan port backend benar (5001)
   static const String baseUrl = "http://127.0.0.1:5001/api";

  // Login Manual
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'status': true, 'data': data['user'], 'message': data['message']};
      } else {
        return {'status': false, 'message': data['message']};
      }
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  // Register Manual
  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {'status': true, 'message': data['message']};
      } else {
        return {'status': false, 'message': data['message']};
      }
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  // Google Auth (Login & Register jadi satu di backend)
  static Future<Map<String, dynamic>> googleAuthBackend(String email, String name, String googleId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/google-auth'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "name": name,
          "google_id": googleId
        }),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
         return {'status': true, 'data': data['user'], 'message': data['message']};
      } else {
        return {'status': false, 'message': "Gagal login google ke backend"};
      }
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  // === FUNGSI TAMBAHAN UNTUK FIX ERROR MAIN.DART & PROFILE ===
  
  static Future<void> saveUserSession(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_login', true);
    await prefs.setString('user_name', user['name']);
    await prefs.setString('user_email', user['email']);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_login') ?? false;
  }

  static Future<Map<String, String>> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('user_name') ?? "No Name",
      'email': prefs.getString('user_email') ?? "No Email",
    };
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}