import 'package:colimita/providers/user_provider.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleAddToBalance() {
      Navigator.pushNamed(context, '/payments');
    }

    final user = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _TopBar(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppTypography.body('Saldo disponible'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '\$ ${user!.balance.toString()}',
                            style: const TextStyle(fontSize: 400.0),
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      child: ElevatedButton(
                        onPressed: handleAddToBalance,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add,
                            ),
                            Text(
                              'Agregar saldo',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void handleGoToProfile() {
      Navigator.pushNamed(context, '/profile');
    }

    void handleGoToMap() {
      Navigator.pushNamed(context, '/map');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.map_outlined),
          onPressed: handleGoToMap,
        ),
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.person_outline),
          onPressed: handleGoToProfile,
        ),
      ],
    );
  }
}
