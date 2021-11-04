import 'package:flutter_test/flutter_test.dart';
import 'package:tagged_text/src/tag_item.dart';

void main() {

  test('Build TagItem list from raw string', () {
    void expectItem<T extends TagItem>(TagItem item, {
      required String tag,
      required int start,
      required int end,
    }) {
      expect(item, isA<T>());
      expect(item.name, tag);
      expect(item.start, start);
      expect(item.end, end);
    }

    const rawString = '1111<a>2222</a>3333<b>4444<c>5555</b>6666</c>7777';
    final List<TagItem> list = TagItem.buildListFromRawString(rawString);

    expect(list.length, 6);

    expectItem<OpeningTagItem>(list[0], tag: 'a', start: 4, end: 7);
    expectItem<ClosingTagItem>(list[1], tag: 'a', start: 11, end: 15);
    expectItem<OpeningTagItem>(list[2], tag: 'b', start: 19, end: 22);
    expectItem<OpeningTagItem>(list[3], tag: 'c', start: 26, end: 29);
    expectItem<ClosingTagItem>(list[4], tag: 'b', start: 33, end: 37);
    expectItem<ClosingTagItem>(list[5], tag: 'c', start: 41, end: 45);

  });

}
