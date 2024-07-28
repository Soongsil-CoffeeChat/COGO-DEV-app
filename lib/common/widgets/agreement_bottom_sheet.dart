import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/agreement_view_model.dart';
import 'package:cogo/common/widgets/check_box_row.dart';

class AgreementBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Consumer<AgreementViewModel>(
        builder: (context, viewModel, child) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckBoxRow(
              index: 0,
              title: '서비스 이용약관 ',
              mandatoryText: '(필수)',
            ),
            CheckBoxRow(
              index: 1,
              title: '개인정보 수집 및 이용 동의',
              mandatoryText: '(필수)',
            ),
            CheckBoxRow(
              index: 2,
              title: '만 14세 이상 ',
              mandatoryText: '(필수)',
            ),
            CheckBoxRow(
              index: 3,
              title: '서비스 알림 수신 ',
              mandatoryText: '(필수)',
            ),
            CheckBoxRow(
              index: 4,
              title: '서비스 혜택 정보 수신 ',
              mandatoryText: '(선택)',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0), // 상단에만 20의 패딩 추가
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.isAllRequiredChecked
                      ? () {
                    viewModel.onConfirmButtonPressed(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: viewModel.isAllRequiredChecked
                        ? Colors.black
                        : Color(0xFFEDEDED),
                    foregroundColor: viewModel.isAllRequiredChecked
                        ? Colors.white
                        : Colors.black,
                    textStyle: const TextStyle(
                      fontFamily: 'PretendardMedium',
                      fontSize: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('동의하고 시작하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
