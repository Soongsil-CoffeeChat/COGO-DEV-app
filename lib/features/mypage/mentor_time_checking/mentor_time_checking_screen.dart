import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/features/mypage/mentor_time_checking/mentor_time_checking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MentorTimeCheckingScreen extends StatefulWidget {
  const MentorTimeCheckingScreen({super.key});

  @override
  _MentorTimeCheckingScreenState createState() =>
      _MentorTimeCheckingScreenState();
}

class _MentorTimeCheckingScreenState extends State<MentorTimeCheckingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorTimeCheckingViewModel()..getPossibleDates(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                Consumer<MentorTimeCheckingViewModel>(
                  builder: (context, viewModel, child) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 날짜 선택 (DatePicker)
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

                                    /// 각 날짜에 대해 가능한 시간대 표시 (TimePicker)
                                    SingleSelectionTimePicker(
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
                    );
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: BasicButton(
                      onPressed: () {
                        // '저장하기' 버튼 클릭 시 처리 로직
                      },
                      text: '저장하기',
                      isClickable: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
