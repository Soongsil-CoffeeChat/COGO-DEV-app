import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/mypage/coupon_wallet/coupon_wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CouponWalletScreen extends StatelessWidget {
  const CouponWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CouponWalletViewModel()..fetchCoupons(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Header(
                    title: '나의 보관함',
                    subtitle: '발급받은 커피 쿠폰을 확인해보세요!',
                    onBackButtonPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<CouponWalletViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (viewModel.errorMessage != null) {
                        return Center(
                          child: Text(
                            viewModel.errorMessage!,
                            style: CogoTextStyle.body14.copyWith(
                              color: CogoColor.systemGray03,
                            ),
                          ),
                        );
                      }

                      final eligibility = viewModel.eligibility;

                      // 대상자가 아닌 경우
                      if (eligibility == null || !eligibility.eligible) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/3d_img/empty.png',
                                height: 150,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '발급받은 쿠폰이 없어요',
                                style: CogoTextStyle.body14.copyWith(
                                  color: CogoColor.systemGray03,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      // 발급 이력이 있는 경우 — 쿠폰 카드 표시
                      if (eligibility.alreadyIssued) {
                        final formattedDate = eligibility.issuedAt != null
                            ? DateFormat('yyyy/MM/dd')
                                .format(eligibility.issuedAt!)
                            : '-';
                        final isUsed = eligibility.usedAt != null;

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    eligibility.couponNumber ?? '-',
                                    style: CogoTextStyle.body16,
                                  ),
                                  Text(
                                    isUsed ? '사용 완료' : '미사용',
                                    style: CogoTextStyle.body12.copyWith(
                                      color: isUsed
                                          ? CogoColor.systemGray03
                                          : CogoColor.systemGray05,
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: CogoTextStyle.body12.copyWith(
                                      color: CogoColor.systemGray03,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      // 발급 가능한 경우 (eligible=true && alreadyIssued=false)
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'eea cafe 아메리카노 1잔 무료 쿠폰',
                                  style: CogoTextStyle.body16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
