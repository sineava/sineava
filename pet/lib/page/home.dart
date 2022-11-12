import 'package:flutter/material.dart';
import 'package:pet/component/silent_moon.dart';
import 'package:pet/utils/style.dart';

Widget container({ color, textColor, btnSpanColor, bg, title, subTitle, size }) {
  return Container(
    width: 170,
    height: 220,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12)
    ),
    child: Stack(
      children: [
        Positioned(
          right: -10,
          top: -2,
          child: Image(image: AssetImage('images/$bg'), width: size)
        ),
        Positioned(
          left: 20,
          bottom: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Styles.titleStyle.copyWith(color: textColor)),
              const SizedBox(height: 10),
              Text(subTitle, style: Styles.titleStyle.copyWith(color: textColor, fontSize: 11)),
              const SizedBox(height: 32),
              Row(
                children: [
                  Text('3-10 MIN', style: Styles.titleStyle.copyWith(color: textColor, fontSize: 11)),
                  const SizedBox(width: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: textColor,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),
                    child: Text('START', style: Styles.titleStyle.copyWith(color: btnSpanColor, fontSize: 12)),
                  )
                ]
              )
            ],
          )
        )
      ],
    )
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const SilentMoon(),
          const SizedBox(height: 40),
          Text('Good Moorning, Asfar', style: Styles.titleStyle),
          Text('We Wish you have a good day', style: Styles.subTitleStyle),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              container(
                color: const Color(0xFF8E97FD),
                textColor: const Color(0xFFEBEAEC),
                btnSpanColor: const Color(0xFF3F414E),
                bg: 'topic-bg-7.png',
                size: 118.0,
                title: 'Basics',
                subTitle: 'COURSE'
              ),
              container(
                color: const Color(0xFFFFC97E),
                textColor: const Color(0xFF3F414E),
                btnSpanColor: const Color(0xFFEBEAEC),
                bg: 'topic-bg-9.png',
                title: 'Relaxation',
                subTitle: 'MUSIC',
                size: 118.0
              )
            ]
          ),
          const SizedBox(height: 20),
          Container(
            width: 374,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('images/topic-bg-10.png'))
            ),
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daily Thought', style: Styles.titleStyle.copyWith(color: const Color(0xFFFFFFFF))),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('MEDITATION', style: Styles.subTitleStyle.copyWith(color: const Color(0xFFFFFFFF), fontSize: 11,letterSpacing: 1.2, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 5),
                          Center(
                            child: Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                              )
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text('3-10 MIN', style: Styles.subTitleStyle.copyWith(color: const Color(0xFFFFFFFF), fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 1.2)),
                        ]
                      )
                    ]
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Center(
                      child: Image(image: AssetImage('images/play_btn.png'), height: 12, fit: BoxFit.fitHeight)
                    )
                  )
                ]
              )
            )
          )
        ]
      ),
    );
  }
}