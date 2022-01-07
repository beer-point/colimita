import 'package:flutter/material.dart';

enum AppTypographyType { title, subtitle, caption, body }

/// A widget to represent different text styles.
class AppTypography extends StatelessWidget {
  final String text;
  @override
  final Key? key;
  final AppTypographyType typographyType;
  final TextStyle? style;

  // TODO(lg): define all type of labels and add constructors for all of them.
  AppTypography.title(this.text, {this.key, this.style})
      : typographyType = AppTypographyType.title;

  AppTypography.subtitle(this.text, {this.key, this.style})
      : typographyType = AppTypographyType.subtitle;

  AppTypography.caption(this.text, {this.key, this.style})
      : typographyType = AppTypographyType.caption;

  AppTypography.body(this.text, {this.key, this.style})
      : typographyType = AppTypographyType.body;

  @override
  Widget build(BuildContext context) {
    var style = _getTextStyle(context) ?? TextStyle();
    return Text(
      text,
      key: key,
      style: style.merge(this.style),
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    switch (typographyType) {
      case AppTypographyType.title:
        return Theme.of(context).textTheme.headline4;
      case AppTypographyType.subtitle:
        return Theme.of(context).textTheme.headline6;
      case AppTypographyType.caption:
        return Theme.of(context).textTheme.caption;
      case AppTypographyType.body:
        return Theme.of(context).textTheme.bodyText1;
    }
  }
}
