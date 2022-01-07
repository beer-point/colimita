import 'package:colimita/navigation/slide_transition_route.dart';
import 'package:colimita/navigation/tabs_controller.dart';
import 'package:colimita/pages/tabs/qr_scan/qr_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension TabsNavigator on Navigator {
  static void pushTab(BuildContext context, WidgetRef ref, int tabIndex) {
    void onTabChanged(int tabIndex) {
      ref.read(tabsControllerProvider.notifier).setSelectedTabIndex(tabIndex);
    }

    // If the user doesn't have a store yet show create shop modal.
    // TODO(lg): we should have a better way of checking which tab was selected
    // instead of tabIndex === 2 it should be something like
    // tabIndex === QR.tabIndex;
    if (tabIndex == 1) {
      Navigator.push(
        context,
        SlideTransitionRoute2(
          page: QRScanPage(),
          direction: SlideDirection.up,
        ),
      );
    } else {
      onTabChanged(tabIndex);
    }
  }
}
