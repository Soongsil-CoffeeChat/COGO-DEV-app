import 'dart:developer';

import 'package:cogo/data/dto/response/coupon/assigned_coupon_eligibility_response.dart';
import 'package:cogo/data/service/coupon_service.dart';
import 'package:flutter/material.dart';

class CouponWalletViewModel extends ChangeNotifier {
  final CouponService _couponService = CouponService();

  bool isLoading = false;
  AssignedCouponEligibilityResponse? eligibility;
  String? errorMessage;

  /// eligible=true && alreadyIssued=false 일 때만 발급 버튼 활성화
  bool get canIssue =>
      eligibility?.eligible == true && eligibility?.alreadyIssued == false;

  Future<void> fetchCoupons() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      eligibility = await _couponService.getAssignedCouponEligibility();
    } catch (e) {
      log('보관함 자격 조회 실패: $e');
      errorMessage = '조회 중 오류가 발생했어요';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
