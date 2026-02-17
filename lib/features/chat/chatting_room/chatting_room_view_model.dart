import 'dart:developer';

import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/chat_service.dart';
import 'package:cogo/data/service/stomp_service.dart';
import 'package:cogo/main.dart' show activeChatRoomId;
import 'package:flutter/material.dart'; // Cupertino보다 Material 권장 (ViewModel에서는 Foundation이나 Material)
import 'package:go_router/go_router.dart';
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
  int? applicationId;

  int? myId;
  int? reportedUserId;

  // ===========================================================================
  // 2. Constructor & Initialization
  // ===========================================================================
  ChattingRoomViewModel(this._service, this.room) {
    activeChatRoomId = room.roomId;
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

      myId = await _secureStorage.getUserId();

      if (room.participants.isNotEmpty && myId != null) {
        try {
          final otherParticipant = room.participants.firstWhere(
                  (p) => p.userId != myId,
              orElse: () => room.participants.first
          );
          reportedUserId = otherParticipant.userId;
          log("상대방 ID(reportedUserId) 설정 완료: $reportedUserId");
        } catch (e) {
          log("상대방 ID 설정 실패: $e");
        }
      }

      if (room.participants.isNotEmpty) {
        profileUrl = room.participants.first.profileImage;
      }

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
          createdAt: msg.createdAt,
          isMe: msg.senderId == myId,
          profileUrl: profileUrl,
        );
      }).toList();

      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      // 2. 실시간 소켓 연결 (STOMP)
      _stompService.connect(
        accessToken: await _secureStorage.readAccessToken() ?? '',
        roomId: roomId,
        onMessage: (json) {
          final senderId = json['senderId'];

          final isMine = senderId.toString() == myId.toString();

          if (isMine) {
            return;
          }

          final now = DateTime.now();
          messages.add(
            Message(
              text: json['message'],
              time: _formatTime(now),
              createdAt: now,
              isMe: isMine,
              profileUrl: profileUrl,
            ),
          );
          notifyListeners();
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
      applicationId = linkedCogo.applicationId;
    } catch (e) {
      log('연동된 코고 조회 실패: $e');
    }
  }

  /// 메시지 전송
  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. 내 화면에 먼저 메시지 추가
    final myId = await _secureStorage.getUserId();
    String? myProfileUrl;
    if (room.participants.isNotEmpty) {}

    final now = DateTime.now();
    final newMessage = Message(
      text: text,
      time: _formatTime(now),
      createdAt: now,
      isMe: true,
      profileUrl: myProfileUrl,
    );
    messages.add(newMessage);
    notifyListeners();

    print('==== [전송 시도] 메시지: $text ====');

    // 2. 서버로 전송
    try {
      _stompService.send(roomId: room.roomId, message: text);
    } catch (e) {
      log('메시지 전송 실패: $e');
      messages.remove(newMessage);
      notifyListeners();
    }
  }

  void report(BuildContext context){
    context.push(
      Paths.report,
      extra: {
        'reporterId': myId,
        'reportedUserId': reportedUserId,
      },
    );
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

  /// 두 날짜가 같은 날인지 확인하는 헬퍼 함수
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// 특정 인덱스의 메시지가 새로운 날짜의 시작인지 판단
  bool isNewDate(int index) {
    // 1. 첫 번째 메시지는 무조건 날짜 표시
    if (index == 0) return true;

    // 2. 이전 메시지와 날짜 비교
    final prevDate = messages[index - 1].createdAt;
    final currDate = messages[index].createdAt;

    // 날짜가 다르면 true (새로운 날짜임)
    return !_isSameDay(prevDate, currDate);
  }

  /// 날짜 헤더용 포맷터 (예: 2025년 4월 14일 월요일)
  String getDateHeader(int index) {
    final date = messages[index].createdAt;
    return DateFormat('yyyy년 M월 d일 EEEE', 'ko').format(date);
  }

  // ===========================================================================
  // 5. Cleanup
  // ===========================================================================
  @override
  void dispose() {
    activeChatRoomId = null;
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
  final DateTime createdAt;
  final bool isMe;
  final bool isRead;
  final String? profileUrl;

  Message({
    required this.text,
    required this.time,
    required this.createdAt,
    required this.isMe,
    this.isRead = false,
    this.profileUrl,
  });
}
