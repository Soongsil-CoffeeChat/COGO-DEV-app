class AddPossibleDateResponse {
  final int possibleDateId;
  final String date;
  final String startTime;
  final String endTime;

  AddPossibleDateResponse({
    this.possibleDateId = 0,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  // JSON 데이터를 객체로 변환
  factory AddPossibleDateResponse.fromJson(Map<String, dynamic> json) {
    return AddPossibleDateResponse(
      possibleDateId: json['possible_date_id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }

  // 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      'possible_date_id': possibleDateId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  // JSON 리스트를 TimeSlotDto 리스트로 변환
  static List<AddPossibleDateResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => AddPossibleDateResponse.fromJson(json))
        .toList();
  }

  // TimeSlotDto 리스트를 JSON 리스트로 변환
  static List<Map<String, dynamic>> toJsonList(
      List<AddPossibleDateResponse> timeSlots) {
    return timeSlots.map((timeSlot) => timeSlot.toJson()).toList();
  }
}
