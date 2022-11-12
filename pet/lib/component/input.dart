import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final String hintText;
  final String type;
  String value = '';
  Input({Key? key, required this.hintText, required this.value, required this.type}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool status = true;

  AssetImage judge() {
    if (widget.type != 'password') return const AssetImage('images/success.png');
    if (status) return const AssetImage('images/close_eye.png');
    return const AssetImage('images/open_eye.png');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F7),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(
        child: TextFormField(
          obscureText: widget.type == 'password' && status,
          initialValue: widget.value,
          onChanged: (text) {
            setState(() { widget.value = text; });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Color(0xFFA1A4B2)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  status = !status;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: widget.value == '' ? null : Image(image: judge(), height: 10)
              )
            )
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(30)
          ]
        )
      ),
    );
  }
}