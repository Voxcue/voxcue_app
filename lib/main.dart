import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: const Color.fromRGBO(34, 39, 38, 1),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _chatController = TextEditingController();
  final List<String> _chatMessages = [];
  final List<String> _todoItems = List.generate(
      20, (index) => "Task ${index + 1}"); // Simulating large data

  void _sendMessage() {
    if (_chatController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.add("User: ${_chatController.text}");
        _chatMessages.add("AI: This is a sample response.");
      });
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VOXCUE',
          style: TextStyle(
            color: Colors.white, // White text color
            fontSize: 20, // Adjust font size if needed
            fontWeight: FontWeight.bold, // Optional: Makes text bold
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color.fromRGBO(34, 39, 38, 255),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(238, 158, 110,
                            1), // Background color // Text and icon color
                      ),
                      child: Text(
                        'ASK AI',
                        style: TextStyle(color: Color.fromRGBO(34, 39, 38, 1)),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(238, 158, 110, 1)),
                      child: Text(
                        'DIARY',
                        style: TextStyle(color: Color.fromRGBO(34, 39, 38, 1)),
                      )),
                ],
              ),

              SizedBox(height: 16), // Spacing

              // Second Component - To-Do List with fixed height
              Container(
                height: 200, // Fixed height to prevent overflow
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 56, 58, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To-Do List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _todoItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(_todoItems[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                  )));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16), // Spacing

              // Third Component - Chat Area with fixed height
              Container(
                height: 300, // Fixed height to ensure space for chat input
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 56, 58, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chat with AI",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _chatMessages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(_chatMessages[index]),
                          );
                        },
                      ),
                    ),
                    TextField(
                      controller: _chatController,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(200, 255, 255, 255),
                              width: 2), // Active border
                        ),
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(163, 255, 255, 255)),
                        hintText: "Type your message...",
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send,
                              color: const Color.fromRGBO(238, 158, 110, 1)),
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
