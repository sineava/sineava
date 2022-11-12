import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet/component/img_card.dart';
import 'package:pet/utils/style.dart';

class ChooseTopic extends StatefulWidget {
  const ChooseTopic({Key? key}) : super(key: key);

  @override
  State<ChooseTopic> createState() => _ChooseTopicState();
}

class Img {
  String img;
  Color bgColor;
  String text;
  int cross;
  int main;
  Img(this.img, this.bgColor, this.text, this.cross, this.main);
}

class _ChooseTopicState extends State<ChooseTopic> {
  List<Img> list = [
    Img('topic-bg-1.png', const Color(0xFF8E97FD), 'Reduce Stress', 2, 3),
    Img('topic-bg-2.png', const Color(0xFFFA6E5A), 'Improve\nPerformance', 2, 2),
    Img('topic-bg-3.png', const Color(0xFFFEB18F), 'Increase\nHappiness', 2, 3),
    Img('topic-bg-4.png', const Color(0xFFFFCF86), 'Reduce\nAnxiety', 2, 2),
    Img('topic-bg-5.png', const Color(0xFF6CB28E), 'Personal\nGrowth', 2, 3),
    Img('topic-bg-6.png', const Color(0xFF3F414E), 'Better Sleep', 2, 2),
    Img('topic-bg-7.png', const Color(0xFF8E97FD), 'Nice Job', 2, 3),
    Img('topic-bg-8.png', const Color(0xFFD9A5B5), 'Happy Heart', 2, 2)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg-4.png"),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text('What Brings you', style: Styles.helvetica.copyWith(color: const Color(0xFF3F414E), fontSize: 28, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text('To Silent Moon', style: Styles.helvetica.copyWith(color: const Color(0xFF3F414E), fontSize: 28)),
                  const SizedBox(height: 10),
                  Text('choose a topic to focues on:', style: Styles.helvetica.copyWith(color: const Color(0xFFA1A4B2), fontSize: 20)),
                  const SizedBox(height: 30),
                  StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: list.map((item) {
                      return StaggeredGridTile.count(
                        crossAxisCellCount: item.cross,
                        mainAxisCellCount: item.main,
                        child: ImgCard(img: item.img, bgColor: item.bgColor, text: item.text),
                      );
                    }).toList()
                  ),
                  const SizedBox(height: 10)
                ]
              )
            )
          )
        )
      ),
    );
  }
}