import 'package:cogo/common/widgets/components/basic_button2.dart';
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
  final Set<DateTime> _markedDays = {}; // 표시할 날짜들을 저장하는 Set
  bool _isSaveButtonEnabled = false; // 완료 버튼 활성화 상태

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TableCalendar(
                              firstDay: DateTime.now(),
                              lastDay: DateTime(2100),
                              locale: 'ko-KR',
                              daysOfWeekHeight: 30,
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) =>
                                  isSameDay(_selectedDay, day),
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
                                  selectedDecoration: BoxDecoration(
                                    color: CogoColor.systemGray05,
                                    shape: BoxShape.circle,
                                  ),
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
                                  if (_markedDays.contains(day)) {
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
                            const SizedBox(height: 16),
                            const Text(
                              '선택된 시간대:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.selectedTimeSlots.length,
                              itemBuilder: (context, index) {
                                final date = viewModel.selectedTimeSlots.keys
                                    .toList()[index];
                                final timeSlots =
                                    viewModel.selectedTimeSlots[date]!;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${date.year}-${date.month}-${date.day}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        timeSlots.join(', '),
                                        style: const TextStyle(
                                          color: CogoColor.systemGray03,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            ElevatedButton(
                              onPressed: _isSaveButtonEnabled
                                  ? viewModel.postPossibleDates
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isSaveButtonEnabled
                                    ? CogoColor.main
                                    : CogoColor.systemGray04,
                              ),
                              child: const Text("완료하기"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
    bool _isSelected = false; // isSelected 상태 추가

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Modal 내부에서 setState 사용 가능
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
                    height: 50,
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
                                _isSelected =
                                    true; // 타임 피커 선택 시 isSelected true로 설정
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
                          Align(
                            alignment: Alignment.center, // 버튼을 중앙으로 정렬
                            child: BasicButton2(
                              onPressed: () {
                                setState(() {
                                  _markedDays.add(selectedDay);
                                });
                                Navigator.pop(context);
                              },
                              text: '완료',
                              isClickable: true,
                              isSelected: _isSelected,
                              width: 170,
                            ),
                          ),
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
