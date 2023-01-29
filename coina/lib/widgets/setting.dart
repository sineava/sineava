import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Widget getWell({ required String title }) {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF333333))),
          const Icon(Icons.navigate_next_outlined, color: Color(0xFF333333))
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('设置',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black)
          ),
          elevation: 0,
          backgroundColor: Colors.transparent
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: 430,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getWell(title: '账号设置'),
              getWell(title: '消息设置'),
              getWell(title: '本版更新记录'),
              getWell(title: '清理缓存'),
              getWell(title: '隐私协议'),
              getWell(title: '用户协议'),
              getWell(title: '关于果星云'),
              const SizedBox(height: 10),
              SizedBox(
                width: 340,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF3274F9),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22))
                    )
                  ),
                  child: const Text('退出登录')
                )
              )
            ]
          )
        )
      ),
    );
  }
}