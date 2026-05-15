import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show debugPrint;

import 'package:cogo/constants/apis.dart';
import 'package:cogo/data/di/api_client.dart';
import 'package:cogo/data/dto/response/coupon/assigned_coupon_eligibility_response.dart';
import 'package:cogo/data/dto/response/coupon/check_eligibility_response.dart';
import 'package:cogo/data/dto/response/coupon/event_status_response.dart';
import 'package:dio/dio.dart';

class CouponService {
  final ApiClient _apiClient = ApiClient();
  static const _apiVersion = 'api/v2/';

  /// GET /api/v2/events/status - 이벤트 진행 상태 조회
  Future<EventStatusResponse> getEventStatus() async {
    try {
      final response = await _apiClient.dio.get(
        _apiVersion + Apis.getEventStatus,
      );

      if (response.statusCode == 200) {
        final content = response.data['content'] as Map<String, dynamic>;
        return EventStatusResponse.fromJson(content);
      }
      throw Exception('이벤트 상태 조회 실패: ${response.statusCode}');
    } catch (e) {
      log('이벤트 상태 조회 오류: $e');
      rethrow;
    }
  }

  /// GET /api/v2/events/check-eligibility - 쿠폰 발급 자격 확인
  Future<CheckEligibilityResponse> checkEligibility(int applicationId) async {
    try {
      final response = await _apiClient.dio.get(
        _apiVersion + Apis.checkEligibility,
        queryParameters: {'applicationId': applicationId},
      );

      if (response.statusCode == 200) {
        final content = response.data['content'] as Map<String, dynamic>;
        return CheckEligibilityResponse.fromJson(content);
      }
      throw Exception('쿠폰 발급 자격 확인 실패: ${response.statusCode}');
    } catch (e) {
      log('쿠폰 발급 자격 확인 오류: $e');
      rethrow;
    }
  }

  /// GET /api/v2/events/verify-qr - QR 토큰 유효성 1차 검증
  /// 성공(200) 시 void 반환, 실패 시 예외 throw
  Future<void> verifyQrToken(String qrToken) async {
    debugPrint('[verifyQr] qrToken 값: $qrToken');
    try {
      final response = await _apiClient.dio.post(
        _apiVersion + Apis.verifyQrToken,
        queryParameters: {'qrToken': qrToken},
        options: Options(extra: {'skipAuthToken': false}),
      );

      if (response.statusCode != 200) {
        throw Exception('QR 토큰 검증 실패: ${response.statusCode}');
      }
    } catch (e) {
      log('QR 토큰 검증 오류: $e');
      rethrow;
    }
  }

  /// POST /api/v2/events/coupons - 최종 쿠폰 발급 (PIN 인증)
  /// 성공 시 쿠폰 번호(String) 반환
  Future<String> issueCoupon({
    required String qrToken,
    required String storePin,
  }) async {
    log('[issueCoupon] 요청 시작 — qrToken: $qrToken / storePin: $storePin');
    try {
      final response = await _apiClient.dio.post(
        _apiVersion + Apis.issueCoupon,
        queryParameters: {
          'qrToken': qrToken,
          'storePin': storePin,
        },
      );
      log('[issueCoupon] 응답 statusCode: ${response.statusCode}');
      log('[issueCoupon] 응답 전체: ${response.data}');
      final content = response.data['content'] as Map<String, dynamic>;
      log('[issueCoupon] content: $content');
      final couponNumber = content.values.first.toString();
      log('[issueCoupon] 추출된 쿠폰 번호: $couponNumber');
      return couponNumber;
    } on DioException catch (e) {
      log('[issueCoupon] DioException — statusCode: ${e.response?.statusCode}');
      log('[issueCoupon] DioException — response data: ${e.response?.data}');
      log('[issueCoupon] DioException — message: ${e.message}');
      rethrow;
    } catch (e) {
      log('[issueCoupon] 쿠폰 발급 오류: $e');
      rethrow;
    }
  }

  /// GET /api/v2/assigned-coupons/eligibility - 보관함 진입 시 사전 등록 대상자 여부 및 발급 이력 조회
  Future<AssignedCouponEligibilityResponse> getAssignedCouponEligibility() async {
    try {
      final response = await _apiClient.dio.get(
        _apiVersion + Apis.getAssignedCouponEligibility,
      );

      if (response.statusCode == 200) {
        final content = response.data['content'] as Map<String, dynamic>;
        return AssignedCouponEligibilityResponse.fromJson(content);
      }
      throw Exception('보관함 자격 조회 실패: ${response.statusCode}');
    } catch (e) {
      log('보관함 자격 조회 오류: $e');
      rethrow;
    }
  }

  /// GET /api/v2/events/qr - 멘토 인증용 QR 코드 이미지(PNG) 발급
  Future<Uint8List> getQrCode(int applicationId) async {
    try {
      final response = await _apiClient.dio.get(
        _apiVersion + Apis.getQrCode,
        queryParameters: {'applicationId': applicationId},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(List<int>.from(response.data));
      }

      // 에러 응답 바이트를 디코딩해서 서버 메시지 추출
      final errorBody = utf8.decode(List<int>.from(response.data));
      final errorJson = jsonDecode(errorBody) as Map<String, dynamic>;
      final message = errorJson['message'] as String? ?? 'QR 코드를 발급할 수 없습니다.';
      throw Exception(message);
    } catch (e) {
      log('QR 코드 조회 오류: $e');
      rethrow;
    }
  }
}
