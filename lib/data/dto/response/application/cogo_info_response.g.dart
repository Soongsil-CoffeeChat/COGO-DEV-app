// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cogo_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CogoInfoResponseImpl _$$CogoInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CogoInfoResponseImpl(
      applicationId: (json['applicationId'] as num).toInt(),
      otherPartyName: json['otherPartyName'] as String,
      applicationStatus: json['applicationStatus'] as String?,
      applicationDate: json['applicationDate'] as String,
    );

Map<String, dynamic> _$$CogoInfoResponseImplToJson(
        _$CogoInfoResponseImpl instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'otherPartyName': instance.otherPartyName,
      'applicationStatus': instance.applicationStatus,
      'applicationDate': instance.applicationDate,
    };
