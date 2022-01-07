import 'package:hooks_riverpod/hooks_riverpod.dart';

final tabsControllerProvider =
    StateNotifierProvider<TabsController, int>((_) => TabsController());

class TabsController extends StateNotifier<int> {
  TabsController() : super(0);

  void setSelectedTabIndex(int tabIndex) {
    state = tabIndex;
  }
}
