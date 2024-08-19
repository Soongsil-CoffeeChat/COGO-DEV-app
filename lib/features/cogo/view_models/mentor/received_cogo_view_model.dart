import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cogo/features/cogo/models/mentor/received_cogo_item.dart';

class ReceivedCogoViewModel extends ChangeNotifier {
  final List<ReceivedCogoItem> _items = [
    ReceivedCogoItem(title: '나는지은님의 코고신청', date: '2024/07/24'),
    ReceivedCogoItem(title: '나는지은님의 코고신청', date: '2024/07/24'),
  ];

  List<ReceivedCogoItem> get items => _items;

  void onCogoItemTapped(BuildContext context, int index) {
    // 여기서 네비게이션 로직을 처리합니다.
    context.push('/receivedCogoDetail');
  }
}
