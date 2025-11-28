// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_cogo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LinkedCogoResponseImpl _$$LinkedCogoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LinkedCogoResponseImpl(
      applicationId: (json['applicationId'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
    );

Map<String, dynamic> _$$LinkedCogoResponseImplToJson(
        _$LinkedCogoResponseImpl instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'date': instance.date,
      'startTime': instance.startTime,
    };
