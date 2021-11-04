import 'package:flutter_test/flutter_test.dart';
import 'package:tagged_text/src/tag_item.dart';
import 'package:tagged_text/src/tag_level.dart';

void main() {
  test('Create.', () {
    // Create TagLevel witch tag 'a' and default level 0.
    final TagLevel tagLevel = TagLevel(tag: 'a');
    expect(tagLevel.tag, equals('a'));
    expect(tagLevel.level, equals(0));
  });

  test('Change level by TagItem.', () {
    void expectItem<T extends TagItem>(
      TagItem item, {
      required String tag,
    }) {
      expect(item, isA<T>());
      expect(item.name, tag);
    }

    // Create 2 TagItem <a> & </a>
    const rawString = '1111<a>2222</a>3333';
    final List<TagItem> list = TagItem.buildListFromRawString(rawString);
    expect(list.length, 2);
    expectItem<OpeningTagItem>(list[0], tag: 'a');
    expectItem<ClosingTagItem>(list[1], tag: 'a');

    // Create TagLevel witch tag 'a' and default level 0.
    final TagLevel tagLevel = TagLevel(tag: 'a');
    expect(tagLevel.tag, equals('a'));
    expect(tagLevel.level, equals(0));

    // Increase level by OpeningTagItem.
    tagLevel.changeLevelBy(list[0]);
    expect(tagLevel.level, equals(1));

    // Decrease level by ClosingTagItem.
    tagLevel.changeLevelBy(list[1]);
    expect(tagLevel.level, equals(0));

    // Create wrong TagLevel witch un-existing tag 'b' and default level 0.
    final TagLevel wrongTagLevel = TagLevel(tag: 'b');
    expect(tagLevel.tag, equals('a'));
    expect(tagLevel.level, equals(0));

    // Increase level by OpeningTagItem.
    // Should trow AssertionError for wrong tag.
    expect(
      () => wrongTagLevel.changeLevelBy(list[0]),
      throwsA(isA<AssertionError>()),
    );

    // Decrease level by ClosingTagItem.
    // Should trow AssertionError for wrong tag.
    expect(
      () => wrongTagLevel.changeLevelBy(list[0]),
      throwsA(isA<AssertionError>()),
    );
  });

  test('TagLevel list - getByTag.', () {
    void expectItem(
      TagLevel item, {
      required String tag,
      required int level,
    }) {
      expect(item.tag, tag);
      expect(item.level, level);
    }

    final List<TagLevel> list = <TagLevel>[
      TagLevel(tag: 'a', level: 2),
      TagLevel(tag: 'b', level: 5),
      TagLevel(tag: 'c'),
    ];

    expectItem(list.getByTag('a'), tag: 'a', level: 2);
    expectItem(list.getByTag('b'), tag: 'b', level: 5);
    expectItem(list.getByTag('c'), tag: 'c', level: 0);
  });

  test('TagLevel list - openTags.', () {
    final List<TagLevel> list = <TagLevel>[
      TagLevel(tag: 'z', level: 1),
      TagLevel(tag: 'a', level: 2),
      TagLevel(tag: 'b'),
      TagLevel(tag: 'c', level: 5),
      TagLevel(tag: 'd'),
    ];

    expect(list.openTags(), equals(['z', 'a', 'c']));
  });
}
