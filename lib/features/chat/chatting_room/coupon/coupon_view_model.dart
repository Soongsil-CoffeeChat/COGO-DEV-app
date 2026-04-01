import 'package:cogo/data/service/user_service.dart';
import 'package:flutter/material.dart';

class CouponViewModel extends ChangeNotifier {
  CouponViewModel({required this.userService}) {
    pinController.addListener(_onPinChanged);
  }

  final UserService userService;

  // ── QR ───────────────────────────────────────────────────────
  bool _isLoading = false;
  String? _qrImageUrl;

  bool get isLoading => _isLoading;
  String? get qrImageUrl => _qrImageUrl;

  Future<void> fetchQrCode() async {
    _isLoading = true;
    notifyListeners();

    // TODO: API 연결 후 아래 주석 해제
    // final response = await couponService.getQrCode();
    // _qrImageUrl = response.qrImageUrl;

    _isLoading = false;
    notifyListeners();
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
      // await couponService.verifyPin(pin);

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
