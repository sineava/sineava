import 'package:flutter/material.dart';
import 'package:pet/component/button.dart';
import 'package:pet/component/header.dart';
import 'package:pet/component/input.dart';
import 'package:pet/page/sign_up.dart';
import 'package:pet/utils/style.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class Account {
  String account = '';
  String email = '';
  String password = '';
}
Account account = Account();

class _SignInState extends State<SignIn> {
  String email = '';
  bool checked = false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Column(
          children: [
            Header(pContext: context, text: 'Welcom Back!'),
            const SizedBox(height: 20),
            Text('OR LOG IN WITH EMAIL', style: Styles.helvetica.copyWith(color: const Color(0xFFA1A4B2), fontWeight: FontWeight.w700, letterSpacing: 0.5)),
            const SizedBox(height: 20),
            Input(hintText: 'Email address', value: account.email, type: 'email'),
            const SizedBox(height: 20),
            Input(hintText: 'Password', value: account.password, type: 'password'),
            const SizedBox(height: 24),
            const Button(type: 'elevate', text: 'LOG IN', btnColor: Color(0xFF8E97FD)),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: Text('Forgot Password?', style: Styles.helvetica.copyWith(color: const Color(0xFF3F414E)))
            ),
            const SizedBox(height: 104),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ALREADY HAVE AN ACCOUNT?', style: Styles.helvetica.copyWith(color: const Color(0xFFA1A4B2))),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUp()
                      )
                    );
                  },
                  child: Text('SIGN UP', style: Styles.helvetica.copyWith(color: const Color(0xFF8E97FD)))
                )
              ],
            )
          ]
        )
      )
    );
  }
}