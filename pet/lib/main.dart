import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  final textStyle = const TextStyle(fontSize: 16, fontFamily: 'Airbnb', fontWeight: FontWeight.w700, letterSpacing: 2);
  final helvetica = const TextStyle(fontFamily: 'Helvetica-Neue');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Silent', style: textStyle),
                      const SizedBox(width: 10),
                      const Image(
                        image: AssetImage('images/logo.png'),
                        width: 30
                      ),
                      const SizedBox(width: 10),
                      Text('Moon', style: textStyle)
                    ]
                  ),
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
            Text('Wes are what we do', style: helvetica.copyWith(fontSize: 30, fontWeight: FontWeight.w700)),
            const SizedBox(height: 15),
            Text(
              'Thousand of people are usign silent moon\nfor smalls meditation',
              textAlign: TextAlign.center,
              style: helvetica.copyWith(height: 1.6, fontSize: 16, fontWeight: FontWeight.w300, color: const Color(0xFFA1A4B2))
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
                onPressed: () {},
                child: const Text('SIGN UP')
              )
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ALREADY HAVE AN ACCOUNT?', style: helvetica.copyWith(color: const Color(0xFFA1A4B2))),
                const SizedBox(width: 4),
                Text('LOGIN', style: helvetica.copyWith(color: const Color(0xFF8E97FD)))
              ],
            )
          ],
        )
      )
    );
  }
}