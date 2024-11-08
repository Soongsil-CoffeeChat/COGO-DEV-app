import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/dto/response/mentor_possible_date_response.dart';
import 'package:cogo/domain/entity/mentor_possible_date_entity.dart';
import 'package:flutter/material.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:go_router/go_router.dart';

class ScheduleViewModel extends ChangeNotifier {
  final PossibledateService _possibledateService = PossibledateService();

  DateTime selectedDate = DateTime.now();
  int selectedTimeSlot = -1;

  List<MentorPossibleDateEntity> mentorPossibleDates = []; // mentor 가능한 날짜 목록
  List<DateTime> availableDates = []; // DatePicker에 사용할 날짜 목록
  List<String> filteredTimeSlots = []; // 선택된 날짜에 맞는 시간대 목록

  // 멘토 가능한 시간 api 호출
  Future<void> fetchMentorPossibleDates(int mentorId) async {
    try {
      // API 호출
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

  void onDateSelected(DateTime date) {
    selectedDate = date;

    filteredTimeSlots = mentorPossibleDates
        .where((dateInfo) =>
            dateInfo.date.year == selectedDate.year &&
            dateInfo.date.month == selectedDate.month &&
            dateInfo.date.day == selectedDate.day)
        .map((dateInfo) => dateInfo.formattedTimeSlot)
        .toList();

    notifyListeners();
  }

  void onTimeSlotSelected(int index) {
    selectedTimeSlot = index;
    notifyListeners();
  }

  void saveSelection(BuildContext context) {
    final selectedData = {
      'selectedDate': selectedDate.toIso8601String(),
      'selectedTimeSlot': selectedTimeSlot,
    };

    context.push(Paths.memo, extra: selectedData);
  }
}
