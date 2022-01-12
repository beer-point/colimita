import 'package:colimita/navigation/tabs_controller.dart';
import 'package:colimita/navigation/tabs_navigator.dart';
import 'package:colimita/pages/auth/auth_provider.dart';
import 'package:colimita/pages/sessions/sessions_page.dart';
import 'package:colimita/pages/tabs/qr_scan/qr_scan_page.dart';
import 'package:colimita/pages/tabs/transactions/transactions_page.dart';
import 'package:colimita/shared/use_replace_route_on_auth_change.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home/home_page.dart';

class TabsPage extends HookConsumerWidget {
  static final bottomNavigationBarKey = Key('bottomNavigationBarKey');

  TabsPage({Key? key}) : super(key: key);

  final _tabOptions = <Widget>[
    HomePage(),
    const QRScanPage(),
    SessionsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useReplaceRouteOnAuthChange(
      context,
      ref,
      AuthStates.unauthenticated,
      '/login',
    );

    void _onTabSelect(int index) {
      TabsNavigator.pushTab(context, ref, index);
    }

    Widget _buildBottomNavigationBar(selectedTabIndex) {
      final theme = Theme.of(context);
      return BottomNavigationBar(
          key: TabsPage.bottomNavigationBarKey,
          onTap: _onTabSelect,
          currentIndex: selectedTabIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedIconTheme: theme.iconTheme.copyWith(size: 32),
          unselectedIconTheme: theme.iconTheme
              .copyWith(size: 30, color: theme.colorScheme.secondaryVariant),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: 'Escanea QR',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_bar_outlined),
              label: 'Sessiones',
            ),
          ]);
    }

    var selectedTabIndex = ref.watch(tabsControllerProvider);

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(selectedTabIndex),
      body: SizedBox.expand(
        child: _tabOptions.elementAt(selectedTabIndex),
      ),
    );
  }
}
