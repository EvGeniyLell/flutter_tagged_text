import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Class [TagSettings].
///
/// Stored settings for [TextSpan].
class TagSettings {
  /// A style of text.
  final TextStyle? style;

  /// A gesture recognizer that will receive events that hit this span.
  final GestureRecognizer? recognizer;

  /// A cursor of mouse.
  final MouseCursor? mouseCursor;

  /// A callback for on enter action.
  final void Function(PointerEnterEvent)? onEnter;

  /// A callback for on exit action.
  final void Function(PointerExitEvent)? onExit;

  /// A semantics label.
  final String? semanticsLabel;

  /// A locale.
  final Locale? locale;

  /// Whether the assistive technologies should spell out this text character
  /// by character.
  final bool? spellOut;

  /// Create [TagSettings] instance.
  TagSettings({
    this.style,
    this.recognizer,
    this.mouseCursor,
    this.onEnter,
    this.onExit,
    this.semanticsLabel,
    this.locale,
    this.spellOut,
  });

  /// Merge current [TagSettings] with other.
  TagSettings merge(TagSettings? other) {
    return TagSettings(
      style: style?.merge(other?.style) ?? other?.style,
      recognizer: other?.recognizer ?? recognizer,
      mouseCursor: other?.mouseCursor ?? mouseCursor,
      onEnter: other?.onEnter ?? onEnter,
      onExit: other?.onExit ?? onExit,
      semanticsLabel: other?.semanticsLabel ?? semanticsLabel,
      locale: other?.locale ?? locale,
      spellOut: other?.spellOut ?? spellOut,
    );
  }
}
