// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_part_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MentorPartResponse _$MentorPartResponseFromJson(Map<String, dynamic> json) {
  return _MentorPartResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorPartResponse {
  String? get picture => throw _privateConstructorUsedError;
  String? get mentorName => throw _privateConstructorUsedError;
  String? get part => throw _privateConstructorUsedError;
  String? get club => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  int get mentorId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MentorPartResponseCopyWith<MentorPartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorPartResponseCopyWith<$Res> {
  factory $MentorPartResponseCopyWith(
          MentorPartResponse value, $Res Function(MentorPartResponse) then) =
      _$MentorPartResponseCopyWithImpl<$Res, MentorPartResponse>;
  @useResult
  $Res call(
      {String? picture,
      String? mentorName,
      String? part,
      String? club,
      String? username,
      int mentorId,
      String? title,
      String? description});
}

/// @nodoc
class _$MentorPartResponseCopyWithImpl<$Res, $Val extends MentorPartResponse>
    implements $MentorPartResponseCopyWith<$Res> {
  _$MentorPartResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? picture = freezed,
    Object? mentorName = freezed,
    Object? part = freezed,
    Object? club = freezed,
    Object? username = freezed,
    Object? mentorId = null,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      mentorName: freezed == mentorName
          ? _value.mentorName
          : mentorName // ignore: cast_nullable_to_non_nullable
              as String?,
      part: freezed == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
      club: freezed == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      mentorId: null == mentorId
          ? _value.mentorId
          : mentorId // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MentorPartResponseImplCopyWith<$Res>
    implements $MentorPartResponseCopyWith<$Res> {
  factory _$$MentorPartResponseImplCopyWith(_$MentorPartResponseImpl value,
          $Res Function(_$MentorPartResponseImpl) then) =
      __$$MentorPartResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? picture,
      String? mentorName,
      String? part,
      String? club,
      String? username,
      int mentorId,
      String? title,
      String? description});
}

/// @nodoc
class __$$MentorPartResponseImplCopyWithImpl<$Res>
    extends _$MentorPartResponseCopyWithImpl<$Res, _$MentorPartResponseImpl>
    implements _$$MentorPartResponseImplCopyWith<$Res> {
  __$$MentorPartResponseImplCopyWithImpl(_$MentorPartResponseImpl _value,
      $Res Function(_$MentorPartResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? picture = freezed,
    Object? mentorName = freezed,
    Object? part = freezed,
    Object? club = freezed,
    Object? username = freezed,
    Object? mentorId = null,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_$MentorPartResponseImpl(
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      mentorName: freezed == mentorName
          ? _value.mentorName
          : mentorName // ignore: cast_nullable_to_non_nullable
              as String?,
      part: freezed == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
      club: freezed == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      mentorId: null == mentorId
          ? _value.mentorId
          : mentorId // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MentorPartResponseImpl implements _MentorPartResponse {
  const _$MentorPartResponseImpl(
      {this.picture,
      this.mentorName,
      this.part,
      this.club,
      this.username,
      required this.mentorId,
      this.title,
      this.description});

  factory _$MentorPartResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MentorPartResponseImplFromJson(json);

  @override
  final String? picture;
  @override
  final String? mentorName;
  @override
  final String? part;
  @override
  final String? club;
  @override
  final String? username;
  @override
  final int mentorId;
  @override
  final String? title;
  @override
  final String? description;

  @override
  String toString() {
    return 'MentorPartResponse(picture: $picture, mentorName: $mentorName, part: $part, club: $club, username: $username, mentorId: $mentorId, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorPartResponseImpl &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.mentorName, mentorName) ||
                other.mentorName == mentorName) &&
            (identical(other.part, part) || other.part == part) &&
            (identical(other.club, club) || other.club == club) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.mentorId, mentorId) ||
                other.mentorId == mentorId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, picture, mentorName, part, club,
      username, mentorId, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorPartResponseImplCopyWith<_$MentorPartResponseImpl> get copyWith =>
      __$$MentorPartResponseImplCopyWithImpl<_$MentorPartResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorPartResponseImplToJson(
      this,
    );
  }
}

abstract class _MentorPartResponse implements MentorPartResponse {
  const factory _MentorPartResponse(
      {final String? picture,
      final String? mentorName,
      final String? part,
      final String? club,
      final String? username,
      required final int mentorId,
      final String? title,
      final String? description}) = _$MentorPartResponseImpl;

  factory _MentorPartResponse.fromJson(Map<String, dynamic> json) =
      _$MentorPartResponseImpl.fromJson;

  @override
  String? get picture;
  @override
  String? get mentorName;
  @override
  String? get part;
  @override
  String? get club;
  @override
  String? get username;
  @override
  int get mentorId;
  @override
  String? get title;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$MentorPartResponseImplCopyWith<_$MentorPartResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
