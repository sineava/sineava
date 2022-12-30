import 'package:flutter/material.dart';
import 'package:flutter_echart/flutter_echart.dart';

class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {

  List<EChartPieBean> dataList = [
    EChartPieBean(title: "App入账", number: 40, color: const Color(0xFF2D8EFF)),
    EChartPieBean(title: "当面付入账", number: 60, color: const Color(0xFFFFB13D))
  ];

  PieChatWidget buildPieChatWidget() {
    return PieChatWidget(
      dataList: dataList,
      isLog: true,
      isBackground: true,
      isLineText: true,
      bgColor: const  Color(0xFFF3F4F8),
      isFrontgText: false,
      initSelect: -2,
      openType: OpenType.ANI,
      loopType: LoopType.DOWN_LOOP
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('经营数据'), leading: const Icon(Icons.arrow_back_ios_rounded), elevation: 0),
        body: Container(
          decoration: const BoxDecoration(color: Color(0xFFF3F4F8)),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: 320,
                      height: 320,
                      child: buildPieChatWidget()
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}