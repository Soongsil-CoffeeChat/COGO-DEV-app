import 'package:cogo/common/widgets/multi_selection_time_picker.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:cogo/features/mypage/mentor_time_setting/mentor_time_setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  bool _isSelected = false;

  late MentorTimeSettingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MentorTimeSettingViewModel(
      possibledateService: PossibledateService(),
    );
    Future.microtask(() {
      viewModel.loadPossibleDatesFromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: 'COGO 시간',
                  subtitle: 'COGO를 진행하기 편한 시간 대를 알려주세요.',
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Consumer<MentorTimeSettingViewModel>(
                    builder: (context, viewModel, child) {
                      return SingleChildScrollView(
                        child: TableCalendar(
                          firstDay: DateTime.now(),
                          lastDay: DateTime(2100),
                          locale: 'ko-KR',
                          daysOfWeekHeight: 30,
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) => false,
                          onDaySelected: (selectedDay, focusedDay) {
                            final normalizedDay = DateTime(selectedDay.year,
                                selectedDay.month, selectedDay.day);
                            setState(() {
                              _selectedDay = normalizedDay;
                              _focusedDay = focusedDay;
                              _showBottomSheet(normalizedDay, viewModel);
                            });
                          },
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronVisible: false,
                            rightChevronVisible: false,
                            titleTextStyle: CogoTextStyle.body16,
                          ),
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: CogoTextStyle.body14,
                            weekendStyle: CogoTextStyle.body14,
                          ),
                          calendarStyle: const CalendarStyle(
                            defaultTextStyle: CogoTextStyle.body14,
                            todayTextStyle:
                                TextStyle(color: CogoColor.systemGray05),
                            todayDecoration:
                                BoxDecoration(color: Colors.transparent),
                          ),
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, day, focusedDay) {
                              final normalizedDay =
                                  DateTime(day.year, day.month, day.day);
                              final hasSelectedTime = viewModel
                                      .selectedTimeSlots[normalizedDay]
                                      ?.isNotEmpty ??
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
                                        style: CogoTextStyle.body14
                                            .copyWith(color: CogoColor.white50),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Consumer<MentorTimeSettingViewModel>(
                  builder: (context, viewModel, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: BasicButton(
                          onPressed: () async {
                            await viewModel.putPossibleDates();
                            context.push(Paths.timeChecking, extra: {
                              'isIntroductionComplete':
                                  viewModel.isIntroductionComplete,
                            });
                          },
                          text:
                              viewModel.isIntroductionComplete ? '저장하기' : '다음',
                          isClickable: _isSelected,
                          size: BasicButtonSize.SMALL,
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
                                _isSelected = viewModel
                                        .selectedTimeSlots[selectedDay]
                                        ?.isNotEmpty ??
                                    false;
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
