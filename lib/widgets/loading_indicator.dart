import 'package:colimita/theme/theme.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.allPadding,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
