// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_possible_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddPossibleDateResponseImpl _$$AddPossibleDateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddPossibleDateResponseImpl(
      possibleDateId: (json['possibleDateId'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$$AddPossibleDateResponseImplToJson(
        _$AddPossibleDateResponseImpl instance) =>
    <String, dynamic>{
      'possibleDateId': instance.possibleDateId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'active': instance.active,
    };
