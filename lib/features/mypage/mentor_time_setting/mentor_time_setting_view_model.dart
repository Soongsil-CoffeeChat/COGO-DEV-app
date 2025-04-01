import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/dto/request/time_select_request.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
    log('$times');

    // 시작 시간과 끝 시간을 DateTime으로 변환
    final startDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(times[0].split(':')[0]),
      int.parse(times[0].split(':')[1]),
    );
    final endDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(times[1].split(':')[0]),
      int.parse(times[1].split(':')[1]),
    );

    // 시간 포맷
    final formatter = DateFormat('HH:mm');
    final startTime = formatter.format(startDateTime);
    final endTime = formatter.format(endDateTime);

    log('start time : $startTime End time $endTime');

    // DTO 생성
    final timeSlotDto = TimeSlotDto(
      date: date.toIso8601String().split('T')[0],
      startTime: startTime,
      endTime: endTime,
    );

    _timeSlotDto.add(timeSlotDto);
    notifyListeners();
  }

  void deleteTimeSlot(DateTime date, int timeSlotIndex) {
    _selectedTimeSlots[date]?.remove(timeSlotIndex);

    final timeSlot = timeSlots[timeSlotIndex];
    final times = timeSlot.split(' ~ ');

    final startDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(times[0].split(':')[0]),
      int.parse(times[0].split(':')[1]),
    );
    final endDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(times[1].split(':')[0]),
      int.parse(times[1].split(':')[1]),
    );

    // 시간 포맷
    final formatter = DateFormat('HH:mm');
    final startTime = formatter.format(startDateTime);
    final endTime = formatter.format(endDateTime);

    final timeSlotDto = TimeSlotDto(
      date: date.toIso8601String().split('T')[0],
      startTime: startTime,
      endTime: endTime,
    );

    _timeSlotDto.remove(timeSlotDto);
    notifyListeners();
  }

  Future<void> postPossibleDates() async {
    try {
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

  void navigateToMentorTimeChecking(BuildContext context) {
    context.push(Paths.timeChecking);
  }
}
