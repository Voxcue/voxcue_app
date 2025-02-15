import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _todoList.add({'text': _textController.text, 'completed': false});
        _textController.clear();
      });
    }
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoList[index]['completed'] = !_todoList[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.33,
          widthFactor: 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) {
                  if (event.isKeyPressed(LogicalKeyboardKey.enter) &&
                      !event.isShiftPressed) {
                    _addTodoItem();
                  }
                },
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a to-do item',
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addTodoItem,
                child: const Text('Add To-Do'),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        _todoList[index]['text'],
                        style: TextStyle(
                          decoration: _todoList[index]['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: _todoList[index]['completed']
                              ? Colors.black.withOpacity(0.5)
                              : Colors.black,
                        ),
                      ),
                      value: _todoList[index]['completed'],
                      onChanged: (bool? value) {
                        _toggleTodoItem(index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
