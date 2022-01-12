import 'package:colimita/domain/session.dart';
import 'package:colimita/providers/sessions_provider.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:colimita/widgets/loading_full_body.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';

class SessionsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSessions = ref.watch(sessionsProvider);
    return asyncSessions.when(
      data: (sessions) => _SessionsPage(sessions),
      loading: () => LoadingScreen(),
      error: (err, stack) {
        print(err);
        print(stack);
        return Text('Error');
      },
    );
  }
}

class _SessionsPage extends StatelessWidget {
  KtList<Session> sessions;
  _SessionsPage(this.sessions);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sessions.size,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return _SessionListItem(session);
        });
  }
}

class _SessionListItem extends StatelessWidget {
  Session session;
  _SessionListItem(this.session);
  @override
  Widget build(BuildContext context) {
    void handleGoToSession() {
      Navigator.pushNamed(context, '/session', arguments: session);
    }

    return GestureDetector(
      onTap: handleGoToSession,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(session.beer.photoUrl,
                            headers: {'Cache-Control': 'max-age=200'}),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppTypography.body(session.beer.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      AppTypography.body(session.beer.brewer.name),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '\$ ${(session.beerCostPerLt * session.ml / 1000).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                    ),
                  ),
                  AppTypography.body('${session.ml.toString()} ml'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
