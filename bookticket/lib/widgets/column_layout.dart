import 'package:bookticket/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ColumnLayout extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final TextStyle style;
  const ColumnLayout({Key? key, required this.firstTitle, required this.secondTitle, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(firstTitle, style: style),
          Gap(AppLayout.getHeight(5)),
          Text(secondTitle, style: style)
        ],
      )
    );
  }
}