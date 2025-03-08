import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voxcue_app/models/todo_modal.dart';
import '../models/chat_message.dart';

class ApiService {
  static const String baseUrl =
      "https://example.com/api"; // Replace with your actual API URL

  /// Fetch chat messages (GET request)
  static Future<List<ChatMessage>> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/messages'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ChatMessage.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load messages. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching messages: $e");
    }
  }

  /// Send a new message (POST request)
  static Future<ChatMessage> sendMessage(ChatMessage message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(message.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convert the received JSON response into a ChatMessage object
        Map<String, dynamic> responseData = json.decode(response.body);
        return ChatMessage.fromJson(responseData);
      } else {
        throw Exception(
            "Failed to send message. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error sending message: $e");
    }
  }

  /// Fetch all Todo items from API
  static Future<List<TodoModal>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/todos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => TodoModal.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to fetch todos. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching todos: $e");
    }
  }

  /// Send a new Todo item to the API and receive the created item
  static Future<TodoModal> createTodo(TodoModal todo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/todos'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return TodoModal.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            "Failed to create todo. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error creating todo: $e");
    }
  }
}
