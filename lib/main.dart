import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrentTimeDisplay(),
    );
  }
}

class CurrentTimeDisplay extends StatefulWidget {
  @override
  _CurrentTimeDisplayState createState() => _CurrentTimeDisplayState();
}

class _CurrentTimeDisplayState extends State<CurrentTimeDisplay> {
  late Timer _timer;
  String _currentTime = '';
  final List<Color> _colors = List.generate(50, (_) => getRandomColor());

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = "${now.hour.toString().padLeft(2, '0')}:"
          "${now.minute.toString().padLeft(2, '0')}:"
          "${now.second.toString().padLeft(2, '0')}";
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  static Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Time with Random Container Colors')),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 50,
            itemBuilder: (context, index) {
              return Container(
                height: 200,
                color: _colors[index],
                child: Center(child: Text('Entry $index')),
              );
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              child: Text(
                'Current Time: $_currentTime',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
