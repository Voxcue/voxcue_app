import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
    return Column(
      children: [
        TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Enter a to-do item',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onSubmitted: (_) => _addTodoItem(),
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
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
