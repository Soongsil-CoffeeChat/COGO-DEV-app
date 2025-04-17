import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('서비스 이용약관', style: CogoTextStyle.body16),
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
시행일: 2025년 03월 26일

제1조 (목적)
본 약관은 “COGO”(이하 “회사”)가 제공하는 “술술한 책임 감 커피챗 서비스”(이하 “서비스”)의 이용 조건 및 절차에 관한 기본적인 사항을 규정합니다.

제2조 (이용자의 의무)
1. 이용자는 본 약관에 따라 회사의 서비스를 이용함에 있어서 관련 법령 및 약관을 준수해야 합니다.
2. 이용자는 서비스와 관련해 회사 또는 공지사항 및 안내사항을 주기적으로 확인할 의무가 있습니다.

제3조 (서비스의 제공 및 변경)
1. 회사는 이용자에게 실시간 챗 및 커피챗 서비스를 제공합니다.
2. 회사는 필요한 경우 사전 고지 후 서비스의 일부 혹은 전체 내용을 변경할 수 있습니다.

제4조 (이용자의 정보 제공)
1. 서비스 이용을 위해 이용자는 회사의 서비스 양식에 따라 정보를 제공해야 합니다.
2. 회사는 이용 신청 정보 및 입력 정보의 확인을 위해 필요한 조치를 취할 수 있습니다.

제5조 (서비스의 제한 및 중단)
1. 이용자가 약관 또는 관련 법령을 위반하거나, 서비스 이용에 지장을 초래하는 경우, 회사는 해당 이용자의 서비스 이용을 제한하거나 중단할 수 있습니다.
2. 회사는 서비스 제공 중단 및 중단 예정에 대한 사정을 공지사항 등을 통해 사전에 알립니다.

제6조 (면책 조항)
1. 회사는 천재지변, 정전, 시스템 오류 등 부득이한 사유로 인한 서비스 중단에 대해서는 책임을 지지 않습니다.
2. 이용자의 귀책사유로 인한 문제나 이용자의 어려움이나 손해에 대해서도 회사는 책임을 지지 않습니다.

제7조 (분쟁해결)
서비스와 관련하여 발생한 사항 및 분쟁은 약관의 해석에 관해 대한민국의 법령 및 관할법에 따릅니다.

제8조 (약관 변경)
회사는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 공지사항을 통해 이용자에게 공지됩니다.

제9조 (기타)
본 약관에 명시되지 않은 사항은 관련 법령과 일반 정책에 따릅니다.

본 약관은 2025년 03월 26일부터 적용됩니다.
''';
