import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/mypage/coupon_wallet/wallet_coupon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WalletCouponScreen extends StatelessWidget {
  const WalletCouponScreen({
    super.key,
    required this.alreadyIssued,
    required this.isUsed,
    this.couponNumber,
    this.issuedDate,
  });

  final bool alreadyIssued;
  final bool isUsed;
  final String? couponNumber;
  final String? issuedDate;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalletCouponViewModel(
        alreadyIssued: alreadyIssued,
        isUsed: isUsed,
        couponNumber: couponNumber,
        issuedDate: issuedDate,
      ),
      child: const _WalletCouponView(),
    );
  }
}

class _WalletCouponView extends StatelessWidget {
  const _WalletCouponView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WalletCouponViewModel>();

    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Image.asset(
                      'assets/image/eea_one_coupon.png',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _InfoRow(
                            label: '쿠폰번호',
                            value: viewModel.couponNumber.isEmpty
                                ? '직원 확인이 완료되면 쿠폰 번호가 발급됩니다.'
                                : viewModel.couponNumber,
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            label: '발급 일자',
                            value: viewModel.issuedDate,
                          ),
                          const SizedBox(height: 16),
                          const _InfoRow(
                            label: '사용 방법',
                            value: '매장에서 해당 페이지를 직원에게 보여주세요.',
                          ),
                          const SizedBox(height: 16),
                          const _InfoRow(
                            label: '주의 사항',
                            value:
                                '*본 쿠폰은 이벤트로 제공되는 1회성 쿠폰으로, 해당 쿠폰을 제시하면\n4,000원 상당의 아메리카노 1잔을 드립니다.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: SvgPicture.asset(
                        'assets/image/eea_label.svg',
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SafeArea(
                top: false,
                child: BasicButton(
                  text: viewModel.isCouponIssued ? '쿠폰 사용 완료' : '직원 확인하기',
                  isClickable: !viewModel.isCouponIssued,
                  size: BasicButtonSize.LARGE,
                  onPressed: viewModel.isCouponIssued
                      ? null
                      : () async {
                          final couponNumber = await context.push<String>(
                            Paths.walletStaffPinEntry,
                          );
                          if (couponNumber != null && couponNumber.isNotEmpty) {
                            viewModel.setCouponIssued(couponNumber);
                          }
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CogoTextStyle.body14),
        const SizedBox(height: 4),
        Text(
          value,
          style: CogoTextStyle.bodyR12.copyWith(color: CogoColor.systemGray04),
        ),
      ],
    );
  }
}
