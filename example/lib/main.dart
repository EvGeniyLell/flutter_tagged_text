import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tagged_text/tagged_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tagged Text Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TaggedText(
              textAlign: TextAlign.center,
              text: 'You have pushed one of this <b>buttons</b>\n'
                  'this many times: <v>$_counter</v>\n'
                  'also <hl>tags can <hr>crossing</hl> each</hr> other',
              rootSettings: TagSettings(style: textTheme.bodyText1),
              tagsSettings: <String, TagSettings>{
                'b': TagSettings(
                  style: textTheme.bodyText2?.apply(color: Colors.blueAccent),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _incrementCounter();
                    },
                ),
                'v': TagSettings(style: textTheme.headline6),
                'hl': TagSettings(
                  style: const TextStyle(
                    backgroundColor: Colors.deepPurple,
                    color: Colors.yellow,
                  ),
                ),
                'hr': TagSettings(
                  style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
