import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToBeer() {
      Navigator.pushNamed(context, '/beer');
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _goToBeer,
          child: Text('text'),
        ),
      ),
    );
  }
}
