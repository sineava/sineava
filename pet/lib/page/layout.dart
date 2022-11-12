

import 'package:flutter/material.dart';
import 'package:pet/component/silent_moon.dart';
import 'package:pet/page/home.dart';

Widget circle(active, icon) {
  if (active) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xFF8E97FD)
      ),
      child: Center(
        child: Image(image: AssetImage('images/${icon}_icon_active.png'), width: 16)
      )
    );
  }
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      color: const Color(0xFFFFFFFF)
    ),
    child: Center(
      child: Image(image: AssetImage('images/${icon}_icon.png'), width: 16)
    )
  );
}

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int current = 0;
  List<Widget> list = const [
    Home()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: list[current],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: circle(false, 'home'),
              activeIcon: circle(true, 'home'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: circle(false, 'sleep'),
              activeIcon: circle(true, 'sleep'),
              label: 'Sleep',
            ),
            BottomNavigationBarItem(
              icon: circle(false, 'meditate'),
              activeIcon: circle(true, 'meditate'),
              label: 'Meditate',
            ),
            BottomNavigationBarItem(
              icon: circle(false, 'music'),
              activeIcon: circle(true, 'music'),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: circle(false, 'afsar'),
              activeIcon: circle(true, 'afsar'),
              label: 'Afsar',
            ),
          ],
          currentIndex: current,
          selectedItemColor: const Color(0xFF8E97FD),
          unselectedItemColor: const Color(0xFFA0A3B1),
          onTap: (index) { setState(() { current = index; }); }
        )
      )
    );
  }
}