import 'package:cogo/data/dto/response/chat/chat_message_response.dart';

class CursorChatPageResponse {
  final List<ChatMessageResponse> content;
  final String? nextCursorCreatedAt;
  final int? nextCursorChatId;
  final bool hasNext;

  CursorChatPageResponse({
    required this.content,
    required this.nextCursorCreatedAt,
    required this.nextCursorChatId,
    required this.hasNext,
  });

  factory CursorChatPageResponse.fromJson(Map<String, dynamic> json) {
    return CursorChatPageResponse(
      content: (json['content'] as List<dynamic>)
          .map((e) => ChatMessageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursorCreatedAt: json['nextCursorCreatedAt'] as String?,
      nextCursorChatId: json['nextCursorChatId'] as int?,
      hasNext: json['hasNext'] as bool,
    );
  }
}
