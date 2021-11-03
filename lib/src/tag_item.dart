import 'package:tagged_text/src/tag_level.dart';

abstract class TagItem {
  /// Stored match.
  final Match match;

  /// A tag name according [match].
  String? get name => match.group(1);

  /// Create [TagItem] instance.
  TagItem(this.match);

}

class OpeningTagItem extends TagItem {
  OpeningTagItem(Match match) : super(match);

  /// Build list of OpeningTagItem from [rawString]
  static Iterable<OpeningTagItem> listFromRawString(String rawString) {
    return RegExp(r'<(\w+)>')
        .allMatches(rawString)
        .map((RegExpMatch match) => OpeningTagItem(match));
  }

  @override
  String toString() {
    return '$OpeningTagItem: $name';
  }

}

class ClosingTagItem extends TagItem {
  ClosingTagItem(Match match) : super(match);

  /// Build list of OpeningTagItem from [rawString]
  static Iterable<ClosingTagItem> listFromRawString(String rawString) {
    return RegExp(r'</(\w+)>')
        .allMatches(rawString)
        .map((RegExpMatch match) => ClosingTagItem(match));
  }

  @override
  String toString() {
    return '$ClosingTagItem: $name';
  }
}
