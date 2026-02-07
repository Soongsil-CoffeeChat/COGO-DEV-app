import 'package:cogo/common/enums/report_reason.dart';
import 'package:cogo/common/utils/routing_extension.dart';
import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/common/widgets/components/basic_button.dart';
import 'package:cogo/common/widgets/components/basic_textfield.dart';
import 'package:cogo/common/widgets/components/secondary_button.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/paths.dart';
import 'package:cogo/features/home/report/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
        reason: reason,
      ),
      child: GestureDetector(
        // 키보드 외부 영역 터치 시 키보드 미포커스(내리기)
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: CogoColor.white50,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: CogoColor.white50,
            scrolledUnderElevation: 0,
            elevation: 0,
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
                  physics: const ClampingScrollPhysics(),
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
                          maxLines: 5,
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
                        // 버튼 레이아웃: Row + Expanded로 가로 오버플로우 방지
                        Row(
                          children: [
                            Expanded(
                              child: SecondaryButton(
                                text: '취소',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: BasicButton(
                                text: '신고',
                                isClickable: true,
                                onPressed: () async {
                                  final isSuccess =
                                      await viewModel.postReport();

                                  if (!context.mounted) return;

                                  if (isSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('신고가 접수되었습니다.')),
                                    );
                                    if (context.canPop())
                                      context.pop(); // 신고 상세 -> 사유 선택
                                    if (context.canPop())
                                      context.pop(); // 사유 선택 -> 프로필 상세 바텀시트
                                    if (context.canPop())
                                      context.pop(); // 프로필 상세 바텀시트 -> 프로필 상세
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('신고 접수에 실패했습니다.')),
                                    );
                                  }
                                },
                              ),
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
