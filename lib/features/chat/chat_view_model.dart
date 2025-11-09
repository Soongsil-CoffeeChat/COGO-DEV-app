// chat_view_model.dart
import 'dart:developer';

import 'package:cogo/data/service/chat_service.dart';
import 'package:flutter/foundation.dart';
import 'package:cogo/data/dto/response/chat/chat_room_response.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel(this._service) {
    _loadChatRooms();
  }

  final ChatService _service;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ChatRoom> _rooms = [];
  List<ChatRoom> get rooms => _rooms;

  Future<void> _loadChatRooms() async {
    try {
      _isLoading = true;
      notifyListeners();

      final page = await _service.getChattingRoomLists();
      _rooms = page.content;
    } catch (e) {
      debugPrint('채팅방 목록 불러오기 오류: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshChatRooms() async {
    await _loadChatRooms();
  }
}
