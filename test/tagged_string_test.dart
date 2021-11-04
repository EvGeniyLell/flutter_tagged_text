import 'package:flutter_test/flutter_test.dart';
import 'package:tagged_text/src/tag_level.dart';
import 'package:tagged_text/src/tagged_string.dart';

void main() {
  test('Create.', () {
    const rawString = '12345676890-a-b-c-d-e-f-g';
    final List<TagLevel> tagsLevels = <TagLevel>[
      TagLevel(tag: 'z'),
      TagLevel(tag: 'a', level: 2),
      TagLevel(tag: 'b'),
      TagLevel(tag: 'c', level: 5),
      TagLevel(tag: 'd'),
    ];
    final TaggedString? taggedString = TaggedString.fromRawString(
      rawString,
      tagsLevels: tagsLevels,
      startIndex: 11,
    );
    expect(taggedString, isNotNull);
    expect(taggedString?.string, equals('-a-b-c-d-e-f-g'));
    expect(taggedString?.tags, equals(['a', 'c']));

    // Should return null.
    expect(
      TaggedString.fromRawString(
        rawString,
        tagsLevels: tagsLevels,
        startIndex: 25,
      ),
      isNull,
    );

    // Should throw RangeError.
    expect(
      () => TaggedString.fromRawString(
        rawString,
        tagsLevels: tagsLevels,
        startIndex: 100,
      ),
      throwsA(isA<RangeError>()),
    );
  });
}
