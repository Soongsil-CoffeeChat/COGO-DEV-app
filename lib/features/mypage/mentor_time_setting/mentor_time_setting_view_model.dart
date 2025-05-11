import 'dart:developer';

import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/dto/request/time_select_request.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MentorTimeSettingViewModel extends ChangeNotifier {
  final PossibledateService possibledateService;
  final MentorService mentorService = GetIt.instance<MentorService>();
  bool isIntroductionComplete = false;

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

  // 기존 addTimeSlot, deleteTimeSlot도 수정!
  void addTimeSlot(DateTime date, int timeSlotIndex) {
    date = normalizeDate(date);
    _selectedTimeSlots.putIfAbsent(date, () => []);
    if (!_selectedTimeSlots[date]!.contains(timeSlotIndex)) {
      _selectedTimeSlots[date]!.add(timeSlotIndex);
    }

    final times = timeSlots[timeSlotIndex].split(' ~ ');
    final timeSlotDto = TimeSlotDto(
      date: DateFormat('yyyy-MM-dd').format(date),
      startTime: times[0],
      endTime: times[1],
    );

    _timeSlotDto.add(timeSlotDto);
    notifyListeners();
  }

  void deleteTimeSlot(DateTime date, int timeSlotIndex) {
    date = normalizeDate(date);
    _selectedTimeSlots[date]?.remove(timeSlotIndex);

    final times = timeSlots[timeSlotIndex].split(' ~ ');
    final timeSlotDto = TimeSlotDto(
      date: DateFormat('yyyy-MM-dd').format(date),
      startTime: times[0],
      endTime: times[1],
    );

    _timeSlotDto.removeWhere((slot) =>
        slot.date == timeSlotDto.date &&
        slot.startTime == timeSlotDto.startTime &&
        slot.endTime == timeSlotDto.endTime);

    notifyListeners();
  }

  Future<void> putPossibleDates() async {
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

  // 추가할 Helper 메서드
  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// 데이터를 불러오는 메서드
  Future<void> loadPossibleDatesFromApi() async {
    try {
      final response =
          await possibledateService.getMentorPossibleDatesWithToken();

      // 내용이 없으면 자기소개 미완료 상태로 처리
      if (response.isEmpty) {
        isIntroductionComplete = false;
        notifyListeners();
        return;
      }

      // 내용이 있었다면 자기소개 완료로 간주
      isIntroductionComplete = true;

      for (var data in response) {
        DateTime date = normalizeDate(DateTime.parse(data['date']));

        final startTime = data['startTime'];
        final endTime = data['endTime'];

        final slotString = '$startTime ~ $endTime';
        final slotIndex = timeSlots.indexOf(slotString);

        if (slotIndex != -1) {
          // 선택된 슬롯 관리용 Map에 저장
          _selectedTimeSlots.putIfAbsent(date, () => []);
          if (!_selectedTimeSlots[date]!.contains(slotIndex)) {
            _selectedTimeSlots[date]!.add(slotIndex);
          }

          final timeSlotDto = TimeSlotDto(
            date: DateFormat('yyyy-MM-dd').format(date),
            startTime: startTime,
            endTime: endTime,
          );

          if (!_timeSlotDto.any((slot) =>
              slot.date == timeSlotDto.date &&
              slot.startTime == timeSlotDto.startTime &&
              slot.endTime == timeSlotDto.endTime)) {
            _timeSlotDto.add(timeSlotDto);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      log('API 데이터 로딩 실패: $e');
    }
  }

  void navigateToMentorTimeChecking(BuildContext context) {
    context.push(Paths.timeChecking);
  }
}
