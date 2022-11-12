import 'package:flutter/material.dart';
import '../utils/style.dart';

class Button extends StatefulWidget {
  final String type;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final String? img;
  final Function? fn;
  const Button({Key? key, required this.type, required this.text, this.btnColor, this.textColor, this.img, this.fn}) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
   Widget getChild() {
    if (widget.img == null) {
      return Center(
        child: Text(widget.text, style: Styles.helvetica.copyWith(fontWeight: FontWeight.w600, color: widget.textColor ?? const Color(0xFFF6F1FB)))
      );
    }
    return Center(
      child: Row(
        children: [
          const SizedBox(width: 34),
          SizedBox(
            width: 24,
            child: Center(
              child: Image(
                height: 24,
                image: AssetImage('images/${widget.img}')
              )
            )
          ),
          const SizedBox(width: 46),
          Text(widget.text, style: Styles.helvetica.copyWith(fontWeight: FontWeight.w600, color: widget.textColor ?? const Color(0xFFF6F1FB)))
        ]
      )
    );
  }

  Widget getBtn() {
    if (widget.type == 'elevate') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: widget.btnColor ?? const Color(0xFFFFFFFF),
          maximumSize: const Size(374, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          )
        ),
        // style: ButtonStyle(, ),
        onPressed: () {
          widget.fn!();
        },
        child: getChild()
      );
    }
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(374, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        )
      ),
      onPressed: () {},
      child: getChild()
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBtn();
  }
}
