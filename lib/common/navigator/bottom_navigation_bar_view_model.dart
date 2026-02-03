import 'package:cogo/common/enums/role.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/cogo/cogo_view_model.dart'; // 추가
import 'package:cogo/features/chat/chat_view_model.dart'; // 추가
import 'package:cogo/features/mypage/mypage_view_model.dart'; // 추가
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

  bool shouldShowDialog = false;

  BottomNavigationViewModel(this.goRouter);

  void initialize(BuildContext context) {
    _loadPreferences(context);
  }

  Future<void> _loadPreferences(BuildContext context) async {
    role = await _secureStorage.readRole();

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.loadPreferences();
    shouldShowDialog = homeViewModel.shouldShowDialog;

    notifyListeners();
  }

  void setIndex(int index, BuildContext context) {
    if (index == 1 && role == Role.ROLE_MENTOR.name && shouldShowDialog) {
      _showMentorProfileDialog(context);
      return;
    }
    if (_selectedIndex == index) {
      _refreshTab(index, context);
    } else {
      _selectedIndex = index;
      notifyListeners(); // 인덱스 변경 알림

      switch (index) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/cogo');
          break;
        case 2:
          context.go('/chat');
          break;
        case 3:
          context.go('/mypage');
          break;
      }
    }
  }

  /// 각 탭의 ViewModel을 찾아 데이터를 새로고침하는 함수
  void _refreshTab(int index, BuildContext context) {
    switch (index) {
      case 0:
        Provider.of<HomeViewModel>(context, listen: false).refreshHome();
        break;
      case 1:
        Provider.of<CogoViewModel>(context, listen: false).refreshCogo();
        break;
      case 2:
        Provider.of<ChatViewModel>(context, listen: false).refreshChatRooms();
        break;
      case 3:
        Provider.of<MypageViewModel>(context, listen: false).refreshMyPage();
        break;
    }
  }

  void _showMentorProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => OneButtonDialog(
        title: "멘토 활동을 시작하려면\n프로필 작성을 완료해주세요",
        subtitle: "입력하신 정보는 하단의 MY에서 수정이 가능해요",
        imagePath: "assets/icons/3d_img/heart.png",
        buttonText: "멘토 프로필 작성하기",
        onPressed: () {
          Navigator.of(context).pop();
          Future.microtask(() => context.push(Paths.mentorIntroduction));
        },
      ),
    );
  }
}
