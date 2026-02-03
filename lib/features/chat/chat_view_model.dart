import 'dart:developer';

import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatService _service = GetIt.instance<ChatService>();

  // 초기값은 false (생성자에서 loadChatRooms 호출 시 true로 변함)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ChatRoom> _rooms = [];
  List<ChatRoom> get rooms => _rooms;

  ChatViewModel() {
    loadChatRooms();
  }

  Future<void> loadChatRooms() async {
    // 1. 로딩 시작: UI를 로딩 상태로 갱신 (Spinner 등을 보여주기 위함)
    _isLoading = true;
    notifyListeners();

    try {
      log("채팅방 목록 불러오는 중...");
      final page = await _service.getChattingRoomLists();
      _rooms = page.content;
      log("채팅방 로드 완료: ${_rooms.length}개");
    } catch (e) {
      log('채팅방 목록 불러오기 오류: $e');
    } finally {
      // 2. 로딩 종료: UI를 데이터 표시 상태로 갱신
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 바텀 네비게이션 탭 재클릭 시 호출 (강제 새로고침)
  Future<void> refreshChatRooms() async {
    log("Chat Tab Refreshed (재빌드 요청)");
    await loadChatRooms();
  }
}