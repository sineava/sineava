import 'package:flutter/material.dart';
import '../utils/style.dart';

class Button extends StatelessWidget {
  final String type;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final String? img;
  const Button({Key? key, required this.type, required this.text, this.btnColor, this.textColor, this.img}) : super(key: key);

  dynamic show() {
    return SizedBox(
      width: 24,
      child: Center(
        child: Image(
          height: 24,
          image: AssetImage('images/$img')
        )
      )
    );
  }

  Widget getChild() {
    return Center(
      child: Row(
        children: [
          const SizedBox(width: 34),
          show(),
          const SizedBox(width: 46),
          Text(text, style: Styles.helvetica.copyWith(fontWeight: FontWeight.w600, color: textColor ?? const Color(0xFFF6F1FB)))
        ]
      )
    );
  }

  Widget getBtn() {
    if (type == 'outline') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: btnColor ?? const Color(0xFFFFFFFF),
          maximumSize: const Size(374, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          )
        ),
        // style: ButtonStyle(, ),
        onPressed: () {},
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