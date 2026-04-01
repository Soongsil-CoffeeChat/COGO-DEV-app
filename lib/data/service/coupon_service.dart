import 'dart:developer';
import 'dart:typed_data';

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:dio/dio.dart';

class CouponService {
  final ApiClient _apiClient = ApiClient();
  static const _apiVersion = 'api/v2/';

  /// GET /api/v2/events/qr - 멘토 인증용 QR 코드 이미지(PNG) 발급
  Future<Uint8List> getQrCode(int applicationId) async {
    try {
      final response = await _apiClient.dio.get(
        _apiVersion + Apis.getQrCode,
        queryParameters: {'applicationId': applicationId},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': '*/*'},
        ),
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(List<int>.from(response.data));
      }
      throw Exception('QR 코드 조회 실패: ${response.statusCode}');
    } catch (e) {
      log('QR 코드 조회 오류: $e');
      rethrow;
    }
  }
}
