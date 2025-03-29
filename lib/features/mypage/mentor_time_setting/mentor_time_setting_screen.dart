import 'package:cogo/common/widgets/multi_selection_time_picker.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:cogo/features/mypage/mentor_time_setting/mentor_time_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MentorTimeSettingScreen extends StatefulWidget {
  const MentorTimeSettingScreen({super.key});

  @override
  _MentorTimeSettingScreenState createState() =>
      _MentorTimeSettingScreenState();
}

class _MentorTimeSettingScreenState extends State<MentorTimeSettingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  /// 표시할 날짜들을 저장하는 Set
  final Set<DateTime> _markedDays = {};

  /// 시간 선택 여부를 추적하는 변수
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorTimeSettingViewModel(
          possibledateService: PossibledateService()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Consumer<MentorTimeSettingViewModel>(
                  builder: (context, viewModel, child) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TODO : 멘토 가능 시간 불러와서 달력에 표시하기
                            TableCalendar(
                              firstDay: DateTime.now(),
                              lastDay: DateTime(2100),
                              locale: 'ko-KR',
                              daysOfWeekHeight: 30,
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) => false,
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;

                                  _showBottomSheet(selectedDay, viewModel);
                                });
                              },

                              /// 헤더 스타일
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                leftChevronVisible: false,
                                rightChevronVisible: false,
                                titleTextStyle: CogoTextStyle.body16,
                              ),

                              /// 날짜 주 스타일
                              daysOfWeekStyle: const DaysOfWeekStyle(
                                weekdayStyle: CogoTextStyle.body14,
                                weekendStyle: CogoTextStyle.body14,
                              ),

                              /// 캘린더 스타일
                              calendarStyle: const CalendarStyle(
                                  defaultTextStyle: CogoTextStyle.body14,
                                  selectedDecoration: BoxDecoration(),
                                  todayTextStyle: TextStyle(
                                    color: CogoColor.systemGray05,
                                  ),
                                  todayDecoration:
                                      BoxDecoration(color: Colors.transparent)),
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                              calendarBuilders: CalendarBuilders(
                                markerBuilder: (context, day, focusedDay) {
                                  // 시간을 선택한 날짜만 마킹
                                  final hasSelectedTime = viewModel
                                          .selectedTimeSlots[day]?.isNotEmpty ??
                                      false;

                                  if (hasSelectedTime) {
                                    return Center(
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          color: CogoColor.systemGray05,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${day.day}',
                                            style:
                                                CogoTextStyle.body14.copyWith(
                                              color: CogoColor.white50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer<MentorTimeSettingViewModel>(
                      builder: (context, viewModel, child) {
                        return BasicButton(
                          onPressed: () async {
                            await viewModel.postPossibleDates();
                            viewModel.navigateToMentorTimeChecking(context);
                          },
                          text: '다음',
                          isClickable: _isSelected,
                          size: BasicButtonSize.SMALL,
                        );
                      },
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

  void _showBottomSheet(
      DateTime selectedDay, MentorTimeSettingViewModel viewModel) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 400,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: DatePicker(date: selectedDay, day: selectedDay),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MultiSelectionTimePicker(
                            selectedDay: selectedDay,
                            initialSelectedTimeSlots:
                                viewModel.selectedTimeSlots[selectedDay] ?? [],
                            onTimeSlotSelected: (selectedTimeSlot) {
                              viewModel.addTimeSlot(
                                  selectedDay, selectedTimeSlot);
                              setModalState(() {
                                _isSelected = true;
                              });
                            },
                            onTimeSlotDeselected: (selectedTimeSlot) {
                              viewModel.deleteTimeSlot(
                                  selectedDay, selectedTimeSlot);
                              setModalState(() {
                                _isSelected =
                                    viewModel.selectedTimeSlots[selectedDay] !=
                                            null &&
                                        viewModel
                                            .selectedTimeSlots[selectedDay]!
                                            .isNotEmpty;
                              });
                            },
                            timeSlots: viewModel.timeSlots,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
