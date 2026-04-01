import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/chat/chatting_room/coupon/coupon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({
    super.key,
    required this.applicationId,
  });

  final int applicationId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CouponViewModel(
        userService: UserService(),
        applicationId: applicationId,
      ),
      child: const _CouponView(),
    );
  }
}

class _CouponView extends StatelessWidget {
  const _CouponView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CouponViewModel>();

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

                    // 쿠폰 이미지 (PNG)
                    Image.asset(
                      'assets/image/eea_coupon.png',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),

                    const SizedBox(height: 28),

                    // 정보 박스
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
                                ? '-'
                                : viewModel.couponNumber,
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            label: '유효 일자',
                            value: viewModel.issuedDate,
                          ),
                          const SizedBox(height: 16),
                          const _InfoRow(
                            label: '사용 방법',
                            value: '매장에서 해당 페이지를 직원에게 보여주세요',
                          ),
                          const SizedBox(height: 16),
                          const _InfoRow(
                            label: '주의 사항',
                            value:
                            '*본 쿠폰은 이벤트로 제공되는 1회성 쿠폰으로, 해당 쿠폰을 제시하면\n3,800원 상당의 아메리카노 2잔을 드립니다.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // 브랜드 라벨 (SVG)
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

            // 하단 고정 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SafeArea(
                top: false,
                child: BasicButton(
                  text: '직원 확인하기',
                  isClickable: true,
                  size: BasicButtonSize.LARGE,
                  onPressed: () =>
                      context.push(Paths.staffPinEntry),
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
        Text(
          label,
          style: CogoTextStyle.body14,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: CogoTextStyle.bodyR12.copyWith(color: CogoColor.systemGray04)
        ),
      ],
    );
  }
}