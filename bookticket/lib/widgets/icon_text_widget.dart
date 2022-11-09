

import 'package:bookticket/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_style.dart';

class AppIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const AppIconText({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(8), horizontal: AppLayout.getWidth(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppLayout.getWidth(5)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFBFC2DF)),
          Gap(AppLayout.getWidth(10)),
          Text(text, style: Styles.textStyle)
        ],
      )
    );
  }
}