/// Abstract class [TagItem].
///
/// Stored data of [match] and allow get name of tag.
abstract class TagItem {
  /// A tag name according [match].
  ///
  /// match must based on r'<(\w+)>' or r'</(\w+)>'
  final String name;

  /// A start position.
  final int start;

  /// A end position.
  final int end;

  /// Create [TagItem] instance.
  TagItem(Match match)
      : name = match.group(1)!,
        start = match.start,
        end = match.end;

  /// Build list of [TagItem] from [rawString]
  static List<TagItem> buildListFromRawString(String rawString) {
    return [
      ...OpeningTagItem._buildListFromRawString(rawString),
      ...ClosingTagItem._buildListFromRawString(rawString),
    ]..sort(
        (TagItem a, TagItem b) {
          return a.end.compareTo(b.end);
        },
      );
  }
}

/// Class [OpeningTagItem].
///
/// Stored data of opening tag
/// based on [TagItem].
class OpeningTagItem extends TagItem {
  OpeningTagItem._(Match match) : super(match);

  /// Build list of [OpeningTagItem] from [rawString]
  static Iterable<OpeningTagItem> _buildListFromRawString(String rawString) {
    return RegExp(r'<(\w+)>')
        .allMatches(rawString)
        .map((RegExpMatch match) => OpeningTagItem._(match));
  }

  @override
  String toString() {
    return '$OpeningTagItem: $name';
  }
}

/// Class [ClosingTagItem].
///
/// Stored data of closing tag
/// based on [TagItem].
class ClosingTagItem extends TagItem {
  ClosingTagItem._(Match match) : super(match);

  /// Build list of [ClosingTagItem] from [rawString]
  static Iterable<ClosingTagItem> _buildListFromRawString(String rawString) {
    return RegExp(r'</(\w+)>')
        .allMatches(rawString)
        .map((RegExpMatch match) => ClosingTagItem._(match));
  }

  @override
  String toString() {
    return '$ClosingTagItem: $name';
  }
}
