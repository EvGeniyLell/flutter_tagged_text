import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tagged_text/src/tag_settings.dart';
import 'package:tagged_text/src/tagged_string.dart';
import 'package:tagged_text/src/tagged_text_private.dart';

void main() {
  test('Build tagged strings list.', () {
    void expectItem(
      TaggedString item, {
      required String string,
      required List<String> tags,
    }) {
      expect(item.string, string);
      expect(item.tags, equals(tags));
    }

    const rawString = '1111<a>2222</a>3333<b>4444<c>5555</b>6666</c>7777';
    final List<TaggedString> list =
        TagTextPrivate.buildTaggedStringsList(rawString);
    expect(list.length, equals(7));

    expectItem(list[0], string: '1111', tags: []);
    expectItem(list[1], string: '2222', tags: ['a']);
    expectItem(list[2], string: '3333', tags: []);
    expectItem(list[3], string: '4444', tags: ['b']);
    expectItem(list[4], string: '5555', tags: ['b', 'c']);
    expectItem(list[5], string: '6666', tags: ['c']);
    expectItem(list[6], string: '7777', tags: []);
  });

  test('Build text span.', () {
    void expectItem(
      InlineSpan item, {
      required Color? color,
    }) {
      final span = item;
      if (span is TextSpan) {
        expect(span.style?.color, equals(color));
      }
    }

    const rawString = '1111<a>2222</a>3333<b>4444<c>5555</b>6666</c>7777';

    final TextSpan span = TagTextPrivate.buildTextSpan(
        TagTextPrivate.buildTaggedStringsList(rawString), <String, TagSettings>{
      'a': TagSettings(style: const TextStyle(color: Colors.red)),
      'b': TagSettings(style: const TextStyle(color: Colors.blue)),
      'c': TagSettings(style: const TextStyle(color: Colors.green)),
    });
    expect(span.children, isNotNull);
    expect(span.children!.length, equals(7));

    expectItem(span.children![0], color: null);
    expectItem(span.children![1], color: Colors.red);
    expectItem(span.children![2], color: null);
    expectItem(span.children![3], color: Colors.blue);
    expectItem(span.children![4], color: Colors.green);
    expectItem(span.children![5], color: Colors.green);
    expectItem(span.children![6], color: null);
  });
}
