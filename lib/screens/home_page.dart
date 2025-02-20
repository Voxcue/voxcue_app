import 'package:flutter/material.dart';
import '../components/todo_list.dart';
import '../components/chat/chat_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(7, 21, 31, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(67, 97, 238, 1),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your button action here
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(163, 33),
                    backgroundColor: const Color(0xffe8f7fe),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 0, // Remove shadow
                  ),
                  child: const Text(
                    "ASK AI",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors
                          .black, // Since background is light, text should be dark
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your button action here
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(163, 33),
                    backgroundColor: const Color(0xffe8f7fe),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 0, // Remove shadow
                  ),
                  child: const Text(
                    "DIARY",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors
                          .black, // Since background is light, text should be dark
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromRGBO(32, 41, 85, 0.5),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const TodoList(),
          ),
          const Expanded(
            child: ChatScreen(),
          ),
        ],
      ),
    );
  }
}
