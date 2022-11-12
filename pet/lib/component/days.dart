import 'package:flutter/material.dart';
import 'package:pet/component/circle_button.dart';

class Days extends StatefulWidget {
  const Days({Key? key}) : super(key: key);

  @override
  State<Days> createState() => _DaysState();
}

class _DaysState extends State<Days> {

  Set<int> set = {0, 1, 2, 3, 6};

  void handleSet(index) {
    if (set.contains(index)) {
      set.remove(index);
    } else {
      set.add(index);
    }
    setState(() {
      set = set;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) => CircleButton(index: index, include: set.contains(index), handleSet: handleSet))
    );
  }
}