import 'package:tagged_text/src/tag_level.dart';

/// Class [TaggedString].
///
/// Stored parsed string with relations tags.
class TaggedString {
  /// Stored parsed string.
  final String string;

  /// Stored relations tags
  final List<String> tags;

  /// Create [TaggedString] instance.
  TaggedString(
    this.string, {
    List<String>? tags,
  }) : tags = tags ?? <String>[];

  /// Create [TaggedString] instance from [TagLevel] list.
  factory TaggedString.fromLevels(
    String string, {
    required List<TagLevel> tagsLevels,
  }) {
    return TaggedString(string, tags: tagsLevels.openTags());
  }

  /// Create [TaggedString] instance from part of [rawString]
  /// with [startIndex],inclusive, to [endIndex], exclusive
  /// and  list of [TagLevel].
  static TaggedString? fromRawString(
    String rawString, {
    required List<TagLevel> tagsLevels,
    required int startIndex,
    int? endIndex,
  }) {
    final String subStr = rawString.substring(startIndex, endIndex);
    if (subStr.isNotEmpty) {
      return TaggedString.fromLevels(subStr, tagsLevels: tagsLevels);
    }
    return null;
  }

  @override
  String toString() {
    return '$TaggedString: $string, withs tags $tags';
  }
}
