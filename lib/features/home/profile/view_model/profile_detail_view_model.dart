import 'package:flutter/material.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  final String imagePath;
  final String name;
  final String clubName;
  final List<String> tags;

  ProfileDetailViewModel({
    required this.imagePath,
    required this.name,
    required this.clubName,
    required this.tags,
  });

  void applyForCogo() {
    // TODO: 코고 신청하기 버튼 동작
    print("코고 신청하기");
  }
}
