import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voxcue_app/models/todo_modal.dart';
import '../models/chat_message.dart';
import '../models/ai_response.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5000'; // Using 10.0.2.2 to access host localhost from Android emulator
  String? authToken; // Auth token will be set after login

  void setAuthToken(String token) {
    authToken = token;
  }

  /// Login method to authenticate and get the auth token
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
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception('Failed to login: ${responseBody['error']}');
    }
  }

  /// Register method to create a new user
Future<void> register(String username, String password) async {
  final url = Uri.parse('$baseUrl/auth/register');

  print('Sending POST request to $url'); 
  print('Headers: ${jsonEncode({'Content-Type': 'application/json'})}');
  print('Body: ${jsonEncode({'username': username, 'password': password})}');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      authToken = responseBody['token'];
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception('Failed to register: ${responseBody['error']}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


  /// Fetch chat messages (GET request)
  Future<List<ChatMessage>> fetchMessages() async {
    final url = Uri.parse('$baseUrl/messages');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  /// Send a new message (POST request)
  Future<ChatMessage> sendMessage(ChatMessage message) async {
    final url = Uri.parse('$baseUrl/messages');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(message.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return ChatMessage.fromJson(responseData);
    } else {
      throw Exception('Failed to send message');
    }
  }

  /// Fetch all Todo items from API
  Future<List<TodoModal>> fetchTodos() async {
    final url = Uri.parse('$baseUrl/todos');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TodoModal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  /// Send a new Todo item to the API and receive the created item
  Future<TodoModal> createTodo(TodoModal todo) async {
    final url = Uri.parse('$baseUrl/todos');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return TodoModal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo');
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
      throw Exception('Failed to get AI response');
    }
  }

  Stream<String> getStreamingResponse(String prompt) async* {
      if (authToken == null) {
        throw Exception('Auth token is not set');
      }
  
      final url = Uri.parse('$baseUrl/stream');
      final request = http.Request('POST', url);
      
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      });
      
      request.body = jsonEncode({'prompt': prompt});
  
      final streamedResponse = await request.send();
  
      if (streamedResponse.statusCode == 200) {
        await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
          yield chunk;
        }
      } else {
        throw Exception('Failed to get streaming response: ${streamedResponse.statusCode}');
      }

  }
  
}
