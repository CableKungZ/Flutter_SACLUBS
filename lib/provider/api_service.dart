import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "http://10.53.1.65/flutter"; // Replace with your actual server URL

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login2.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password,
      String phoneNumber, String studentId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register2.php'),
      body: {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'studentId': studentId,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<List<dynamic>> fetchActivities() async {
    final response =
        await http.get(Uri.parse('$baseUrl/activityhelper.php?action=fetch'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch activities');
    }
  }

  // Add more methods for other actions like updateActivity, deleteActivity, joinActivity, etc.
}
