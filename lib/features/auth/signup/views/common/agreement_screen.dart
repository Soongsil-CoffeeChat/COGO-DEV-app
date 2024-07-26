import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/common/agreement_view_model.dart';

class AgreementScreen extends StatefulWidget {
  @override
  _AgreementScreenState createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAgreementModal(context);
    });
  }

  void _showAgreementModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => AgreementViewModel(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: AgreementBottomSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}

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
            _buildCheckBoxRow(
              context,
              0,
              '서비스 이용약관 ',
              '(필수)',
            ),
            _buildCheckBoxRow(
              context,
              1,
              '개인정보 수집 및 이용 동의',
              '(필수)',
            ),
            _buildCheckBoxRow(
              context,
              2,
              '만 14세 이상 ',
              '(필수)',
            ),
            _buildCheckBoxRow(
              context,
              3,
              '서비스 알림 수신 ',
              '(필수)',
            ),
            _buildCheckBoxRow(
              context,
              4,
              '서비스 혜택 정보 수신 ',
              '(선택)',
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

  Widget _buildCheckBoxRow(
      BuildContext context, int index, String title, String mandatoryText) {
    return Consumer<AgreementViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Checkbox(
            value: viewModel.isChecked[index],
            onChanged: (value) {
              viewModel.updateCheckState(index, value!);
            },
            activeColor: Colors.black,
            checkColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontFamily: 'PretendardRegular',
                      fontSize: 12,
                      color: Colors.black, // 기본 색상
                    ),
                  ),
                  TextSpan(
                    text: mandatoryText,
                    style: const TextStyle(
                      fontFamily: 'PretendardRegular',
                      fontSize: 12,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
