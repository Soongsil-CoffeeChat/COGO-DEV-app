import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cogo/features/auth/signup/views_model/agreement_view_model.dart';

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
      isScrollControlled: true, // 전체 화면 높이를 사용할 수 있게 설정
      shape: RoundedRectangleBorder(
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
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}

class AgreementBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
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
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: viewModel.isAllRequiredChecked
                    ? () {
                  // signup_screen_phone 페이지로 이동
                  context.go('/agreement/phone');
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: viewModel.isAllRequiredChecked
                      ? Colors.black
                      : Color(0xFFEDEDED),
                  foregroundColor: viewModel.isAllRequiredChecked
                      ? Colors.white
                      : Colors.black,
                  textStyle: TextStyle(
                    fontFamily: 'PretendardMedium',
                    fontSize: 18, // 원하는 폰트 크기 지정
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('동의하고 시작하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO : 디자인 커스텀 수정하기
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
          SizedBox(width: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontFamily: 'PretendardRegular',
                    fontSize: 12,
                    color: Colors.black, // 기본 색상
                  ),
                ),
                TextSpan(
                  text: mandatoryText,
                  style: TextStyle(
                    fontFamily: 'PretendardRegular',
                    fontSize: 12,
                    color: Color(0xFF808080),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
