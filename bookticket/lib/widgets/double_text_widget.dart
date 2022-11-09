import 'package:bookticket/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppDoubleTextWidget extends StatelessWidget {
  final String title;
  final String linkTitle;
  const AppDoubleTextWidget({Key? key, required this.title, required this.linkTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Styles.headLineStyle2),
        InkWell(
          onTap: () {
            print('are u okay');
          },
          child: Text(linkTitle, style: Styles.textStyle.copyWith(color: Styles.primaryColor))
        )
      ]
    );
  }
}