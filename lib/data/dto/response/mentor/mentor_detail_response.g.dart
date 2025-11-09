// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MentorDetailResponseImpl _$$MentorDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MentorDetailResponseImpl(
      mentorId: (json['mentorId'] as num).toInt(),
      mentorName: json['mentorName'] as String?,
      part: json['part'] as String?,
      club: json['club'] as String?,
      introductionTitle: json['introductionTitle'] as String?,
      introductionDescription: json['introductionDescription'] as String?,
      introductionAnswer1: json['introductionAnswer1'] as String?,
      introductionAnswer2: json['introductionAnswer2'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$MentorDetailResponseImplToJson(
        _$MentorDetailResponseImpl instance) =>
    <String, dynamic>{
      'mentorId': instance.mentorId,
      'mentorName': instance.mentorName,
      'part': instance.part,
      'club': instance.club,
      'introductionTitle': instance.introductionTitle,
      'introductionDescription': instance.introductionDescription,
      'introductionAnswer1': instance.introductionAnswer1,
      'introductionAnswer2': instance.introductionAnswer2,
      'imageUrl': instance.imageUrl,
    };
