import 'package:flutter/material.dart';

class TabContainer extends StatelessWidget {
  final Widget child;
  TabContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: child,
      ),
    );
  }
}
