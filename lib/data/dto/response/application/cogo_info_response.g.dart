// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cogo_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CogoInfoResponseImpl _$$CogoInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CogoInfoResponseImpl(
      applicationId: (json['applicationId'] as num).toInt(),
      menteeName: json['menteeName'] as String,
      mentorName: json['mentorName'] as String,
      applicationMemo: json['applicationMemo'] as String,
      applicationDate: json['applicationDate'] as String,
      applicationStartTime: json['applicationStartTime'] as String,
      applicationEndTime: json['applicationEndTime'] as String,
    );

Map<String, dynamic> _$$CogoInfoResponseImplToJson(
        _$CogoInfoResponseImpl instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'menteeName': instance.menteeName,
      'mentorName': instance.mentorName,
      'applicationMemo': instance.applicationMemo,
      'applicationDate': instance.applicationDate,
      'applicationStartTime': instance.applicationStartTime,
      'applicationEndTime': instance.applicationEndTime,
    };
