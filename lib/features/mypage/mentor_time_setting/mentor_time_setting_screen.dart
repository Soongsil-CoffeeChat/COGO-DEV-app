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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Header(
                  title: 'COGO 시간',
                  subtitle: 'COGO를 진행하기 편한 시간 대를 알려주세요.',
                  onBackButtonPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 10),
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
                            calendarStyle: CalendarStyle(
                              selectedDecoration: const BoxDecoration(
                                color: CogoColor.main,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                          ),
                          Text(
                            '선택된 시간대:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: viewModel.selectedTimeSlots.length,
                            itemBuilder: (context, index) {
                              DateTime date = viewModel.selectedTimeSlots.keys
                                  .toList()[index];
                              List<int> timeSlots =
                                  viewModel.selectedTimeSlots[date]!;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                    '${date.year}-${date.month}-${date.day}: ${timeSlots.join(", ")}'),
                              );
                            },
                          ),
                          ElevatedButton(
                            onPressed: viewModel.postPossibleDates,
                            child: Text("완료하기"),
                          )
                        ]),
                  ),
                );
              }),
            ]),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(
      DateTime selectedDay, MentorTimeSettingViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              MultiSelectionTimePicker(
                selectedDay: selectedDay,
                initialSelectedTimeSlots:
                    viewModel.selectedTimeSlots[selectedDay] ?? [],
                onTimeSlotSelected: (selectedTimeSlot) {
                  viewModel.addTimeSlot(selectedDay, selectedTimeSlot);
                },
                onTimeSlotDeselected: (selectedTimeSlot) {
                  viewModel.deleteTimeSlot(selectedDay, selectedTimeSlot);
                },
                timeSlots: viewModel.timeSlots,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // 선택한 날짜를 마커로 표시
                    // viewModel.addMarkedDay(selectedDay);
                  });
                  Navigator.pop(context); // 바텀시트 닫기
                },
                child: Text("추가하기"),
              ),
            ],
          ),
        );
      },
    );
  }
}
