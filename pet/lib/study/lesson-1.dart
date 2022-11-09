import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.green)
      ),
      home: const RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final list = <WordPair>[];
  final Set<WordPair> saved = <WordPair>{};
  final bigFont = const TextStyle(fontSize: 18);

  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(   // 新增如下20行代码 ...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: bigFont,
                ),
              );
            }
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles
            )
            .toList();
          
          return Scaffold(         // 新增 6 行代码开始 ...
            appBar: AppBar(
              title: const Text('收藏'),
            ),
            body: ListView(children: divided)
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildAll();
  }

  Widget buildAll() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App练习'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: pushSaved)
        ]
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            if (index >= list.length) {
              list.addAll(generateWordPairs().take(10));
            }
            return buildRow(list[index]);
          }
        )
      )
    );
  }

  Widget buildRow(pair) {
    final bool alreadyContain = saved.contains(pair);
    return ListTile(
      onTap: () {
        setState(() {
          alreadyContain ? saved.remove(pair) : saved.add(pair);
        });
      },
      title: Text(pair.asPascalCase, style: bigFont),
      trailing: Icon(
        alreadyContain ? Icons.favorite : Icons.favorite_border,
        color: alreadyContain ? Colors.red : null
      ),
    );
  }
}