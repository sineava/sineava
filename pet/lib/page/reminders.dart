import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pet/component/button.dart';
import 'package:pet/component/days.dart';
import 'package:pet/utils/style.dart';
import 'layout.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  int hour = 0;
  int minute = 0;
  int per = 0;
  final player = AudioPlayer();
  void playAudio() async {
    await player.pause();
    await player.play(AssetSource('scroll.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getAll(total, type, value) {
      return List.generate(total, (index) => Text((type == 'minute' && index < 10) ? '0$index' : type == 'hour' ? (index + 1).toString() : index.toString(), style: Styles.helvetica.copyWith(color: value == index ? const Color(0xFF263238) : const Color(0xFFA1A4B2), fontSize: 24)));
    }

    void handleButton() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Layout()
        )
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 82),
              Text('What time would you\nlike to meditate?', style: Styles.titleStyle),
              const SizedBox(height: 14),
              Text('Any time you can choose but We recommend\nfirst thing in th morning.', style: Styles.subTitleStyle),
              const SizedBox(height: 30),
              Card(
                color: const Color(0xFFF5F5F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.transparent,
                child: SizedBox(
                  width: 400,
                  height: 212,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) {
                            setState(() {
                              hour = value;
                            });
                            playAudio();
                          },
                          controller: FixedExtentScrollController(),
                          physics: const FixedExtentScrollPhysics(),
                          itemExtent: 40,
                          perspective: 0.004,
                          diameterRatio: 1.2,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: getAll(12, 'hour', hour)
                          ),
                        )
                      ),
                      const SizedBox(width: 46),
                      SizedBox(
                        width: 40,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) {
                            setState(() { minute = value; });
                            playAudio();
                          },
                          controller: FixedExtentScrollController(),
                          physics: const FixedExtentScrollPhysics(),
                          itemExtent: 40,
                          perspective: 0.004,
                          diameterRatio: 1.2,
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: getAll(60, 'minute', minute)
                          ),
                        )
                      ),
                      const SizedBox(width: 46),
                      SizedBox(
                        width: 40,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) {
                            setState(() { per = value; });
                            playAudio();
                          },
                          controller: FixedExtentScrollController(),
                          physics: const FixedExtentScrollPhysics(),
                          itemExtent: 40,
                          perspective: 0.004,
                          diameterRatio: 4,
                          childDelegate: ListWheelChildListDelegate(
                            children: [
                              Text('AM', style: Styles.helvetica.copyWith(color: per == 0 ? const Color(0xFF263238) : const Color(0xFFA1A4B2), fontSize: 24)),
                              Text('PM', style: Styles.helvetica.copyWith(color: per == 1 ? const Color(0xFF263238) : const Color(0xFFA1A4B2), fontSize: 24))
                            ]
                          ),
                        )
                      ),
                    ]
                  )
                ),
              ),
              const SizedBox(height: 30),
              Text('Which day would you\nlike to meditate?', style: Styles.titleStyle),
              const SizedBox(height: 15),
              Text('Everyday is best, but we recommend picking\nat least five.', style: Styles.subTitleStyle),
              const SizedBox(height: 40),
              const Days(),
              const SizedBox(height: 58),
              Button(type: 'elevate', text: 'Save', btnColor: const Color(0xFF8E97FD), fn: handleButton),
              const SizedBox(height: 20),
              Center(
                child: Text('NO THANKS', style: Styles.helvetica.copyWith(color: const Color(0xFF3F414E)))
              )
            ],
          )
        )
      )
    );
  }
}