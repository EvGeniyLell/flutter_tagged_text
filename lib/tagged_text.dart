library tagged_text;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:tagged_text/src/tagged_text_private.dart';
import 'package:tagged_text/src/text_span_settings.dart';

export 'package:tagged_text/src/text_span_settings.dart';

/// Class [TaggedText].
///
/// Allow represent text witch tags like <A><A/> as
/// one-by-one TextSpans
class TaggedText extends RichText {
  /// Create [TaggedText] instance.
  TaggedText({
    required String text,
    required Map<String, TextSpanSettings> tagsSettings,
    TextSpanSettings? rootSettings,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    double textScaleFactor = 1.0,
    int? maxLines,
    Locale? locale,
    StrutStyle? strutStyle,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    TextHeightBehavior? textHeightBehavior,
    Key? key,
  }) : super(
          text: TagTextPrivate.buildTextSpan(
            TagTextPrivate.buildTaggedStringsList(text),
            tagsSettings,
            rootSettings: rootSettings,
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          key: key,
        );

  /// Create [TaggedText] instance.
  factory TaggedText.style({
    required String text,
    required Map<String, TextStyle?> tagsStyles,
    TextStyle? rootStyle,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    double textScaleFactor = 1.0,
    int? maxLines,
    Locale? locale,
    StrutStyle? strutStyle,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    TextHeightBehavior? textHeightBehavior,
    Key? key,
  }) {
    return TaggedText(
      text: text,
      tagsSettings: tagsStyles.map((String key, TextStyle? value) {
        return MapEntry<String, TextSpanSettings>(
          key,
          TextSpanSettings(style: value),
        );
      }),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      rootSettings: TextSpanSettings(style: rootStyle),
      key: key,
    );
  }
}
