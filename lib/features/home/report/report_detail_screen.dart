import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/basic_textfield.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/features/home/report/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportViewModel(),
      child: Scaffold(
        backgroundColor: CogoColor.white50,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: CogoColor.white50,
          title: const Text(
            "신고하기",
            style: CogoTextStyle.body20,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<ReportViewModel>(
              builder: (context, viewModel, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "신고 세부 내용",
                          style: CogoTextStyle.body16,
                        ),
                        const SizedBox(height: 10),
                        BasicTextField(
                          controller: viewModel.reportController,
                          hintText: '신고하실 내용을 자세히 작성해주세요',
                          currentCount: viewModel.reportCharCount,
                          maxCount: 200,
                          size: BasicTextFieldSize.LARGE,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),
                        const Text('유의사항', style: CogoTextStyle.bodySB14),
                        const SizedBox(height: 10),
                        const Text(
                          '신고 후 신고 내역에 따라 해당 유저에게 안내가 이루어질 예정입니다.\n각 항목 별 세부 사항은 다음과 같습니다.\n\n'
                          '멘토링의 목적이 아닌것\n- 종교단체\n - 사업목적 (보험, 광고, etc)\n- 기타 멘토링으로 의도되지 않는 모든 행위\n\n'
                          '멘토링 과정에서 비매너 행위 발생\n- 잘못된 정보 제공\n- 상대방에 부적절한 언행\n- 기타 양자간 분쟁 가능성이 있는 비매너 행위',
                          style: CogoTextStyle.body9,
                        ),
                        const SizedBox(height: 20),
                        const Spacer(), // 남은 공간 채우기
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SecondaryButton(
                                text: '취소',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const SizedBox(width: 16), // 버튼들 사이에 간격 추가
                              BasicButton(
                                  text: '신고',
                                  isClickable: true,
                                  onPressed: () => {
                                        viewModel.postReport,
                                        Navigator.of(context).pop(),
                                      }),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
