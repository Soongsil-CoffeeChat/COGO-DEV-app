import 'dart:developer';

import 'package:cogo/data/dto/request/time_select_request.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MentorTimeSettingViewModel extends ChangeNotifier {
  final PossibledateService possibledateService;

  MentorTimeSettingViewModel({required this.possibledateService});

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

  // late final DateTime selectedDay ;

  // 인덱스
  final List<int> _selectedTimeSlots = [];

  List<int> get selectedTimeSlots => _selectedTimeSlots;

  // 선택된 시간대 리스트 가져오기
  final List<TimeSlotDto> _timeSlotDto = [];

  List<TimeSlotDto> get timeSlotDto => _timeSlotDto;

  // 시간대 추가 메서드
  void addTimeSlot(DateTime date, int timeSlotIndex) {
    selectedTimeSlots.add(timeSlotIndex);

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
      date: date.toString(),
      startTime: startTime,
      endTime: endTime,
    );

    // 리스트에 추가하고 UI 업데이트
    _timeSlotDto.add(timeSlotDto);
    notifyListeners();

    log(timeSlotDto.toJson().toString());
  }

  void deleteTimeSlot(DateTime date, int timeSlotIndex) {
    selectedTimeSlots.remove(timeSlotIndex);

    // 시간대 문자열에서 시작 시간과 끝 시간을 추출
    final timeSlot = timeSlots[timeSlotIndex];
    final times = timeSlot.split(' ~ ');
    final startTime = '${times[0]}:00';
    final endTime = '${times[1]}:00';

    // DTO 생성
    final timeSlotDto = TimeSlotDto(
      date: date.toString(),
      startTime: startTime,
      endTime: endTime,
    );

    _timeSlotDto.remove(timeSlotDto);
  }

  // 선택된 시간대 리스트를 JSON 리스트로 반환
  List<Map<String, dynamic>> toJsonList() {
    return _timeSlotDto.map((dto) => dto.toJson()).toList();
  }

  Future<void> postPossibleDates() async {
    try {
      final result =
          await possibledateService.updateMentorPossibleDates(_timeSlotDto);

      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      // _errorMessage = 'Google 로그인에 실패했습니다. 다시 시도해주세요.';

      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }
}
