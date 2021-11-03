<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

The `TaggedText` library allow easy building tagged text as `RichText`.

Allow build `RichText` with `TextSpan` by tagged text.

## Installation

Add on pubspec.yml:

```
dependencies:
  tagged_text: ... // latest package version
```

## Usage

See example in `/example` folder. 

```flutter
import 'package:tagged_text/tagged_text.dart';

TaggedText(
  textAlign: TextAlign.center,
  text: 'You have pushed one of this <b>buttons</b>\n'
      'this many times: <v>$_counter</v>\n'
      'also <hl>tags can <hr>crossing</hl> each</hr> other',
  rootSettings: TextSpanSettings(style: textTheme.bodyText1),
  tagsSettings: <String, TextSpanSettings>{
    'b': TextSpanSettings(
      style: textTheme.bodyText2?.apply(color: Colors.blueAccent),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          _incrementCounter();
        },
    ),
    'v': TextSpanSettings(style: textTheme.headline6),
    'hl': TextSpanSettings(
      style: const TextStyle(
        backgroundColor: Colors.deepPurple,
        color: Colors.yellow,
      ),
    ),
    'hr': TextSpanSettings(
      style: const TextStyle(
        color: Colors.deepOrangeAccent,
      ),
    ),
  },
);
```

![SimulatorScreenShot](example/SimulatorScreenShot.png)
