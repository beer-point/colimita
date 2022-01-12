import 'package:colimita/domain/session.dart';
import 'package:colimita/pages/sessions/session_details.dart';
import 'package:colimita/pages/sessions/session_footer.dart';
import 'package:colimita/pages/sessions/session_header.dart';
import 'package:flutter/material.dart';

class SessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Session session = ModalRoute.of(context)?.settings.arguments as Session;
    return Scaffold(
      body: Column(
        children: [
          SessionHeader(session),
          Expanded(child: SessionDetails(session)),
          SessionFooter(),
        ],
      ),
    );
  }
}
