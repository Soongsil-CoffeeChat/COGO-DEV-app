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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Calendar Example')),
      body: TableCalendar(
        firstDay: DateTime.now(),
        // 달력 시작 날짜는 오늘 이후
        lastDay: DateTime(2100),
        // 달력 끝 날짜
        focusedDay: _focusedDay,
        // 포커스된 날짜
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          //todo 선택되었을시 시간 컴포넌트 뜸
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // 포커스된 날짜 업데이트
          });
        },
        calendarFormat: CalendarFormat.month,
        // 달력 형식 설정 (month, twoWeeks, week)
        onFormatChanged: (format) {
          setState(() {
            // 사용자 상호작용에 따라 달력 형식 변경
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay; // 페이지가 변경될 때 포커스된 날짜 업데이트
        },
      ),
    );
  }
}
