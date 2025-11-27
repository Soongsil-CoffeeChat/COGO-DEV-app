import 'dart:developer';

import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ChattingRoomViewModel extends ChangeNotifier {
  String? _role;
  String? get role => _role;

  ChattingRoomViewModel(this._service) {
    getRole();
    loadChatting();
  }

  Future<void> getRole() async {
    try {
      _role = await _secureStorage.readRole();
      log(_role!);
      notifyListeners();
    } catch (e) {
      log('Error fetching role: $e');
    }
  }

  final ChatService _service;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  //final StompService _stompService = StompService();

  List<Message> messages = [];
  bool isLoading = false;

  Future<void> loadChatting() async {
    /*try {
      isLoading = true;
      notifyListeners();

      final myId = await _secureStorage.getUserId();

      final page = await _service.getChattingMessages(
        roomId: roomId,
        page: 0,
        size: 100,
        sort: ['timestamp,asc'],
      );

      messages = page.content.map((msg) {
        return Message(
          text: msg.message,
          time: _formatTime(msg.timestamp),
          isMe: msg.senderId == myId,
          profileUrl: profileUrl,
        );
      }).toList();

      // ✅ STOMP 연결
      _stompService.connect(
        accessToken: await _secureStorage.readAccessToken() ?? '',
        roomId: roomId,
        onMessage: (json) {
          final senderId = json['writer'];
          final isMine = senderId == myId; // ✅ 정확한 비교

          messages.add(
            Message(
              text: json['message'],
              time: _formatTime(DateTime.now()),
              isMe: isMine,
              profileUrl: profileUrl,
            ),
          );
          notifyListeners();
        },
      );
    } catch (e) {
      print('채팅 메시지 불러오기 오류: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }*/
  }

  void sendMessage(String text) {
    //_stompService.send(roomId: roomId, message: text);
  }

  String _formatTime(DateTime time) {
    return DateFormat('a h:mm', 'ko').format(time.toLocal());
  }

  @override
  void dispose() {
    //_stompService.disconnect();
    super.dispose();
  }
}

class Message {
  final String text;
  final String time;
  final bool isMe;
  final bool isRead;
  final String? profileUrl;

  Message({
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
    this.profileUrl,
  });
}
