import 'dart:developer';

import 'package:cogo/data/dto/request/time_select_request.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class MentorTimeSettingViewModel extends ChangeNotifier {
  final PossibledateService possibledateService;

  MentorTimeSettingViewModel({required this.possibledateService});

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

  // 날짜별 시간대 인덱스 리스트
  final Map<DateTime, List<int>> _selectedTimeSlots = {};

  Map<DateTime, List<int>> get selectedTimeSlots => _selectedTimeSlots;

  // 선택된 시간대 DTO 리스트
  final List<TimeSlotDto> _timeSlotDto = [];
  List<TimeSlotDto> get timeSlotDto => _timeSlotDto;

  void addTimeSlot(DateTime date, int timeSlotIndex) {
    if (_selectedTimeSlots[date] == null) {
      _selectedTimeSlots[date] = [];
    }

    _selectedTimeSlots[date]!.add(timeSlotIndex);

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

    _timeSlotDto.add(timeSlotDto);
    notifyListeners();
  }

  void deleteTimeSlot(DateTime date, int timeSlotIndex) {
    _selectedTimeSlots[date]?.remove(timeSlotIndex);

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
    notifyListeners();
  }

// 선택된 시간대 리스트를 JSON 리스트로 반환
  List<Map<String, dynamic>> toJsonList() {
    final jsonList = _timeSlotDto.map((dto) => dto.toJson()).toList();

    // JSON 리스트를 로그로 출력
    log("toJsonList: ${jsonList.toString()}");

    return jsonList;
  }

  Future<void> postPossibleDates() async {
    try {
      final result =
          await possibledateService.updateMentorPossibleDates(_timeSlotDto);
      notifyListeners();
    } catch (e) {
      log("Exception occurred: $e");
      if (e is DioException) {
        log("DioError details: ${e.response?.data}");
      }
      notifyListeners();
    }
  }
}
