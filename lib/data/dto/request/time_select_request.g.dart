// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_select_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeSlotDtoImpl _$$TimeSlotDtoImplFromJson(Map<String, dynamic> json) =>
    _$TimeSlotDtoImpl(
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$TimeSlotDtoImplToJson(_$TimeSlotDtoImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
