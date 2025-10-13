import 'package:cogo/features/cogo/unmatched_cogo/reject/cogo_reject_reason_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class CogoRejectReasonScreen extends StatefulWidget {
  const CogoRejectReasonScreen({super.key});

  @override
  State<CogoRejectReasonScreen> createState() => _CogoRejectReasonScreenState();
}

class _CogoRejectReasonScreenState extends State<CogoRejectReasonScreen> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  final List<String> reasons = [
    "시간이 맞지 않음",
    "멘티의 질문에 답하기 어려움",
    "현재 다른 지역에 있음",
    "커피챗을 할 여유가 없음(자격증, 취업준비 등)",
    "건강이 좋지 않음",
    "기타 사유 입력",
  ];

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extra == null || !extra.containsKey('applicationId')) {
      throw Exception("필요한 데이터가 전달되지 않았습니다: $extra");
    }
    final applicationId = extra['applicationId'] as int;

    return ChangeNotifierProvider(
      create: (_) => CogoRejectReasonViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Consumer<CogoRejectReasonViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      title: "코고 신청 거절하기",
                      subtitle: "선택 및 작성해주신 거절 사유는 멘티에게 전달됩니다",
                      onBackButtonPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: 20),

                    /// 라디오 리스트
                    Expanded(
                      child: ListView.builder(
                        itemCount: reasons.length,
                        itemBuilder: (context, index) {
                          final reason = reasons[index];
                          final isOtherReason = reason == "기타 사유 입력";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RadioListTile<String>(
                                value: reason,
                                groupValue: _selectedReason,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedReason = value;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title:
                                    Text(reason, style: CogoTextStyle.body14),
                                activeColor: Colors.black,
                                fillColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.black;
                                  }
                                  return CogoColor.systemGray03;
                                }),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                dense: true,
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                              ),
                              if (_selectedReason == reason &&
                                  isOtherReason) ...[
                                const SizedBox(height: 12),
                                const Text("기타 사유 입력란",
                                    style: CogoTextStyle.body16),
                                const SizedBox(height: 8),
                                BasicTextField(
                                  controller: context
                                      .read<CogoRejectReasonViewModel>()
                                      .rejectReasonController,
                                  hintText: '거절 사유를 간단히 작성해주세요',
                                  currentCount: 0,
                                  maxCount: 100,
                                  size: BasicTextFieldSize.SMALL,
                                  maxLines: 3,
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 완료 버튼
                    Center(
                      child: BasicButton(
                        text: "완료",
                        isClickable: _selectedReason != null,
                        onPressed: () {
                          final reason = _selectedReason == "기타 사유 입력"
                              ? _otherReasonController.text.trim()
                              : _selectedReason;

                          if (reason == null || reason.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("거절 사유를 입력해주세요"),
                              ),
                            );
                            return;
                          }

                          context
                              .read<CogoRejectReasonViewModel>()
                              .rejectWithReason(
                                context,
                                applicationId,
                                reason,
                              );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
