import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/dto/response/mentor_possible_date_response.dart';
import 'package:cogo/domain/entity/mentor_possible_date_entity.dart';
import 'package:flutter/material.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:go_router/go_router.dart';

class ScheduleViewModel extends ChangeNotifier {
  final PossibledateService _possibledateService = PossibledateService();

  DateTime selectedDate = DateTime.now();
  int selectedTimeSlot = -1; // 선택된 시간대의 인덱스
  int? selectedPossibleDateId; // 선택된 시간대의 possibleDateId

  List<MentorPossibleDateEntity> mentorPossibleDates = []; // 멘토 가능한 날짜 및 시간대 목록
  List<DateTime> availableDates = []; // DatePicker에 사용할 날짜 목록
  List<String> filteredTimeSlots = []; // 선택된 날짜에 맞는 시간대 목록

  // 멘토 가능한 시간 API 호출
  Future<void> fetchMentorPossibleDates(int mentorId) async {
    try {
      final response =
          await _possibledateService.getMentorPossibleDates(mentorId);

      mentorPossibleDates = response
          .map((json) => MentorPossibleDateEntity.fromResponse(
              MentorPossibleDateResponse.fromJson(json)))
          .toList();

      availableDates =
          mentorPossibleDates.map((dateInfo) => dateInfo.date).toSet().toList();

      onDateSelected(selectedDate);

      notifyListeners();
    } catch (e) {
      notifyListeners();
      throw Exception('Failed to fetch possible dates: $e');
    }
  }

  // 특정 날짜 선택 시 호출
  void onDateSelected(DateTime date) {
    selectedDate = date;

    // 선택된 날짜에 맞는 시간대와 possibleDateId 필터링
    final slots = mentorPossibleDates
        .where((dateInfo) =>
            dateInfo.date.year == selectedDate.year &&
            dateInfo.date.month == selectedDate.month &&
            dateInfo.date.day == selectedDate.day)
        .toList();

    filteredTimeSlots =
        slots.map((dateInfo) => dateInfo.formattedTimeSlot).toList();

    if (slots.isNotEmpty) {
      selectedTimeSlot = 0;
      selectedPossibleDateId = slots[0].possibleDateId;
    } else {
      selectedTimeSlot = -1;
      selectedPossibleDateId = null;
    }

    notifyListeners();
  }

  void onTimeSlotSelected(int index) {
    selectedTimeSlot = index;

    // 선택된 시간대에 맞는 possibleDateId 설정
    final matchingSlot = mentorPossibleDates
        .where((dateInfo) =>
            dateInfo.date.year == selectedDate.year &&
            dateInfo.date.month == selectedDate.month &&
            dateInfo.date.day == selectedDate.day)
        .toList();

    if (index >= 0 && index < matchingSlot.length) {
      selectedPossibleDateId = matchingSlot[index].possibleDateId;
    } else {
      selectedPossibleDateId = null;
    }

    notifyListeners();
  }

  void saveSelection(BuildContext context, int mentorId) {
    if (selectedPossibleDateId == null) {
      throw Exception('No time slot selected or available');
    }

    final extraData = {
      'possibleDateId': selectedPossibleDateId,
      'mentorId': mentorId,
    };

    context.push(Paths.memo, extra: extraData);
  }
}
