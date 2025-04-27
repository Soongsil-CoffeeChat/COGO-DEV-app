// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cogo_application_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CogoApplicationResponseImpl _$$CogoApplicationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CogoApplicationResponseImpl(
      applicationId: (json['applicationId'] as num).toInt(),
      mentorId: (json['mentorId'] as num).toInt(),
      menteeId: (json['menteeId'] as num).toInt(),
      applicationMemo: json['applicationMemo'] as String,
      applicationDate: json['applicationDate'] as String,
      applicationStartTime: json['applicationStartTime'] as String,
      applicationEndTime: json['applicationEndTime'] as String,
    );

Map<String, dynamic> _$$CogoApplicationResponseImplToJson(
        _$CogoApplicationResponseImpl instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'mentorId': instance.mentorId,
      'menteeId': instance.menteeId,
      'applicationMemo': instance.applicationMemo,
      'applicationDate': instance.applicationDate,
      'applicationStartTime': instance.applicationStartTime,
      'applicationEndTime': instance.applicationEndTime,
    };
