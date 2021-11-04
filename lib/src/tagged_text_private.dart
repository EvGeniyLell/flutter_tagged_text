import 'package:flutter/material.dart';
import 'package:tagged_text/src/tag_item.dart';
import 'package:tagged_text/src/tag_level.dart';
import 'package:tagged_text/src/tag_settings.dart';
import 'package:tagged_text/src/tagged_string.dart';
import 'package:tagged_text/tagged_text.dart';

/// Private extension on [TaggedText].
extension TagTextPrivate on TaggedText {
  /// Build list tagged strings list.
  static List<TaggedString> buildTaggedStringsList(String rawString) {
    final List<TagItem> items = TagItem.buildListFromRawString(rawString);

    final List<TaggedString?> taggedStringsList = <TaggedString?>[];

    int startIndex = 0;
    final List<TagLevel> tagsLevels = <TagLevel>[];

    for (final item in items) {
      final String? itemName = item.name;
      if (itemName != null) {
        final TagLevel tagLevel = tagsLevels.getByTag(itemName);
        taggedStringsList.add(
          TaggedString.fromRawString(
            rawString,
            tagsLevels: tagsLevels,
            startIndex: startIndex,
            endIndex: item.start,
          ),
        );
        tagLevel.changeLevelBy(item);
        startIndex = item.end;
      }
    }

    taggedStringsList.add(
      TaggedString.fromRawString(
        rawString,
        tagsLevels: tagsLevels,
        startIndex: startIndex,
      ),
    );

    assert(
      tagsLevels.openTags().isEmpty,
      "Has not proper tags: ${tagsLevels.openTags()} in rawString '$rawString'.",
    );

    final List<TaggedString> result =
        taggedStringsList.whereType<TaggedString>().toList();

    return result;
  }

  /// Build root [TextSpan] with children.
  static TextSpan buildTextSpan(
    List<TaggedString> taggedStringsList,
    Map<String, TagSettings> mapTagsSettings, {
    TagSettings? rootSettings,
  }) {
    final List<InlineSpan> result = <InlineSpan>[];
    for (final taggedString in taggedStringsList) {
      TagSettings? settings;
      for (final tag in taggedString.tags) {
        final TagSettings? tagSettings = mapTagsSettings[tag];
        if (tagSettings != null) {
          if (settings == null) {
            settings = tagSettings;
          } else {
            settings = settings.merge(tagSettings);
          }
        }
      }

      result.add(_buildTextSpanWithSettings(
        settings,
        text: taggedString.string,
      ));
    }

    return _buildTextSpanWithSettings(
      rootSettings,
      children: result,
    );
  }

  /// Build [TextSpan] by settings.
  static TextSpan _buildTextSpanWithSettings(
    TagSettings? settings, {
    String? text,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      text: text,
      style: settings?.style,
      recognizer: settings?.recognizer,
      mouseCursor: settings?.mouseCursor,
      onEnter: settings?.onEnter,
      onExit: settings?.onExit,
      semanticsLabel: settings?.semanticsLabel,
      locale: settings?.locale,
      spellOut: settings?.spellOut,
      children: children,
    );
  }
}
