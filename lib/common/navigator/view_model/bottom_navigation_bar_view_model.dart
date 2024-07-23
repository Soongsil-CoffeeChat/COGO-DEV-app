import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  final GoRouter goRouter;
  int _selectedIndex = 0;

  BottomNavigationViewModel(this.goRouter);
  int get selectedIndex => _selectedIndex;

  void setIndex(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/cogo');
        break;
      case 2:
        context.go('/mypage');
        break;
    }
    notifyListeners();
  }

  double navBarHeight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.1;
  }
}
