import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_response.freezed.dart';
part 'chat_message_response.g.dart';

@freezed
class PageResponse with _$PageResponse {
  const factory PageResponse({
    required List<ChatMessageResponse> content,
    required int pageNumber,
    required int pageSize,
    required int totalElements,
    required int totalPages,
    required bool last,
  }) = _PageResponse;

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);
}

@freezed
class ChatMessageResponse with _$ChatMessageResponse {
  const factory ChatMessageResponse({
    required int chatId,
    required int senderId,
    required String message,
    required DateTime createdAt,
  }) = _ChatMessageResponse;

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseFromJson(json);
}
