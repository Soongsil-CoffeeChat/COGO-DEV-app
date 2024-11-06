import 'package:cogo/common/widgets/widgets.dart';
import 'package:cogo/constants/colors.dart';
import 'package:flutter/material.dart';
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
  final Set<DateTime> _markedDays = {}; // 빨간색으로 표시할 날짜들을 저장하는 Set

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // 키보드 오버 플로우 해결
      body: SafeArea(
        child: SingleChildScrollView(
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
                    const SizedBox(height: 10),
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
                          _showBottomSheet(selectedDay); // 날짜 선택 시 바텀시트 표시
                        });
                      },
                      calendarFormat: CalendarFormat.month,
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: CogoColor.main, // 선택된 날짜의 배경색을 검정색으로 설정
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: CogoColor.systemGray04, // 오늘 날짜의 배경색
                          shape: BoxShape.circle,
                        ),
                        // markerDecoration: BoxDecoration(
                        //   color: Colors.red, // 빨간색 표시
                        //   shape: BoxShape.circle,
                        // ),
                      ),
                      // 달력 형식 설정 (month, twoWeeks, week)
                      onFormatChanged: (format) {
                        setState(() {
                          // 사용자 상호작용에 따라 달력 형식 변경
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay; // 페이지가 변경될 때 포커스된 날짜 업데이트
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
                                decoration: BoxDecoration(
                                  color: Colors.red, // 빨간 점
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }

  void _showBottomSheet(DateTime selectedDay) {
    List<String> timeSlots = [];

    for (int hour = 9; hour < 22; hour++) {
      String startTime = '${hour.toString().padLeft(2, '0')}:00';
      String endTime = '${(hour + 1).toString().padLeft(2, '0')}:00';
      timeSlots.add('$startTime ~ $endTime');
    }

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

              TimePicker(
                timeSlots: timeSlots,
                // onTimeSlotSelected: ,
              ),

              const SizedBox(height: 20),
              Text(
                "You can add more information here or actions related to this date.",
                style: TextStyle(fontSize: 16),
              ),
              // 추가 버튼이나 기능을 여기에 넣을 수 있음
              ElevatedButton(
                onPressed: () {
                  // 원하는 기능 수행
                  setState(() {
                    _markedDays.add(selectedDay); // 선택한 날짜를 빨간색으로 표시할 리스트에 추가
                  });
                  Navigator.pop(context); // 바텀시트 닫기
                },
                child: Text("Confirm Selection"),
              ),
            ],
          ),
        );
      },
    );
  }
}
