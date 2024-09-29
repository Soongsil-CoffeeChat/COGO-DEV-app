import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/profile/model/profile_detail_item.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  late ProfileDetailModel profile;

  ProfileDetailViewModel() {
    // 프로필 데이터를 초기화
    profile = ProfileDetailModel(
      imagePath: 'assets/raccoonimg.png',
      name: '김지은',
      clubName: 'GDSC',
      tags: ['BE', '직무직무', '경력'],
      tittle: '안녕하세요! 저는 코고 개발자 김지은입니다.',
      description: '오늘도 아침엔 입에 빵을 물고 똑같이 하루를 시작하고 온종일 한 손엔 아이스 아메리카노피곤해 죽겠네',
      answer1: '오늘도 아침엔 입에 빵을 물고 똑같이 하루를 시작하고 온종일 한 손엔 아이스 아메리카노피곤해 죽겠네',
      answer2: '오늘도 아침엔 입에 빵을 물고 똑같이 하루를 시작하고 온종일 한 손엔 아이스 아메리카노피곤해 죽겠네',
    );
  }

  void applyForCogo(BuildContext context) {
    context.push(Paths.schedule);
  }
}
