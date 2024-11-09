import 'package:cogo/common/widgets/multi_selection_time_picker.dart';
import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
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
  DateTime _focusedDay = DateTime.now(); // 현재 날짜로 설정
  DateTime? _selectedDay;
  final Set<DateTime> _markedDays = {}; // 저장한 날 Set
  final List<int> _selectedTimeSlotIndexs = []; // 선택된 시간대 리스트 추가

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MentorTimeSettingViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // 키보드 오버 플로우 해결
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
                            // 달력 시작 날짜는 오늘 이후
                            lastDay: DateTime(2100),
                            // 달력 끝 날짜
                            focusedDay: _focusedDay,
                            // 포커스된 날짜
                            selectedDayPredicate: (day) =>
                                isSameDay(_selectedDay, day),
                            onDaySelected: (selectedDay, focusedDay) {
                              //todo 선택되었을시 시간 컴포넌트 뜸
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay; // 포커스된 날짜 업데이트
                                _showBottomSheet(
                                    selectedDay, viewModel); // 날짜 선택 시 바텀시트 표시
                              });
                            },
                            calendarFormat: CalendarFormat.month,
                            calendarStyle: CalendarStyle(
                                selectedDecoration: const BoxDecoration(
                                  color: CogoColor.main,
                                  // 선택된 날짜의 배경색을 검정색으로 설정
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: CogoColor.main, width: 1.5)),
                                todayTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            // 달력 형식 설정 (month, twoWeeks, week)
                            onFormatChanged: (format) {
                              setState(() {
                                // 사용자 상호작용에 따라 달력 형식 변경
                              });
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay =
                                  focusedDay; // 페이지가 변경될 때 포커스된 날짜 업데이트
                            },
                            // 마커 표시를 위해 CalendarBuilders 사용
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, day, focusedDay) {
                                if (_markedDays.contains(day)) {
                                  return Positioned(
                                    top: 4,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: CogoColor.main, // 빨간 점
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                }
                                return null;
                              },
                            ),
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
                            itemCount: _selectedTimeSlotIndexs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                    _selectedTimeSlotIndexs[index].toString()),
                              );
                            },
                          ),
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
                // onTimeSlotSelected: ,
                selectedTimeSlots: {},
                onTimeSlotSelected: (selectedTimeSlot) {
                  setState(() {
                    _selectedTimeSlotIndexs
                        .add(selectedTimeSlot); // 선택한 시간대를 리스트에 추가
                    viewModel.addTimeSlot(selectedDay, selectedTimeSlot);
                  });
                },
                timeSlots: viewModel.timeSlots,
              ),

              const SizedBox(height: 20),
              // 추가 버튼이나 기능을 여기에 넣을 수 있음
              ElevatedButton(
                onPressed: () {
                  // 원하는 기능 수행
                  setState(() {
                    _markedDays.add(selectedDay); // 선택한 날짜를 빨간색으로 표시할 리스트에 추가
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
