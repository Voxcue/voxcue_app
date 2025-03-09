import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voxcue_app/models/todo_modal.dart';
import '../models/ai_response.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = 'http://localhost:5000'; // Update with your backend URL
  String? authToken; // Auth token will persist across calls

  void setAuthToken(String token) {
    authToken = token;
  }

  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      authToken = responseBody['token'];
      print("Auth Token Set: $authToken"); // Debugging print
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception('Failed to login: ${responseBody['error']}');
    }
  }

  Future<void> register(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      authToken = responseBody['token'];
      print("Auth Token Set After Registration: $authToken");
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception('Failed to register: ${responseBody['error']}');
    }
  }

  Future<AIResponse> getAIResponse(String question) async {
    if (authToken == null) {
      throw Exception('Auth token is not set');
    }

    final url = Uri.parse('$baseUrl/api/query');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'question': question}),
    );

    if (response.statusCode == 200) {
      return AIResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to get AI response: ${response.statusCode} ${response.body}');
      throw Exception('Failed to get AI response');
    }
  }

  Future<Map<String, dynamic>> postDiaryEntry(String content, String date) async {
    if (authToken == null) {
      throw Exception('Auth token is not set');
    }

    final url = Uri.parse('$baseUrl/api/diary');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'content': content, 'date': date}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to post diary entry: ${response.statusCode} ${response.body}');
      throw Exception('Failed to post diary entry');
    }
  }

  Future<void> postTodoItem(String date) async {
    if (authToken == null) {
      throw Exception('Auth token is not set');
    }

    final url = Uri.parse('$baseUrl/api/todo');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'date': date}),
    );

    if (response.statusCode != 200) {
      print('Failed to post todo item: ${response.statusCode} ${response.body}');
      throw Exception('Failed to post todo item');
    }
  }

  Future<List<TodoModal>> getTodosForDate(String date) async {
    if (authToken == null) {
      throw Exception('Auth token is not set');
    }

    final url = Uri.parse('$baseUrl/api/gettodos');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'date': date}),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body)['todos'];
      return jsonList.map((json) => TodoModal.fromJson(json)).toList();
    } else {
      print('Failed to fetch todos for date: ${response.statusCode} ${response.body}');
      throw Exception('Failed to fetch todos for date');
    }
  }
}
