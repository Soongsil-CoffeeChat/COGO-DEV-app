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

  /// 인덱스를 기반으로 startTime과 endTime을 반환
  Map<String, String> getStartEndTime(int index) {
    if (index < 0 || index >= timeSlots.length) {
      throw ArgumentError('Invalid time slot index: $index');
    }

    // '09:00 ~ 10:00' 형식에서 분리
    final timeRange = timeSlots[index].split(' ~ ');
    return {
      'startTime': timeRange[0], // ✅ 그대로 반환
      'endTime': timeRange[1], // ✅ 그대로 반환
    };
  }

  @override
  bool operator ==(Object other) {
    return other is TimeSlotDto &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode => date.hashCode ^ startTime.hashCode ^ endTime.hashCode;
}
