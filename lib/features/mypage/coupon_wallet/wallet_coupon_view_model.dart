import 'dart:developer';

import 'package:cogo/data/service/coupon_service.dart';
import 'package:flutter/material.dart';

class WalletCouponViewModel extends ChangeNotifier {
  WalletCouponViewModel({
    required bool alreadyIssued,
    required bool isUsed,
    String? couponNumber,
    String? issuedDate,
  }) {
    _isCouponIssued = alreadyIssued;
    _isCouponUsed = isUsed;
    _couponNumber = couponNumber ?? '';
    _issuedDate = issuedDate ?? _todayFormatted();
    pinController.addListener(_onPinChanged);
  }

  final CouponService _couponService = CouponService();

  String _couponNumber = '';
  String get couponNumber => _couponNumber;

  late String _issuedDate;
  String get issuedDate => _issuedDate;

  bool _isCouponIssued = false;
  bool get isCouponIssued => _isCouponIssued;

  bool _isCouponUsed = false;
  bool get isCouponUsed => _isCouponUsed;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String? _pinSubmitError;
  String? get pinSubmitError => _pinSubmitError;

  final TextEditingController pinController = TextEditingController();
  final ValueNotifier<bool> isValidPin = ValueNotifier(false);

  String _todayFormatted() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<String> issueCoupon({required String storePin}) async {
    _isSubmitting = true;
    _pinSubmitError = null;
    notifyListeners();
    try {
      final couponNumber =
          await _couponService.issueAssignedCoupon(storePin: storePin);
      return couponNumber;
    } catch (e) {
      log('[WalletCouponViewModel.issueCoupon] 실패 — $e');
      _pinSubmitError = '직원 확인 코드가 올바르지 않습니다.';
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  void setCouponIssued(String couponNumber) {
    _couponNumber = couponNumber;
    _isCouponIssued = true;
    _issuedDate = _todayFormatted();
    notifyListeners();
  }

  void _onPinChanged() {
    isValidPin.value = pinController.text.trim().isNotEmpty;
    if (_pinSubmitError != null) {
      _pinSubmitError = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pinController.removeListener(_onPinChanged);
    pinController.dispose();
    isValidPin.dispose();
    super.dispose();
  }
}
