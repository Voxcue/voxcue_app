import 'package:flutter/material.dart';
import 'package:voxcue_app/data/diary.dart';

class DiaryPage extends StatefulWidget {
  final DateTime selectedDate;
  final Function(int) changeDate;

  const DiaryPage({
    super.key,
    required this.selectedDate,
    required this.changeDate,
  });

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.selectedDate;
  }

  void _changeLocalDate(int days) {
    final newDate = _currentDate.add(Duration(days: days));
    if (days > 0 && newDate.isAfter(DateTime.now())) {
      return;
    }
    setState(() {
      _currentDate = newDate;
    });
    widget.changeDate(days);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VOXCUE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            const Color.fromRGBO(20, 25, 25, 1), // Dark theme color
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.account_circle_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(20, 25, 25, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Colors.white,
                        size: 38,
                      ),
                      onPressed: () => _changeLocalDate(-1),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      _currentDate.year == DateTime.now().year &&
                              _currentDate.month == DateTime.now().month &&
                              _currentDate.day == DateTime.now().day
                          ? "Today"
                          : "${_currentDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.white,
                        size: 38,
                      ),
                      onPressed: () => _changeLocalDate(1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "A Beautiful Day",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(53, 56, 58, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  data,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
