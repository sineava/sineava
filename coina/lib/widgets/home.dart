import 'package:coina/widgets/manage.dart';
import 'package:coina/widgets/publish.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16);
  final TextStyle subStyle = const TextStyle(color: Color(0xFFB3B5BD), fontSize: 16);
  late Map<String, dynamic> today = {};

  Future getData() async {
    FirebaseFirestore.instance.collection('sales').doc('today').get()
      .then((doc) {
        setState(() {
          today = doc.data()!;
        });
      });
  }

  FlatButton getLabel({ required String num, required String title }) {
    return FlatButton(
      onPressed: () {},
      child: SizedBox(
        width: 96,
        height: 74,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(num, style: textStyle.copyWith(fontSize: 18)),
            const SizedBox(height: 8),
            Text(title, style: textStyle.copyWith(fontSize: 14))
          ],
        )
      )
    );
  }

  Future getImage(BuildContext context) async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => Publish(images: images)));
    }
  }

  TextButton getMessage({ required String title }) {
    return TextButton(
      onPressed: () {},
      child: ListTile(
        dense: true,
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.amber),
            borderRadius: const BorderRadius.all(Radius.circular(2))
          ),
          child: Text('提醒', style: TextStyle(color: Colors.amber[700]))
        ),
        title: Text(title, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.navigate_next_outlined)
      )
    );
  }

  Future takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    print(image);
  }

  // 发布商品
  void showFabu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          width: 414,
          height: 440,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  getImage(context);
                },
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Image(image: AssetImage('assets/images/photos.png'), width: 38,),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('从相册选择', style: textStyle.copyWith(color: Colors.black, fontSize: 20)),
                        Text('上传商品图片', style: subStyle)
                      ]
                    )
                  ]
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  takePhoto();
                },
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Image(image: AssetImage('assets/images/camera.png'), width: 38,),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('拍照', style: textStyle.copyWith(color: Colors.black, fontSize: 20)),
                        Text('拍摄商品图片', style: subStyle)
                      ]
                    )
                  ]
                ),
              )
              
            ],
          )
        );
      }
    );
  }

  Widget getTab({required String icon, required String title}) {
    return InkWell(
      onTap: () {
        if (icon == 'fabu') showFabu();
        if (icon == 'data') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Manage()));
        }
      },
      child: Column(
        children: [
          Image(image: AssetImage('assets/images/$icon.png'), width: 44),
          Text(title)
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // 请求firsebase数据
    getData();
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF3F4F8)),
      child: Column(
        children: [
          SizedBox(
            width: 414,
            height: 454,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: 414,
                      height: 360,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                      ),
                      child: Column(children: [
                        const SizedBox(height: 76),
                        Row(
                          children: [
                            const SizedBox(width: 16),
                            const Image(image: AssetImage('assets/images/avatar.png'), width: 48),
                            const SizedBox(width: 8),
                            Text('晚秋的店铺', style: textStyle)
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            getLabel(num: today.isEmpty ? '' : today['salary'].toString(), title: '今日收入(元)'),
                            getLabel(num: today.isEmpty ? '' : today['orders'].toString(), title: '今日订单数'),
                            getLabel(num: today.isEmpty ? '' : today['total_salary'].toString(), title: '累计收入(元)')
                          ]
                        ),
                        // const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            getLabel(num: today.isEmpty ? '' : today['active'].toString(), title: '今日活跃用户'),
                            getLabel(num: today.isEmpty ? '' : today['today_add'].toString(), title: '今日新增用户'),
                            getLabel(num: today.isEmpty ? '' : today['total_users'].toString(), title: '累计用户')
                          ]
                        )
                      ])
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 6,
                  child: Container(
                    width: 382,
                    height: 180,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(children: const [
                          SizedBox(width: 16),
                          Text('待办事项', style: TextStyle(fontSize: 20))
                        ]),
                        const SizedBox(height: 10),
                        getMessage(title: '有6个订单需要备货'),
                        getMessage(title: '有3个订单需要退款')
                      ]
                    )
                  ),
                )
              ]
            )
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 382,
              height: 206,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getTab(icon: 'fabu', title: '发布商品'),
                      getTab(icon: 'product', title: '商品管理'),
                      getTab(icon: 'order', title: '订单管理'),
                      getTab(icon: 'kucun', title: '库存管理'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getTab(icon: 'zichan', title: '资产管理'),
                      getTab(icon: 'data', title: '经营数据'),
                      getTab(icon: 'baozj', title: '保证金'),
                      getTab(icon: 'user', title: '用户管理')
                    ]
                  )
                ],
              ),
            )
          )
        ]
      )
    );
  }
}