import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_select_request.freezed.dart';
part 'time_select_request.g.dart';

@freezed
class TimeSlotDto with _$TimeSlotDto {
  const factory TimeSlotDto({
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'startTime') required String startTime,
    @JsonKey(name: 'endTime') required String endTime,
  }) = _TimeSlotDto;

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotDtoFromJson(json);

  static const List<String> timeSlots = [
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

  static Map<String, String> getStartEndTime(int index) {
    final timeRange = timeSlots[index].split(' ~ ');
    return {
      'startTime': timeRange[0],
      'endTime': timeRange[1],
    };
  }
}
