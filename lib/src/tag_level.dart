import 'package:tagged_text/src/tag_item.dart';

/// Class [TagLevel].
///
/// Stored [tag] with [level].
class TagLevel {
  /// A name of tag
  final String? tag;

  /// A int number of count open tags
  ///
  /// if an opening tag is found, the level increases,
  /// if an closing tag is found, the level decrease,
  int _level;

  get level => _level;

  /// Create [TagLevel] instance.
  TagLevel({required this.tag, int level = 0}) : _level = level;

  /// The function increase or decrease level
  /// depends on [TagItem].
  void changeLevelBy(TagItem item) {
    if (item.name == tag) {
      if (item is OpeningTagItem) {
        _level += 1;
      }
      if (item is ClosingTagItem) {
        _level -= 1;
      }
    } else {
      assert(false, 'wrong tag name, expect $tag but actual ${item.name}');
    }
  }

  @override
  String toString() {
    return '$TagLevel: $tag,$level';
  }
}

/// Extension on list with [TagLevel] element.
///
/// Helps works with tags.
extension TagLevelList on List<TagLevel> {
  /// get [TagLevel] from list by [tag] name
  TagLevel getByTag(String tag) {
    for (final TagLevel i in this) {
      if (i.tag == tag) {
        return i;
      }
    }
    final TagLevel result = TagLevel(tag: tag);
    add(result);
    return result;
  }

  /// Return all tags where level more then 0.
  List<String> openTags() {
    return where((TagLevel i) => i.level > 0)
        .map((TagLevel i) => i.tag)
        .whereType<String>()
        .toList();
  }
}
