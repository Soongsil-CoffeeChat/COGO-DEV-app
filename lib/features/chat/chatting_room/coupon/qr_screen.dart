import 'dart:typed_data';

import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/chat/chatting_room/coupon/coupon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key, required this.applicationId});

  final int applicationId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CouponViewModel(userService: UserService(), applicationId: applicationId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Consumer<CouponViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQrImage(viewModel.qrImageBytes),
                  const SizedBox(height: 80),
                  const Text(
                    '상대방의 스캐너로\n위의 QR code를 스캔해주세요.',
                    textAlign: TextAlign.center,
                    style: CogoTextStyle.body16,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQrImage(Uint8List? bytes) {
    if (bytes == null) {
      return Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(Icons.qr_code, size: 80, color: Colors.black38),
        ),
      );
    }

    return Image.memory(
      bytes,
      width: 240,
      height: 240,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          width: 240,
          height: 240,
          child: Center(
            child: Icon(Icons.error_outline, size: 48, color: Colors.grey),
          ),
        );
      },
    );
  }
}
