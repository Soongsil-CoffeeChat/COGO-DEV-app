class TimeSlotDto {
  final String date;
  final String startTime;
  final String endTime;

  TimeSlotDto({
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  // JSON 데이터를 객체로 변환
  factory TimeSlotDto.fromJson(Map<String, dynamic> json) {
    return TimeSlotDto(
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }

  // 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  // JSON 리스트를 TimeSlotDto 리스트로 변환
  static List<TimeSlotDto> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TimeSlotDto.fromJson(json)).toList();
  }

  // TimeSlotDto 리스트를 JSON 리스트로 변환
  static List<Map<String, dynamic>> toJsonList(List<TimeSlotDto> timeSlots) {
    return timeSlots.map((timeSlot) => timeSlot.toJson()).toList();
  }
}
