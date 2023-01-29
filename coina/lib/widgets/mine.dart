import 'package:coina/widgets/setting.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  const Mine({Key? key}) : super(key: key);

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {

  Widget getWell({required String title, required AssetImage image, required int current}) {
    return TextButton(
      onPressed: () {
        if (current == 4) { // 设置页面
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Setting()));
        }
      },
      child: Row(
        children: [
          Expanded(child: Row(
            children: [
              Image(image: image, height: 20),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(color: Color(0xFF333333)))
            ],
          )),
          const Icon(Icons.navigate_next_outlined, color: Colors.grey)
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color(0xFFF3F4F8)),
          height: double.infinity,
          // color: const Color(0xFF3274F9),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 260,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(color: Color(0xFF3274F9)),
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            Row(
                              children: [
                                const Text('晚秋', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700)),
                                const SizedBox(width: 8),
                                Expanded(child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: const BorderRadius.all(Radius.circular(4))),
                                      child: const Text('高级管理员', style: TextStyle(color: Colors.white, fontSize: 12))
                                    )
                                  ],
                                )),
                                const Icon(Icons.navigate_next_sharp, color: Colors.white)
                              ]
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Text('183****5322', style: TextStyle(color: Colors.white))
                              ],
                            )
                          ]
                        ),
                      )
                    ),
                    Positioned(
                      top: 140,
                      left: 12,
                      child: Container(
                        width: 368,
                        height: 112,
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          children: [
                            Expanded(child: Row(
                              children: const [
                                CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/images/logo.png')),
                                SizedBox(width: 20),
                                Text('京东店铺', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
                              ]
                            )),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: const InkWell(child: Text('切换店铺', style: TextStyle(color: Colors.grey)))
                            )
                          ],
                        )
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 368,
                height: 298,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getWell(title: '保证金', image: const AssetImage('assets/images/bzj.png'), current: 0),
                    getWell(title: '我的推广', image: const AssetImage('assets/images/tuiguang.png'), current: 1),
                    getWell(title: '客服中心', image: const AssetImage('assets/images/center.png'), current: 2),
                    getWell(title: '意见反馈', image: const AssetImage('assets/images/feedback.png'), current: 3),
                    getWell(title: '设置', image: const AssetImage('assets/images/setting.png'), current: 4)
                  ]
                ),
              )
            ],
          )
        )
      )
    );
  }
}