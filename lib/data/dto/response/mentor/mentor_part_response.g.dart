// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MentorPartResponseImpl _$$MentorPartResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MentorPartResponseImpl(
      picture: json['picture'] as String?,
      mentorName: json['mentorName'] as String?,
      part: json['part'] as String?,
      club: json['club'] as String?,
      username: json['username'] as String?,
      mentorId: (json['mentorId'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$MentorPartResponseImplToJson(
        _$MentorPartResponseImpl instance) =>
    <String, dynamic>{
      'picture': instance.picture,
      'mentorName': instance.mentorName,
      'part': instance.part,
      'club': instance.club,
      'username': instance.username,
      'mentorId': instance.mentorId,
      'title': instance.title,
      'description': instance.description,
    };
