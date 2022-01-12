import 'package:colimita/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.8),
      ),
      child: Center(child: LoadingIndicator()),
    );
  }
}
