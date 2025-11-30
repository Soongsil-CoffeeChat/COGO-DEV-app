import 'dart:developer';

import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/data/service/stomp_service.dart';
import 'package:flutter/material.dart'; // Cupertino보다 Material 권장 (ViewModel에서는 Foundation이나 Material)
import 'package:intl/intl.dart';

class ChattingRoomViewModel extends ChangeNotifier {
  // ===========================================================================
  // 1. Dependencies & Properties
  // ===========================================================================
  final ChatService _service;
  final ChatRoom room;
  final SecureStorageRepository _secureStorage = SecureStorageRepository();
  final StompService _stompService = StompService();

  // State Variables
  List<Message> messages = [];
  bool isLoading = false;

  String? _role;
  String? get role => _role;

  String? cogoDate;
  String? cogoTime;

  // ===========================================================================
  // 2. Constructor & Initialization
  // ===========================================================================
  ChattingRoomViewModel(this._service, this.room) {
    _initialize();
  }

  /// 초기 데이터 로드 통합 관리 (불필요한 리빌드 방지)
  Future<void> _initialize() async {
    isLoading = true;
    notifyListeners();

    try {
      // 역할 조회는 로컬 작업이므로 먼저 수행
      await _getRole();

      // API 호출과 채팅 로드를 병렬로 처리하여 속도 향상
      await Future.wait([
        _loadChatting(),
        _getConnectedApplication(),
      ]);
    } catch (e) {
      log('초기화 중 오류 발생: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ===========================================================================
  // 3. Business Logic (API & WebSocket)
  // ===========================================================================

  /// 역할(Role) 가져오기
  Future<void> _getRole() async {
    try {
      _role = await _secureStorage.readRole();
      log('Role loaded: $_role');
    } catch (e) {
      log('Error fetching role: $e');
    }
  }

  /// 채팅 메시지 로드 및 STOMP 연결
  Future<void> _loadChatting() async {
    try {
      int roomId = room.roomId;
      String? profileUrl;

      if (room.participants.isNotEmpty) {
        profileUrl = room.participants.first.profileImage;
      }

      final myId = await _secureStorage.getUserId();

      // 1. 이전 메시지 로드 (API)
      final page = await _service.getChattingMessages(
        roomId: roomId,
        page: 0,
        size: 100,
      );

      messages = page.content.map((msg) {
        return Message(
          text: msg.message,
          time: _formatTime(msg.createdAt),
          isMe: msg.senderId == myId,
          profileUrl: profileUrl,
        );
      }).toList();

      // 2. 실시간 소켓 연결 (STOMP)
      _stompService.connect(
        accessToken: await _secureStorage.readAccessToken() ?? '',
        roomId: roomId,
        onMessage: (json) {
          final senderId = json['writer'];
          final isMine = senderId == myId;

          messages.add(
            Message(
              text: json['message'],
              time: _formatTime(DateTime.now()),
              isMe: isMine,
              profileUrl: profileUrl,
            ),
          );
          notifyListeners(); // 새 메시지 도착 시 UI 갱신
        },
      );
    } catch (e) {
      log('채팅 로드 실패: $e');
    }
  }

  /// 연동된 코고(신청서) 정보 조회
  Future<void> _getConnectedApplication() async {
    try {
      final linkedCogo = await _service.getConnectedApplication(room.roomId);
      cogoDate = linkedCogo.date;
      cogoTime = linkedCogo.startTime;
    } catch (e) {
      log('연동된 코고 조회 실패: $e');
      // 에러 발생 시 UI에 영향을 주지 않도록 조용히 처리하거나 에러 상태 변수 추가
    }
  }

  /// 메시지 전송
  void sendMessage(String text) {
    if (text.trim().isEmpty) return; // 빈 메시지 방지

    print('==== [전송 시도] 메시지: $text ====');
    // 연결 상태 체크 로직을 추가하면 더 좋습니다 (isConnected 등)
    try {
      _stompService.send(roomId: room.roomId, message: text);
    } catch (e) {
      log('메시지 전송 실패: $e');
    }
  }

  // ===========================================================================
  // 4. Getters & Helper Methods (Formatting)
  // ===========================================================================

  /// 날짜 변환 (2025-11-26 -> 2025년 11월 26일)
  String get formattedDate {
    if (cogoDate == null) return '';
    try {
      DateTime date = DateFormat('yyyy-MM-dd').parse(cogoDate!);
      return DateFormat('yyyy년 M월 d일', 'ko').format(date);
    } catch (e) {
      return cogoDate ?? '';
    }
  }

  /// 시간 변환 (09:00:00 -> 9시)
  String get formattedTime {
    if (cogoTime == null) return '';
    try {
      DateTime time = DateFormat('HH:mm:ss').parse(cogoTime!);
      return DateFormat('h시', 'ko').format(time);
    } catch (e) {
      return cogoTime ?? '';
    }
  }

  /// 내부 시간 포맷터
  String _formatTime(DateTime time) {
    return DateFormat('a h:mm', 'ko').format(time.toLocal());
  }

  // ===========================================================================
  // 5. Cleanup
  // ===========================================================================
  @override
  void dispose() {
    _stompService.disconnect();
    super.dispose();
  }
}

// ===========================================================================
// Message Model
// ===========================================================================
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
