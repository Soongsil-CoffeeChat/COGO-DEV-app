import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessedCogoViewModel extends ChangeNotifier {
  final List<Map<String, String>> items = [
    {'title': '나는지은님의 코고신청', 'date': '2024/07/24'},
    {'title': '나는지은님의 코고신청', 'date': '2024/07/24'},
  ];

  void onCogoItemTapped(BuildContext context, int index) {
    // 선택한 항목에 대한 동작을 여기에 추가합니다.
    context.push('/successedCogoDetail');
  }
}
