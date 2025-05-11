import 'dart:developer';

import 'package:cogo/common/utils/routing_extension.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/data/dto/response/mentor_possible_date_response.dart';
import 'package:cogo/data/repository/local/secure_storage_repository.dart';
import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/data/service/possibledate_service.dart';
import 'package:cogo/domain/entity/mentor_possible_date_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MentorTimeCheckingViewModel extends ChangeNotifier {
  final PossibledateService _possibledateService = PossibledateService();
  final MentorService mentorService = GetIt.instance<MentorService>();
  List<MentorPossibleDateEntity> mentorPossibleDates = []; // 멘토 가능한 날짜 및 시간대 목록
  Map<DateTime, List<MentorPossibleDateEntity>> groupedDates =
      {}; // 날짜별로 그룹화된 시간대 목록
  List<DateTime> sortedDates = []; // 정렬된 날짜 목록

  Future<void> getPossibleDates() async {
    try {
      final response =
          await _possibledateService.getMentorPossibleDatesWithToken();

      mentorPossibleDates = response
          .map((json) => MentorPossibleDateEntity.fromResponse(
              MentorPossibleDateResponse.fromJson(json)))
          .toList();

      /// 날짜별로 시간대 그룹화
      groupedDates = {};
      for (var dateInfo in mentorPossibleDates) {
        if (!groupedDates.containsKey(dateInfo.date)) {
          groupedDates[dateInfo.date] = [];
        }
        groupedDates[dateInfo.date]?.add(dateInfo);
      }

      /// 날짜를 오늘 날짜 기준으로 정렬
      sortedDates = groupedDates.keys.toList()..sort((a, b) => a.compareTo(b));

      notifyListeners();
    } catch (e) {
      log("예외 발생: $e");
      if (e is DioError) {
        log("DioError 세부 정보: ${e.response?.data}");
      }
      notifyListeners();
    }
  }

  void navigateToBack(BuildContext context) {
    context.popUntil(Paths.home);
  }
}
