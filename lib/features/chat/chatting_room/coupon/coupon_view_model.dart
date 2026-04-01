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

  bool get isLoading => _isLoading;
  Uint8List? get qrImageBytes => _qrImageBytes;

  Future<void> fetchQrCode(int applicationId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _qrImageBytes = await _couponService.getQrCode(applicationId);
    } catch (e) {
      _qrImageBytes = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── PIN ──────────────────────────────────────────────────────
  final TextEditingController pinController = TextEditingController();
  final ValueNotifier<bool> isValidPin = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  void _onPinChanged() {
    isValidPin.value = pinController.text.trim().isNotEmpty;
    errorMessage.value = null;
  }

  Future<void> verifyPin(BuildContext context) async {
    final pin = pinController.text.trim();

    try {
      // TODO: API 연결 후 아래 주석 해제
      // await _couponService.verifyPin(pin);

      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = '코드가 일치하지 않습니다. 코드를 확인해주세요.';
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