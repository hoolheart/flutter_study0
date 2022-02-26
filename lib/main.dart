import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Study0',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Home of Flutter Study0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  WordPair _wordPair = WordPair("hello", "world");
  final _candidates = <WordPair>[];
  final _marked = Set<WordPair>();
  final _biggerStyle = const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_counter < 42) {
        _counter++;
        _wordPair = WordPair.random();
      } else {
        _counter = 0;
        _wordPair = WordPair("hello", "world");
      }
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool marked = _marked.contains(pair); // marked flag
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerStyle,
      ),
      trailing: Icon(
        marked ? Icons.favorite : Icons.favorite_border,
        color: marked ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (marked) {
            _marked.remove(pair);
          } else {
            _marked.add(pair);
          }
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        }
        final index = i ~/ 2;
        if (index >= _candidates.length) {
          _candidates.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_candidates[index]);
      },
    );
  }

  void _showOnlyMarded() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        final Iterable<ListTile> tiles = _marked.map((e) => ListTile(
              title: Text(
                e.asPascalCase,
                style: _biggerStyle,
              ),
            ));
        final List<Widget> divided = ListTile.divideTiles(
          tiles: tiles,
          context: context,
        ).toList();
        return Scaffold(
          appBar: AppBar(
            title: const Text("Marked Items"),
          ),
          body: ListView(children: divided),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(onPressed: _showOnlyMarded, icon: const Icon(Icons.list)),
        ],
      ),
      body: _buildList(),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         _wordPair.asPascalCase,
      //       ),
      //       const Text(""), // Empty line
      //       const Text(
      //         'Count of the button being pressed:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        // backgroundColor: Colors.amber,
        // foregroundColor: Colors.black,
      ), // This trailing comma makes auto-formatting nicer for build methods.
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
