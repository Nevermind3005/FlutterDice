import 'dart:async';
import 'dart:math';

import 'package:dice_roll/dice_face.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: const MyHomePage(title: 'Roll a dice!'),
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
  static const _tick = Duration(milliseconds: 20);
  static const _totalTicks = 25;

  final _rnd = Random();
  Timer? _timer;
  int _diceValue = 1;
  bool _bRoling = false;

  @override
  void initState() {
    _diceValue = _generateNextRoll();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _roll() {
    if (_bRoling) {
      return;
    }
    setState(() {
      _bRoling = true;
    });

    _timer = Timer.periodic(_tick, (timer) {
      setState(() {
        _diceValue = _generateNextRoll();
      });

      if (timer.tick >= _totalTicks) {
        timer.cancel();
        setState(() {
          _bRoling = false;
        });
      }
    });

    setState(() {
      _diceValue = _generateNextRoll();
    });
  }

  int _generateNextRoll() {
    return _rnd.nextInt(6) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Roll a dice')),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedRotation(
                  turns: _bRoling ? 1 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: DiceFace(value: _diceValue),
                ),
              ),
            ),
            CupertinoButton.filled(
              onPressed: !_bRoling ? () => _roll() : null,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.casino_outlined, size: 28),
                  SizedBox(width: 8),
                  Text(
                    'Roll',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight(350)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
