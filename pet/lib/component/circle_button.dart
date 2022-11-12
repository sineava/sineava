import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final int index;
  bool include;
  Function handleSet;
  CircleButton({Key? key, required this.index, required this.include, required this.handleSet}) : super(key: key);

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  List list = ['SU', 'M', 'T', 'W', 'TH', 'F', 'S'];
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget.include ? const Color(0xFF3F414E) : Colors.white,
        shadowColor: Colors.transparent,
        minimumSize: const Size(40, 40),
        shape: const CircleBorder(),
        side: const BorderSide(color: Color(0xFFA1A4B2))
      ),
      onPressed: () {
        widget.handleSet(widget.index);
      },
      child: Text(list[widget.index], style: TextStyle(color: widget.include ?Colors.white :const Color(0xFFA1A4B2)))
    );
  }
}