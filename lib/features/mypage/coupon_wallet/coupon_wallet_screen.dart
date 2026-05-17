import 'package:cogo/common/widgets/components/tag.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/mypage/coupon_wallet/coupon_wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

                      // eligible=true: 발급 여부와 관계없이 동일 카드, alreadyIssued면 사용 완료 태그 표시
                      final formattedDate = eligibility.issuedAt != null
                          ? DateFormat('yyyy/MM/dd').format(eligibility.issuedAt!)
                          : null;
                      final isUsed = eligibility.usedAt != null;

                      return Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () async {
                              final issued = await context.push<bool>(
                                Paths.walletCoupon,
                                extra: {
                                  'alreadyIssued': eligibility.alreadyIssued,
                                  'isUsed': isUsed,
                                  'couponNumber': eligibility.couponNumber,
                                  'issuedDate': formattedDate,
                                },
                              );
                              if (context.mounted && issued == true) {
                                viewModel.fetchCoupons();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'eea cafe 아메리카노 1잔 무료 쿠폰',
                                    style: CogoTextStyle.body16,
                                  ),
                                  if (eligibility.alreadyIssued)
                                    const Tag(
                                      title: '사용완료',
                                    ),
                                ],
                              ),
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
