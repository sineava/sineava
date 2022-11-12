import 'package:flutter/material.dart';
import 'package:pet/component/silent_moon.dart';
import 'package:pet/page/sign_in.dart';
import 'package:pet/page/sign_up.dart';
import 'package:pet/utils/style.dart';

class Sign extends StatelessWidget {
  const Sign({Key? key}) : super(key: key);
  final textStyle = const TextStyle(fontSize: 16, fontFamily: 'Airbnb', fontWeight: FontWeight.w700, letterSpacing: 2);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            children: [
              const SizedBox(height: 55),
              const SilentMoon(),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('images/illustration.png'), width: 332)
                ]
              )
            ]
          )
        ),
        const SizedBox(height: 30),
        Text('We are what we do', style: Styles.helvetica.copyWith(fontSize: 30, fontWeight: FontWeight.w700)),
        const SizedBox(height: 15),
        Text(
          'Thousand of people are usign silent moon\nfor smalls meditation',
          textAlign: TextAlign.center,
          style: Styles.helvetica.copyWith(height: 1.6, fontSize: 16, fontWeight: FontWeight.w300, color: const Color(0xFFA1A4B2))
        ),
        const SizedBox(height: 62),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF8E97FD),
              minimumSize: const Size(374, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              )
            ),
            // style: ButtonStyle(, ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignUp()
                )
              );
            },
            child: const Text('SIGN UP')
          )
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ALREADY HAVE AN ACCOUNT?', style: Styles.helvetica.copyWith(color: const Color(0xFFA1A4B2))),
            const SizedBox(width: 4),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignIn()
                  )
                );
              },
              child: Text('LOG IN', style: Styles.helvetica.copyWith(color: const Color(0xFF8E97FD)))
            )
          ],
        )
      ],
    );
  }
}