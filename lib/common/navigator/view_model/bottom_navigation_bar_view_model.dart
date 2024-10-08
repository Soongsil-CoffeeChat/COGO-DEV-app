import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Provider를 사용하여 HomeViewModel 접근
import 'package:cogo/features/home/home/view_model/home_view_model.dart';
import 'package:cogo/common/widgets/widgets.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  final GoRouter goRouter;
  int _selectedIndex = 0;

  BottomNavigationViewModel(this.goRouter);

  int get selectedIndex => _selectedIndex;

  void setIndex(int index, BuildContext context) {
    // HomeViewModel에 접근해서 role과 isIntroductionComplete 값 확인
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    if (index == 1 && homeViewModel.selectedRole == 'mentor' && !homeViewModel.isIntroductionComplete) {
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

  // 다이얼로그를 띄우는 함수
  void _showMentorProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MentorProfileDialog();
      },
    );
  }
}
