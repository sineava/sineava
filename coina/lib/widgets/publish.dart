import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Publish extends StatefulWidget {
  List<XFile> images = [];
  Publish({Key? key, required this.images}) : super(key: key);

  @override
  State<Publish> createState() => _PublishState();
}

class _PublishState extends State<Publish> {

  late List options = [];
  Map primaryCate = {};
  Map subCate = {};
  Map thirdCate = {};
  int salesType = 0;
  List<Widget> getImages() {
    return widget.images.map((item) => Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(item.path)),
        )
      ),
      // child: Image.file(File(item.path), width: 70, height: 70, fit: BoxFit.cover)
    )).toList();
  }

  Future getImage() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    setState(() {
      if (images.isNotEmpty) {
        widget.images = images;
      }
    });
  }

  // 查询数据库
  Future getData(int level, int pid) async {
    if (level == 3) {
      setState(() {
        options = [{'cate': '甜'}, {'cate': '脆'}];
      });
    } else {
      var doc = await FirebaseFirestore.instance.collection('category').where('level', isEqualTo: level).where('pid', isEqualTo: pid).get();
      setState(() {
        options = doc.docs;
      });
    }
  }

  InkWell getInkWell({required String title, required int level}) {
    return InkWell(
      onTap: () async {
        await getData(level, level == 1 ? 0 : primaryCate['id']);
        await showModal(level);
      },
      child: Container(
        height: 54,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(
              children: [
                const TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                TextSpan(text: title)
              ]
            )),
            Row(
              children: [
                level == 1
                  ? Text(primaryCate.isEmpty ? '' : primaryCate['cate']) : level == 2 ? Text(subCate.isEmpty ? '' : subCate['cate']) : Text(thirdCate.isEmpty ? '' : thirdCate['cate']),
                const SizedBox(width: 8),
                const Icon(Icons.navigate_next_rounded)
              ],
            )
          ]
        ),
      )
    );
  }

  List<Widget> getSelect() {
    return [
      {'cate': '包装类型', 'type': 'select'},
      {'cate': '单价', 'type': 'select'},
      {'cate': '规格', 'type': 'select'},
      {'cate': '一箱价格', 'type': 'select'},
      {'cate': '产地', 'type': 'select'},
      {'cate': '次品率', 'type': 'select'}
    ].map((e) => InkWell(
      onTap: () async {
        options = [{ 'cate': '箱装' }, { 'cate': '桶装' }];
        await showSheet();
      },
      child: Container(
        width: 382,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                TextSpan(text: e['cate'])
              ])
            ),
            const Icon(Icons.navigate_next_rounded)
          ]
        )
      ))).toList();
  }

  Future showModal(int level) {
    return showModalBottomSheet(context: context, builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((item) {
          Map data = level == 3 ? item : item.data();
          return InkWell(
            onTap: () {
              if (level == 1) {
                setState(() {
                  primaryCate = data;
                  subCate = {};
                  thirdCate = {};
                });
              }
              if (level == 2) {
                setState(() {
                  subCate = data;
                  thirdCate = {};
                });
              }
              if (level == 3) {
                setState(() {
                  thirdCate = data;
                });
              }
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(data['cate'])
            )
          );
        }).toList()
      );
    });
  }

  Future showSheet() {
    return showModalBottomSheet(context: context, builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((item) {
          return InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(item['cate'])
            )
          );
        }).toList()
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: child,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('发布商品'), leading: const Icon(Icons.arrow_back_ios_rounded), elevation: 0),
        body: SingleChildScrollView(
          child: Container(
          decoration: const BoxDecoration(color: Color(0xFFF3F4F8)),
          child: Column(
            children: [
              Row(
                children: [
                  ...getImages(),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: Colors.grey,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          height: 70,
                          width: 70,
                          color: Colors.white,
                          child: const Icon(Icons.add, size: 30, color: Colors.grey),
                        ),
                      ),
                    )
                  )
                ],
              ),
              Card(
                child: Center(
                  child: Container(
                    width: 382,
                    height: 106,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                            TextSpan(text: '商品标题')
                          ])
                        ),
                        TextFormField(
                          decoration: const InputDecoration(hintText: '请输入商品标题', border: InputBorder.none),
                        )
                      ]
                    )
                  )
                )
              ),
              const SizedBox(height: 8),
              Card(
                child: SizedBox(
                  width: 382,
                  height: 168,
                  child: Column(
                    children: [
                      getInkWell(title: '商品大类', level: 1),
                      getInkWell(title: '商品小类', level: 2),
                      getInkWell(title: '商品特性', level: 3)
                    ]
                  )
                )
              ),
              Card(
                child: Center(
                  child: Container(
                    width: 382,
                    height: 106,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text.rich(
                          TextSpan(children: [
                            TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                            TextSpan(text: '出售方式')
                          ])
                        ),
                        const SizedBox(height: 10),
                        Row(children: [
                          Radio(
                            value: 0,
                            onChanged: (value){
                              setState(() {
                                salesType = value as int;
                              });
                            },
                            // 按钮组的值
                            groupValue: salesType,
                          ),
                          const Text('按重量计价'),
                          Radio(
                            value: 1,
                            onChanged: (value){
                              setState(() {
                                salesType = value as int;
                              });
                            },
                            // 按钮组的值
                            groupValue: salesType,
                          ),
                          const Text('按箱计价'),
                          Radio(
                            value: 2,
                            onChanged: (value){
                              setState(() {
                                salesType = value as int;
                              });
                            },
                            // 按钮组的值
                            groupValue: salesType,
                          ),
                          const Text('散装')
                        ])
                      ],
                    ),
                  ),
                )
              ),
              Card(
                child: Column(
                  children: getSelect()
                )
              )
            ],
          )
        )
        )
      ),
    );
  }
}