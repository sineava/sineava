import 'package:flutter/material.dart';
import 'package:pet/component/button.dart';
import 'package:pet/component/input.dart';
import 'package:pet/page/choose_topic.dart';
import 'package:pet/utils/style.dart';
import '../component/header.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class Account {
  String username = '';
  String email = '';
  String password = '';
}
Account account = Account();

class _SignUpState extends State<SignUp> {
  bool checked = false;
  
  @override
  Widget build(BuildContext context) {

    // 处理按钮点击
    void handleBtn() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ChooseTopic()
        )
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Column(
          children: [
            Header(pContext: context, text: 'Create your account'),
            const SizedBox(height: 20),
            Text('OR LOG IN WITH EMAIL', style: Styles.helvetica.copyWith(color: const Color(0xFFA1A4B2), fontWeight: FontWeight.w700, letterSpacing: 0.5)),
            const SizedBox(height: 20),
            Input(hintText: 'Username', value: account.username, type: 'text'),
            const SizedBox(height: 20),
            Input(hintText: 'Email address', value: account.email, type: 'email'),
            const SizedBox(height: 20),
            Input(hintText: 'Password', value: account.password, type: 'password'),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('i have read the', style: Styles.helvetica.copyWith(color: const Color(0xFFA1A4B2), fontSize: 14)),
                      const SizedBox(width: 2),
                      Text('Privace Policy', style: Styles.helvetica.copyWith(color: const Color(0xFF7583CA), fontSize: 14)),
                    ],
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    value: checked,
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xFFA1A4B2),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        checked = value!;
                      });
                    },
                  )
                ]
              ),
            ),
            const SizedBox(height: 32),
            Button(type: 'elevate', text: 'GET STARTED', btnColor: const Color(0xFF8E97FD), fn: handleBtn)
          ]
        )
      )
    );
  }
}