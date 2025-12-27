import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/base_response.dart';
import 'package:cogo/data/dto/response/chat/chat_message_response.dart';
import 'package:cogo/data/dto/response/chat/chat_room_response.dart';
import 'package:cogo/data/dto/response/chat/linked_cogo_response.dart';
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

  /// 채팅방 생성
  Future<void> postChattingRoom(
      int applicationId, int participantUserId) async {
    try {
      final res = await _apiClient.dio.post(
        apiVersion + Apis.chat,
        data: {
          'applicationId': applicationId,
          'participantUserId': participantUserId,
        },
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );

      if (res.statusCode == 200) {
        final data = res.data;
        if (data is Map<String, dynamic>) {
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

  ///GET 특정 채팅방의 메세지 조회
  Future<PageResponse> getChattingMessages({
    required int roomId,
    int page = 0,
    int size = 1,
    List<String> sort = const [],
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '$apiVersion${Apis.chat}/$roomId/messages',
        queryParameters: {
          'page': page,
          'size': size,
        },
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          // 응답 전체를 그대로 역직렬화
          return PageResponse.fromJson(data);
        } else {
          throw Exception('Unexpected response type: ${data.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to fetch chat rooms: ${response.statusCode} ${response.data}');
      }
    } on DioException catch (e) {
      _handleDioException(e);
      throw Exception('Unreachable');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  ///채팅방과 연결된 코고 조회
  Future<LinkedCogoResponse> getConnectedApplication(int chatRoomId) async {
    try {
      final res = await _apiClient.dio.get(
        '$apiVersion${Apis.connectedApplication}/$chatRoomId',
        options: Options(
          extra: {'skipAuthToken': false},
        ),
      );

      if (res.statusCode == 200) {
        final data = res.data;
        return LinkedCogoResponse.fromJson(data);
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

  /// 공통 에러 핸들러
  void _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        throw Exception('Bad Request (400). Please check the request.');
      case 401:
        throw Exception('Authentication failed (401).');
      case 404:
        throw Exception('Not Found (404). 존재하지 않는 게시글입니다.');
      case 406:
        throw Exception('Not Acceptable (406). 잘못된 요청입니다.');
      case 500:
        throw Exception('Internal Server Error (500). 서버 오류.');
      default:
        throw Exception('Error: ${e.response?.statusCode} ${e.message}');
    }
    throw Exception('Unreachable');
  }
}
