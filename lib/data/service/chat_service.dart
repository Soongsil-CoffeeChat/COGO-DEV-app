import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:dio/dio.dart';

class ChatService {
  final ApiClient _apiClient = ApiClient();
  static const apiVersion = "api/v2/";

  /// 채팅방 목록 조회
  /// [page] 기본 0, [size] 기본 20 (스웨거 기본값과 동일)
  Future<ChatRoomResponse> getChattingRoomLists({
    int page = 0,
    int size = 20,
  }) async {
    try {
      final res = await _apiClient.dio.get(
        apiVersion + Apis.chat,
        queryParameters: {
          'page': page,
          'size': size,
        },
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );

      if (res.statusCode == 200) {
        final data = res.data;
        if (data is Map<String, dynamic>) {
          // 응답 전체를 그대로 역직렬화
          return ChatRoomResponse.fromJson(data);
        } else {
          throw Exception('Unexpected response type: ${data.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to fetch chat rooms: ${res.statusCode} ${res.data}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
