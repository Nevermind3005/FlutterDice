import 'package:flutter/cupertino.dart';

class DiceFace extends StatelessWidget {
  final int value;

  const DiceFace({super.key, required this.value})
    : assert(value >= 1 && value <= 6, 'Value must be between 1 and 6!');

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/T_GradientDice_$value.png',
      width: 300,
      gaplessPlayback: true,
    );
  }
}
