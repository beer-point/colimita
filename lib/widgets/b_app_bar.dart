import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';

class BAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool? withBack;
  Widget? leading;
  Widget? secondaryAction;
  String? title;
  EdgeInsets? padding;

  BAppBar(
      {this.withBack,
      this.leading,
      this.secondaryAction,
      this.title,
      this.padding});

  @override
  Widget build(BuildContext context) {
    final _title = title ?? '';
    final _secondaryAction = secondaryAction ?? _PlaceholderAction();
    final canGoBack = Navigator.canPop(context);
    final _withBack = withBack ?? canGoBack;
    Widget? primaryAction = _withBack ? const BackButton() : leading;

    final _primaryAction = primaryAction ?? _PlaceholderAction();

    return SafeArea(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Color.fromRGBO(
            0,
            0,
            0,
            0,
          ),
        ),
        child: Row(children: [
          _primaryAction,
          Expanded(
            child: Center(
              child: AppTypography.title(_title),
            ),
          ),
          _secondaryAction,
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _PlaceholderAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 48, height: 48);
  }
}
