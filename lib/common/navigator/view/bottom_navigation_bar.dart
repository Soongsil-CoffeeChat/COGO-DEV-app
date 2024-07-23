import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/navigator/view_model/bottom_navigation_bar_view_model.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget _buildIcon(String assetPath, bool isSelected) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.white : const Color(0xFF626262),
        BlendMode.srcIn,
      ),
      child: Image.asset(assetPath, width: 26, height: 26),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationViewModel>(
      builder: (context, controller, child) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          height: controller.navBarHeight(context),
          child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13.0),
            topRight: Radius.circular(13.0),
          ),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => _goBranch(index),
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color(0xFF626262),
            selectedLabelStyle: const TextStyle(
              fontFamily: 'PretendardRegular',
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'PretendardRegular',
              fontSize: 12,
            ),
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/icons/navigator/home.png',
                  navigationShell.currentIndex == 0,
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/icons/navigator/cogo.png',
                  navigationShell.currentIndex == 1,
                ),
                label: '코고',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(
                  'assets/icons/navigator/mypage.png',
                  navigationShell.currentIndex == 2,
                ),
                label: 'MY',
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
