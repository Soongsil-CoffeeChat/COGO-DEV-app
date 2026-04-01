import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/signup/name_input/name_input_view_model.dart';
import 'package:cogo/features/chat/chatting_room/coupon/coupon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StaffPinEntryScreen extends StatelessWidget {
  final String qrToken;

  const StaffPinEntryScreen({super.key, required this.qrToken});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CouponViewModel(
        userService: UserService(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // 키도브 오버 플로우 해결
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: '매장 직원이 직접 확인 코드를 누르게 해주세요',
                  subtitle: '매장에서 사용하는 직원 확인 코드를 입력해주세요',
                  onBackButtonPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<CouponViewModel>(
                    builder: (context, viewModel, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: viewModel.pinController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: '직원 확인 코드',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Center(
                              child: ValueListenableBuilder<bool>(
                                valueListenable: viewModel.isValidPin,
                                builder: (context, isValid, child) {
                                  return BasicButton(
                                    onPressed: isValid
                                        ? () async {
                                            await viewModel.issueCoupon(
                                              qrToken: qrToken,
                                              storePin: viewModel.pinController.text.trim(),
                                            );
                                            if (context.mounted) context.pop(true);
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
