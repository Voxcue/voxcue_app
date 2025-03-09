// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voxcue_app/services/api_services.dart';
import 'package:voxcue_app/models/chat_message.dart';
import 'package:voxcue_app/models/todo_modal.dart';
import 'package:voxcue_app/models/ai_response.dart';
import 'diary_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _chatControllerAI = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  final List<String> _chatMessagesAI = [];
  List<String> _chatMessages = [];
  List<TodoModal> _todoItems = [];

  bool _isChatVisible = false;

  @override
  void initState() {
    super.initState();
    fetchTodoItems();
  }


  Future<void> fetchTodoItems() async {
    try {
      List<TodoModal> todos = await _apiService.getTodosForDate(DateTime.now().toIso8601String());
      setState(() {
        _todoItems = todos;
      });
    } catch (e) {
      print("Error fetching todos: $e");
    }
  }

  void _sendMessageAI() async {
    if (_chatControllerAI.text.trim().isNotEmpty) {
      try {
        AIResponse response = await _apiService.getAIResponse(_chatControllerAI.text);
        setState(() {
          _chatMessagesAI.add("User: ${_chatControllerAI.text}");
          _chatMessagesAI.add("AI: ${response.answer}");
        });
        _chatControllerAI.clear();
      } catch (e) {
        print("Error getting AI response: $e");
      }
    }
  }

  void _sendMessage() async {
    if (_chatController.text.trim().isNotEmpty) {
      try {
        final response = await _apiService.postDiaryEntry(
          _chatController.text,
          DateTime.now().toIso8601String(),
        );
        setState(() {
          _chatMessages.add("User: ${_chatController.text}");
          if (response.containsKey('question')) {
            _chatMessages.add("AI: ${response['question']}");
          } else if (response.containsKey('message')) {
            _chatMessages.add("AI: ${response['message']}");
          }
        });
        _chatController.clear();
      } catch (e) {
        print("Error posting diary entry: $e");
      }
    }
  }

  void _toggleChatVisibility() {
    setState(() {
      _isChatVisible = !_isChatVisible;
    });
  }

  void _navigateToDiaryPage(BuildContext context) {
    Navigator.of(context).push(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DiaryPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // void _addTodoItem() async {
  //   try {
  //     await _apiService.postTodoItem(DateTime.now().toIso8601String());
  //     fetchTodoItems(); // Refresh the todo list
  //   } catch (e) {
  //     print("Error adding todo: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VOXCUE', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(34, 39, 38, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(34, 39, 38, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Makes whole page scrollable
          child: Column(
            children: [
              // First Component - Two Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: _toggleChatVisibility,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(238, 158, 110,
                            1), // Background color // Text and icon color
                      ),
                      child: const Text(
                        'ASK AI',
                        style: TextStyle(color: Color.fromRGBO(34, 39, 38, 1)),
                      )),
                  ElevatedButton(
                      onPressed: () => _navigateToDiaryPage(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(238, 158, 110, 1)),
                      child: const Text(
                        'DIARY',
                        style: TextStyle(color: Color.fromRGBO(34, 39, 38, 1)),
                      )),
                ],
              ),

              const SizedBox(height: 16), // Spacing

              // Fourth Component - New Chat Area
              if (_isChatVisible)
                Container(
                  height: 300, // Fixed height to ensure space for chat input
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(53, 56, 58, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Chat with AI",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _chatMessagesAI.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                _chatMessagesAI[index],
                                style: const TextStyle(color: Colors.white60),
                              ),
                            );
                          },
                        ),
                      ),
                      TextField(
                        controller: _chatControllerAI,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(200, 255, 255, 255),
                                width: 2), // Active border
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(163, 255, 255, 255)),
                          hintText: "Type your message...",
                          border: const OutlineInputBorder(),
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send,
                                color: Color.fromRGBO(238, 158, 110, 1)),
                            onPressed: _sendMessageAI,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16), // Spacing

              // Second Component - To-Do List with fixed height
              Container(
                height: 200, // Fixed height to prevent overflow
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 56, 58, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("To-Do List",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.bold)),
                    //     IconButton(
                    //       icon: const Icon(Icons.add, color: Color.fromRGBO(238, 158, 110, 1)),
                    //       onPressed: _addTodoItem,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _todoItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(_todoItems[index].title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16), // Spacing

              // Third Component - Chat Area with fixed height
              Container(
                height: 300, // Fixed height to ensure space for chat input
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 56, 58, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Chat Area",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _chatMessages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _chatMessages[index],
                              style: const TextStyle(color: Colors.white60),
                            ),
                          );
                        },
                      ),
                    ),
                    TextField(
                      controller: _chatController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(200, 255, 255, 255),
                              width: 2), // Active border
                        ),
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(163, 255, 255, 255)),
                        hintText: "Type your message...",
                        border: const OutlineInputBorder(),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send,
                              color: Color.fromRGBO(238, 158, 110, 1)),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

