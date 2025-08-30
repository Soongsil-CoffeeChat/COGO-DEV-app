import 'dart:collection';

import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  /*ChatViewModel(this._service) {
    _loadChattingRooms();
  }

  List<ChattingRoomResponse> _chatData = [];
  final Map<int, ChatMessageResponse> _latestMessages = {};
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ChattingRoomResponse> get chatData => _chatData;
  UnmodifiableMapView<int, ChatMessageResponse> get latestMessages =>
      UnmodifiableMapView(_latestMessages);

  Future<void> _loadChattingRooms() async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _service.getChattingRoomList();
      _chatData = data;

      await _loadChatting(); // 채팅 메시지도 함께 로딩
    } catch (e) {
      print('채팅방 목록 불러오기 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadChatting() async {
    try {
      final futures = _chatData.map((chatRoom) async {
        final page = await _service.getChattingMessages(
          roomId: chatRoom.id,
          page: 0,
          size: 1,
          sort: ['timestamp,asc'], // 오래된 순으로 정렬됨
        );

        if (page.content.isNotEmpty) {
          final latestMessage = page.content.last; // 최신 메시지
          _latestMessages[chatRoom.id] = latestMessage;
        }
      });

      await Future.wait(futures);
    } catch (e) {
      print('채팅 메시지 목록 불러오기 오류: $e');
    }
  }*/
}
