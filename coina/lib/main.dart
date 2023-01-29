import 'package:coina/widgets/home.dart';
import 'package:coina/widgets/mine.dart';
import 'package:flutter/material.dart';
import 'package:coina/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> list = [
    const HomeWidget(),
    const Text('消息'),
    const Mine()
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: list[current],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: current,
          onTap: (int index) {
            setState(() {
              current = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: '首页', icon: Image(image: AssetImage('assets/images/home.png'), width: 24), activeIcon: Image(image: AssetImage('assets/images/home-active.png'), width: 24)),
            BottomNavigationBarItem(label: '消息', icon: Image(image: AssetImage('assets/images/message.png'), width: 24), activeIcon: Image(image: AssetImage('assets/images/message-active.png'), width: 24)),
            BottomNavigationBarItem(label: '我的', icon: Image(image: AssetImage('assets/images/me.png'), width: 24), activeIcon: Image(image: AssetImage('assets/images/me-active.png'), width: 24))
          ],
        ),
      )
    );
  }
}