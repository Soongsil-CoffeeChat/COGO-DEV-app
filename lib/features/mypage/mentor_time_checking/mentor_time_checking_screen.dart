import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/mypage/mentor_time_checking/mentor_time_checking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MentorTimeCheckingScreen extends StatelessWidget {
  const MentorTimeCheckingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map?;
    final isIntroductionComplete =
        extra?['isIntroductionComplete'] as bool? ?? false;

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = MentorTimeCheckingViewModel();
        viewModel.getPossibleDates();
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<MentorTimeCheckingViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Header(
                        title: 'COGO 시간',
                        subtitle: 'COGO를 진행하기 편한 시간 대를 알려주세요.',
                        onBackButtonPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var date in viewModel.sortedDates)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: DatePicker(date: date, day: date),
                                    ),
                                    const SizedBox(height: 20),
                                    SingleSelectionTimePicker(
                                      isSelectedTimePicker: true,
                                      timeSlots: viewModel.groupedDates[date]!
                                          .map((timeSlot) =>
                                              timeSlot.formattedTimeSlot)
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: BasicButton(
                          onPressed: () {
                            if (isIntroductionComplete) {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            } else {
                              context.push(Paths.mentorDetailCompletion);
                            }
                          },
                          text: isIntroductionComplete ? '수정하기' : '완료',
                          isClickable: true,
                        ),
                      ),
                    ),
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
