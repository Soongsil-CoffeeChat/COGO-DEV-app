import 'dart:typed_data';

import 'package:cogo/data/service/coupon_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';

class CouponViewModel extends ChangeNotifier {
  CouponViewModel({required this.userService, this.applicationId}) {
    pinController.addListener(_onPinChanged);
    _initIssuedDate();
    if (applicationId != null) fetchQrCode(applicationId!);
  }

  final UserService userService;
  final int? applicationId;
  final CouponService _couponService = CouponService();

  // ── 쿠폰 정보 ────────────────────────────────────────────────
  String _couponNumber = '';
  late final String issuedDate; // 최초 진입일 — 이후 불변

  String get couponNumber => _couponNumber;

  void _initIssuedDate() {
    final now = DateTime.now();
    issuedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> fetchCouponInfo() async {
    try {
      // TODO: API 연결 후 실제 서비스 호출로 교체
      // final info = await _couponService.getCouponInfo(applicationId);
      // _couponNumber = info.couponNumber;
      notifyListeners();
    } catch (e) {
      _couponNumber = '';
      notifyListeners();
    }
  }

  // ── QR ───────────────────────────────────────────────────────
  bool _isLoading = false;
  Uint8List? _qrImageBytes;
  String? _qrErrorMessage;

  bool get isLoading => _isLoading;
  Uint8List? get qrImageBytes => _qrImageBytes;
  String? get qrErrorMessage => _qrErrorMessage;

  Future<void> fetchQrCode(int applicationId) async {
    _isLoading = true;
    _qrErrorMessage = null;
    notifyListeners();

    try {
      _qrImageBytes = await _couponService.getQrCode(applicationId);
    } catch (e) {
      _qrImageBytes = null;
      _qrErrorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── 쿠폰 사용 완료 ───────────────────────────────────────────
  bool _isCouponUsed = false;
  bool get isCouponUsed => _isCouponUsed;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String? _pinSubmitError;
  String? get pinSubmitError => _pinSubmitError;

  Future<String> issueCoupon(
      {required String qrToken, required String storePin}) async {
    debugPrint('[CouponViewModel.issueCoupon] 호출 — qrToken: $qrToken / storePin: $storePin');
    _isSubmitting = true;
    _pinSubmitError = null;
    notifyListeners();
    try {
      final couponNumber = await _couponService.issueCoupon(
          qrToken: qrToken, storePin: storePin);
      debugPrint('[CouponViewModel.issueCoupon] 성공 — couponNumber: $couponNumber');
      return couponNumber;
    } catch (e) {
      debugPrint('[CouponViewModel.issueCoupon] 실패 — $e');
      _pinSubmitError = '직원 확인 코드가 올바르지 않습니다.';
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  void setCouponUsed(String couponNumber) {
    _couponNumber = couponNumber;
    _isCouponUsed = true;
    notifyListeners();
  }

  // ── PIN ──────────────────────────────────────────────────────
  final TextEditingController pinController = TextEditingController();
  final ValueNotifier<bool> isValidPin = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  void _onPinChanged() {
    isValidPin.value = pinController.text.trim().isNotEmpty;
    errorMessage.value = null;
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
    errorMessage.dispose();
    super.dispose();
  }
}
