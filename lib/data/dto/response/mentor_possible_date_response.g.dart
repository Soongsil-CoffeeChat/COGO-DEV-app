// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_possible_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MentorPossibleDateResponseImpl _$$MentorPossibleDateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MentorPossibleDateResponseImpl(
      possibleDateId: (json['possibleDateId'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$$MentorPossibleDateResponseImplToJson(
        _$MentorPossibleDateResponseImpl instance) =>
    <String, dynamic>{
      'possibleDateId': instance.possibleDateId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'active': instance.active,
    };
