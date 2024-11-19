import 'package:cogo/features/auth/signup/agreement/agreement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

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
            child: SafeArea(
              child: agreementBottomSheet(context),
            ),
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

Widget agreementBottomSheet(BuildContext context) {
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
                      : const Color(0xFFEDEDED),
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

class CheckBoxRow extends StatelessWidget {
  final int index;
  final String title;
  final String mandatoryText;

  CheckBoxRow({
    required this.index,
    required this.title,
    required this.mandatoryText,
  });

  @override
  Widget build(BuildContext context) {
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
