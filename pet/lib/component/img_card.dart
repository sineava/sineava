import 'package:flutter/material.dart';
import 'package:pet/page/reminders.dart';
import 'package:pet/utils/style.dart';

class ImgCard extends StatelessWidget {
  final String img;
  final Color bgColor;
  final String text;
  const ImgCard({Key? key, required this.img, required this.bgColor, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Reminders()
          )
        );
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.only(left: 12, bottom: 14),
        width: 176,
        height: 210,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('images/$img'),
            fit: BoxFit.cover
          )
        ),
        child: Text(text, style: Styles.helvetica.copyWith(color: const Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.w700))
      )
    );
  }
}