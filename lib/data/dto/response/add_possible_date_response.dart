import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_possible_date_response.freezed.dart';
part 'add_possible_date_response.g.dart';

@freezed
class AddPossibleDateResponse with _$AddPossibleDateResponse {
  const factory AddPossibleDateResponse({
    @Default(0) int possibleDateId,
    required String date,
    required String startTime,
    required String endTime,
  }) = _AddPossibleDateResponse;

  factory AddPossibleDateResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPossibleDateResponseFromJson(json);

  // JSON 리스트를 AddPossibleDateResponse 리스트로 변환
  static List<AddPossibleDateResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => AddPossibleDateResponse.fromJson(json))
        .toList();
  }

  // AddPossibleDateResponse 리스트를 JSON 리스트로 변환
  static List<Map<String, dynamic>> toJsonList(
      List<AddPossibleDateResponse> timeSlots) {
    return timeSlots.map((timeSlot) => timeSlot.toJson()).toList();
  }
}
