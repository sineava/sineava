import 'package:flutter/material.dart';
import 'package:pet/component/button.dart';
import '../utils/style.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg-2.png"),
          fit: BoxFit.cover,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 132),
          Text('Create your account', style: Styles.helvetica.copyWith(color: const Color(0xFF3F414E), fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 32),
          const Center(
            child: Button(type: 'outline', text: 'CONTINUE WITH FACEBOOK', btnColor: Color(0xFF7583CA), img: 'facebook.png')
          ),
          const SizedBox(height: 20),
          const Center(
            child: Button(type: 'elevate', text: 'CONTINUE WITH GOOGLE', btnColor: Color(0xFF7583CA), textColor: Color(0xFF3F414E), img: 'google.png')
          )
        ]
      )
    );
  }
}