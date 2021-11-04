import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tagged_text/src/tag_settings.dart';

void main() {
  test('Create.', () {
    final TagSettings settings = TagSettings(
      style: const TextStyle(
        color: Colors.red,
        backgroundColor: Colors.yellow,
      ),
      recognizer: recognizer,
      mouseCursor: SystemMouseCursors.basic,
      onEnter: onEnter,
      onExit: onExit,
      semanticsLabel: '1111',
      locale: locale,
      spellOut: true,
    );
    expect(settings.style?.color, equals(Colors.red));
    expect(settings.style?.backgroundColor, equals(Colors.yellow));
    expect(settings.recognizer, equals(recognizer));
    expect(settings.mouseCursor, equals(SystemMouseCursors.basic));
    expect(settings.onEnter, equals(onEnter));
    expect(settings.onExit, equals(onExit));
    expect(settings.semanticsLabel, equals('1111'));
    expect(settings.locale, equals(locale));
    expect(settings.spellOut, isTrue);
  });

  test('Merge.', () {
    final TagSettings settings = TagSettings(
      style: const TextStyle(
        color: Colors.red,
      ),
      recognizer: recognizer,
      mouseCursor: SystemMouseCursors.basic,
      onEnter: onEnter,
      onExit: onExit,
      semanticsLabel: '1111',
      locale: locale,
      spellOut: true,
    ).merge(TagSettings(
      style: const TextStyle(
        color: Colors.green,
        backgroundColor: Colors.yellow,
      ),
      recognizer: recognizerOther,
      mouseCursor: SystemMouseCursors.click,
      onEnter: onEnterOther,
      onExit: onExitOther,
      semanticsLabel: '2222',
      locale: localeOther,
      spellOut: false,
    ));

    expect(settings.style?.color, equals(Colors.green));
    expect(settings.style?.backgroundColor, equals(Colors.yellow));
    expect(settings.recognizer, equals(recognizerOther));
    expect(settings.mouseCursor, equals(SystemMouseCursors.click));
    expect(settings.onEnter, equals(onEnterOther));
    expect(settings.onExit, equals(onExitOther));
    expect(settings.semanticsLabel, equals('2222'));
    expect(settings.locale, equals(localeOther));
    expect(settings.spellOut, isFalse);
  });
}

final recognizer = TapGestureRecognizer();

final recognizerOther = TapGestureRecognizer();

void onEnter(PointerEnterEvent event) {}

void onEnterOther(PointerEnterEvent event) {}

void onExit(PointerExitEvent event) {}

void onExitOther(PointerExitEvent event) {}

const locale = Locale('ru');

const localeOther = Locale('en');
