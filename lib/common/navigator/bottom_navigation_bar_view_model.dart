import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/mypage/profile_management/mentor_introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/common/widgets/widgets.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  String? role;

  final GoRouter goRouter;
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  BottomNavigationViewModel(this.goRouter) {
    _loadPreferences();
  }

  void _loadPreferences() async {
    role = await _secureStorage.readRole();
  }

  void setIndex(int index, BuildContext context) {
    // HomeViewModel에 접근해서 role과 isIntroductionComplete 값 확인
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    if (index == 1 &&
        role == 'MENTOR' &&
        homeViewModel.isIntroductionComplete == false) {
      // 조건이 만족하면 다이얼로그를 띄움
      _showMentorProfileDialog(context);
    } else {
      // 페이지 이동 처리
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
    }
  }

  /// 다이얼로그를 띄우는 함수
  void _showMentorProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OneButtonDialog(
          title: "멘토 활동을 시작하려면\n프로필 작성을 완료해주세요",
          subtitle: '입력하신 정보는 하단의 MY에서 수정이 가능해요',
          imagePath: 'assets/icons/3d_img/heart.png',
          buttonText: '멘토 프로필 작성하기',
          onPressed: () => Navigator.of(context).push(_createRoute()),
        );
      },
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MentorIntroductionScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
