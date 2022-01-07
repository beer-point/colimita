import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        actions: const [],
      ),
      body: SafeArea(
        child: AppTypography.body('map'),
      ),
    );
  }
}
