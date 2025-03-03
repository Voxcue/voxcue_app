import 'package:flutter/material.dart';
import 'diary_page.dart';

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
  final TextEditingController _chatControllerAI = TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  final List<String> _chatMessagesAI = [];
  final List<String> _chatMessages = [];
  final List<String> _todoItems = List.generate(
      20, (index) => "Task ${index + 1}"); // Simulating large data

  bool _isChatVisible = false;

  void _sendMessageAI() {
    if (_chatControllerAI.text.trim().isNotEmpty) {
      setState(() {
        _chatMessagesAI.add("User: ${_chatControllerAI.text}");
        _chatMessagesAI.add("AI: This is a sample response.");
      });
      _chatControllerAI.clear();
    }
  }

  void _sendMessage() {
    if (_chatController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.add("User: ${_chatController.text}");
        _chatMessages.add("AI: This is a sample response.");
      });
      _chatController.clear();
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

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
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
                      onPressed: _toggleChatVisibility,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(238, 158, 110,
                            1), // Background color // Text and icon color
                      ),
                      child: Text(
                        'ASK AI',
                        style: TextStyle(color: Color.fromRGBO(34, 39, 38, 1)),
                      )),
                  ElevatedButton(
                      onPressed: () => _navigateToDiaryPage(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(238, 158, 110, 1)),
                      child: Text(
                        'DIARY',
                        style: TextStyle(color: Color.fromRGBO(34, 39, 38, 1)),
                      )),
                ],
              ),

              SizedBox(height: 16), // Spacing

              // Fourth Component - New Chat Area
              if (_isChatVisible)
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
                          itemCount: _chatMessagesAI.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(_chatMessagesAI[index]),
                            );
                          },
                        ),
                      ),
                      TextField(
                        controller: _chatControllerAI,
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
                            onPressed: _sendMessageAI,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    Text("Chat Area",
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
