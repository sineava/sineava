import 'package:flutter/material.dart';

class SilentMoon extends StatelessWidget {
  const SilentMoon({Key? key}) : super(key: key);
  final textStyle = const TextStyle(fontSize: 16, fontFamily: 'Airbnb', fontWeight: FontWeight.w700, letterSpacing: 2);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Silent', style: textStyle),
        const SizedBox(width: 10),
        const Image(
          image: AssetImage('images/logo.png'),
          width: 30
        ),
        const SizedBox(width: 10),
        Text('Moon', style: textStyle)
      ]
    );
  }
}