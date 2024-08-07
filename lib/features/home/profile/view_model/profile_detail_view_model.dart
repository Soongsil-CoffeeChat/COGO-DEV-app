import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/constants/paths.dart';

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

  void applyForCogo(BuildContext context) {
    context.push(Paths.schedule);
  }
}
