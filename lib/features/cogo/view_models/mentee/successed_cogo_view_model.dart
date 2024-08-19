import 'package:flutter/material.dart';

class SuccessedCogoViewModel extends ChangeNotifier {
  final List<Map<String, String>> _items = [
    {'title': '나는지은님의 코고신청', 'date': '2024/07/24'},
    {'title': '나는지은님의 코고신청', 'date': '2024/07/24'},
  ];

  List<Map<String, String>> get items => _items;
}
