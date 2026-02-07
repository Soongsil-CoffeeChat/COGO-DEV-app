import 'package:cogo/common/enums/report_reason.dart';
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
  final int reporterId;
  final int reportedUserId;
  final ReportReason reason;

  const ReportDetailScreen({
    super.key,
    required this.reporterId,
    required this.reportedUserId,
    required this.reason,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportViewModel(
          reporterId: reporterId,
          reportedUserId: reportedUserId,
          reason: reason),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: CogoColor.white50,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: CogoColor.white50,
            title: const Text("신고하기", style: CogoTextStyle.body20),
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset('assets/icons/button/chevron_left.svg'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: Consumer<ReportViewModel>(
              builder: (context, viewModel, child) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(), // 스크롤 바운스 조절
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("신고 세부 내용", style: CogoTextStyle.body16),
                        const SizedBox(height: 10),
                        BasicTextField(
                          controller: viewModel.reportController,
                          hintText: '신고하실 내용을 자세히 작성해주세요',
                          currentCount: viewModel.reportCharCount,
                          maxCount: 200,
                          size: BasicTextFieldSize.LARGE,
                          maxLines: 5, // 여러 줄 입력 가능
                        ),
                        const SizedBox(height: 20),
                        const Text('유의사항', style: CogoTextStyle.bodySB14),
                        const SizedBox(height: 10),
                        const Text(
                          '신고 후 신고 내역에 따라 해당 유저에게 안내가 이루어질 예정입니다.\n'
                          '각 항목 별 세부 사항은 다음과 같습니다.\n\n'
                          '멘토링의 목적이 아닌것\n- 종교단체\n- 사업목적 (보험, 광고, etc)\n- 기타 멘토링으로 의도되지 않는 모든 행위\n\n'
                          '멘토링 과정에서 비매너 행위 발생\n- 잘못된 정보 제공\n- 상대방에 부적절한 언행\n- 기타 양자간 분쟁 가능성이 있는 비매너 행위',
                          style: CogoTextStyle.body9,
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryButton(
                              text: '취소',
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 16),
                            BasicButton(
                              text: '신고',
                              isClickable: true,
                              onPressed: () async {
                                final isSuccess = await viewModel.postReport();
                                if (!context.mounted) return;
                                if (isSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('신고가 접수되었습니다.')),
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('신고 접수에 실패했습니다.')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
