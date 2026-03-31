import 'package:flutter/material.dart';

class CouponViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _qrImageUrl;

  bool get isLoading => _isLoading;
  String? get qrImageUrl => _qrImageUrl;

  Future<void> fetchQrCode() async {
    _isLoading = true;
    notifyListeners();

    // TODO: API 연결 후 아래 주석 해제
    // final response = await _couponService.getQrCode();
    // _qrImageUrl = response.qrImageUrl;

    _isLoading = false;
    notifyListeners();
  }
}
