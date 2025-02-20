import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
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
      appBar: AppBar(title: Text('VOXCUE')),
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
                  ElevatedButton(onPressed: () {}, child: Text('ASK AI')),
                  ElevatedButton(onPressed: () {}, child: Text('DIARY')),
                ],
              ),

              SizedBox(height: 16), // Spacing

              // Second Component - To-Do List with fixed height
              Container(
                height: 200, // Fixed height to prevent overflow
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To-Do List",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _todoItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text(_todoItems[index]));
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
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chat with AI",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
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
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
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
