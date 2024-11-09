import 'package:cogo/data/dto/request/time_select_requset.dart';
import 'package:flutter/material.dart';

class MentorTimeSettingViewModel extends ChangeNotifier {
  // 시간대 리스트
  final List<String> timeSlots = [
    '09:00 ~ 10:00',
    '10:00 ~ 11:00',
    '11:00 ~ 12:00',
    '13:00 ~ 14:00',
    '14:00 ~ 15:00',
    '15:00 ~ 16:00',
    '16:00 ~ 17:00',
    '17:00 ~ 18:00',
    '18:00 ~ 19:00',
    '19:00 ~ 20:00',
    '20:00 ~ 21:00',
  ];

  final List<TimeSlotDto> _selectedTimeSlots = [];

  // 선택된 시간대 리스트 가져오기
  List<TimeSlotDto> get selectedTimeSlots => _selectedTimeSlots;

  // 시간대 추가 메서드
  void addTimeSlot(DateTime date, int timeSlotIndex) {
    if (timeSlotIndex < 0 || timeSlotIndex >= timeSlots.length) {
      return; // 잘못된 인덱스는 무시
    }

    // 시간대 문자열에서 시작 시간과 끝 시간을 추출
    final timeSlot = timeSlots[timeSlotIndex];
    final times = timeSlot.split(' ~ ');
    final startTime = '${times[0]}:00';
    final endTime = '${times[1]}:00';

    // DTO 생성
    final timeSlotDto = TimeSlotDto(
      date: date,
      startTime: startTime,
      endTime: endTime,
    );

    // 리스트에 추가하고 UI 업데이트
    _selectedTimeSlots.add(timeSlotDto);
    notifyListeners();
  }

  // 선택된 시간대 리스트를 JSON 리스트로 반환
  List<Map<String, dynamic>> toJsonList() {
    return _selectedTimeSlots.map((dto) => dto.toJson()).toList();
  }
}
