import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SendedCogoViewModel extends ChangeNotifier {
  final List<Map<String, String>> items = [
    {'title': '님의 코고신청', 'date': '2024/07/24'},
    {'title': '님의 코고신청', 'date': '2024/07/24'},
  ];

  void onItemTapped(BuildContext context, int index) {
    // 클릭 시 수행할 작업을 여기에서 처리
    context.push('/receivedCogoDetail');
  }
}
