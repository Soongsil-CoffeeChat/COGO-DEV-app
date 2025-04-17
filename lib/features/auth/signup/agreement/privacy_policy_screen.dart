import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('개인정보 처리방침', style: CogoTextStyle.body16),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/button/chevron_left.svg"),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SingleChildScrollView(
            child: Text(
              _termsText,
              style: CogoTextStyle.bodyL12,
            ),
          ),
        ),
      ),
    );
  }
}

const String _termsText = '''
공개일: 2025년 03월 26일
수정일: 2025년 03월 26일

제1조 (개인정보의 처리 목적)
“COGO”(이하 “회사")는 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.
* 이용자 가입의사 확인, 이용자 식별
* 푸시 알림 발송

제2조 (개인정보의 처리 및 보유 기간)
회사는 정보주체로부터 개인정보를 수집할 때 수집을 동의받은 개인정보만 보유합니다.
수집된 개인정보는 최대 5년간 보관될 수 있습니다.
제3조 (정보주체의 권리 및 행사 방법)
이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.

1. 개인정보 열람 요구
2. 오류 등이 있을 경우 정정 요구
3. 삭제 요구
4. 처리정지 요구

제4조 (처리하는 개인정보의 항목 작성)
회사는 다음의 개인정보 항목을 처리하고 있습니다.

* 필수 항목 : 성명, 소속, 전화번호
* 선택 항목 : 푸시 토큰

제5조 (개인정보의 제공 및 위탁)
회사는 이용자의 사전 동의 없이 개인정보를 제3자에게 제공하지 않습니다.

제6조 (개인정보의 파기)
회사는 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 개인정보를 파기합니다. 파기의 절차 및 방법은 다음과 같습니다.

* 파기 절차 : 데이터베이스에 수집된 개인정보 삭제
* 파기 기한 : 즉시

제7조 (개인정보 보호 책임자 작성)
회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다.

* 개인정보 보호 책임자성명: 고영명
* 직책: TEAM COGO PM
* 연락처:kdudaud433@naver.com

COGO를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만 처리, 피해구제 등에 관한 사항을 개인정보 보호 책임자에게 문의하실 수 있습니다.
또한, 정보주체의 문의에 대해 지체 없이 답변 및 처리해드리겠습니다.
''';
