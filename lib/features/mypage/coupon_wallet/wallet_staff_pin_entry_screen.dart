import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/mypage/coupon_wallet/wallet_coupon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WalletStaffPinEntryScreen extends StatelessWidget {
  const WalletStaffPinEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalletCouponViewModel(
        alreadyIssued: false,
        isUsed: false,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: '매장 직원이 직접 확인 코드를 누르게 해주세요',
                  subtitle: '매장에서 사용하는 직원 확인 코드를 입력해주세요',
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<WalletCouponViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: viewModel.pinController,
                            keyboardType: TextInputType.text,
                            enabled: !viewModel.isSubmitting,
                            style: CogoTextStyle.body18,
                            decoration: InputDecoration(
                              labelText: '직원 확인 코드',
                              labelStyle:
                                  const TextStyle(color: Colors.grey),
                              hintStyle: CogoTextStyle.body18
                                  .copyWith(color: CogoColor.systemGray03),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorText: viewModel.pinSubmitError,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Center(
                              child: viewModel.isSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : ValueListenableBuilder<bool>(
                                      valueListenable: viewModel.isValidPin,
                                      builder: (context, isValid, child) {
                                        return BasicButton(
                                          onPressed: isValid
                                              ? () async {
                                                  final pin = viewModel
                                                      .pinController.text
                                                      .trim();
                                                  try {
                                                    final couponNumber =
                                                        await viewModel
                                                            .issueCoupon(
                                                      storePin: pin,
                                                    );
                                                    if (context.mounted) {
                                                      context
                                                          .pop(couponNumber);
                                                    }
                                                  } catch (e) {
                                                    // 에러 메시지는 viewModel.pinSubmitError로 표시됨
                                                  }
                                                }
                                              : null,
                                          isClickable: true,
                                          text: '확인',
                                          size: BasicButtonSize.SMALL,
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ],
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
