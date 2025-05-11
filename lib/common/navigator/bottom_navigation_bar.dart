import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/navigator/bottom_navigation_bar_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  Widget _buildIcon(String assetPath, bool isSelected) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.white : const Color(0xFF626262),
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(assetPath, width: 26, height: 26),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationViewModel>(
      builder: (context, controller, child) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
            child: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) {
                controller.setIndex(index, context); // setIndex 호출
              },
              backgroundColor: Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xFF626262),
              selectedLabelStyle: CogoTextStyle.bodyR12,
              unselectedLabelStyle: CogoTextStyle.bodyR12,
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    'assets/icons/navigator/home.svg',
                    navigationShell.currentIndex == 0,
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    'assets/icons/navigator/cogo.svg',
                    navigationShell.currentIndex == 1,
                  ),
                  label: '코고',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                    'assets/icons/navigator/mypage.svg',
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
