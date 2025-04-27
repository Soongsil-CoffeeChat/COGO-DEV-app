// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_signup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MentorSignupResponse _$MentorSignupResponseFromJson(Map<String, dynamic> json) {
  return _MentorSignupResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorSignupResponse {
  @JsonKey(name: 'part')
  String get part => throw _privateConstructorUsedError;
  @JsonKey(name: 'club')
  String get club => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MentorSignupResponseCopyWith<MentorSignupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorSignupResponseCopyWith<$Res> {
  factory $MentorSignupResponseCopyWith(MentorSignupResponse value,
          $Res Function(MentorSignupResponse) then) =
      _$MentorSignupResponseCopyWithImpl<$Res, MentorSignupResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'part') String part, @JsonKey(name: 'club') String club});
}

/// @nodoc
class _$MentorSignupResponseCopyWithImpl<$Res,
        $Val extends MentorSignupResponse>
    implements $MentorSignupResponseCopyWith<$Res> {
  _$MentorSignupResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
    Object? club = null,
  }) {
    return _then(_value.copyWith(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
      club: null == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MentorSignupResponseImplCopyWith<$Res>
    implements $MentorSignupResponseCopyWith<$Res> {
  factory _$$MentorSignupResponseImplCopyWith(_$MentorSignupResponseImpl value,
          $Res Function(_$MentorSignupResponseImpl) then) =
      __$$MentorSignupResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'part') String part, @JsonKey(name: 'club') String club});
}

/// @nodoc
class __$$MentorSignupResponseImplCopyWithImpl<$Res>
    extends _$MentorSignupResponseCopyWithImpl<$Res, _$MentorSignupResponseImpl>
    implements _$$MentorSignupResponseImplCopyWith<$Res> {
  __$$MentorSignupResponseImplCopyWithImpl(_$MentorSignupResponseImpl _value,
      $Res Function(_$MentorSignupResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
    Object? club = null,
  }) {
    return _then(_$MentorSignupResponseImpl(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
      club: null == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MentorSignupResponseImpl implements _MentorSignupResponse {
  const _$MentorSignupResponseImpl(
      {@JsonKey(name: 'part') required this.part,
      @JsonKey(name: 'club') required this.club});

  factory _$MentorSignupResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MentorSignupResponseImplFromJson(json);

  @override
  @JsonKey(name: 'part')
  final String part;
  @override
  @JsonKey(name: 'club')
  final String club;

  @override
  String toString() {
    return 'MentorSignupResponse(part: $part, club: $club)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorSignupResponseImpl &&
            (identical(other.part, part) || other.part == part) &&
            (identical(other.club, club) || other.club == club));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, part, club);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorSignupResponseImplCopyWith<_$MentorSignupResponseImpl>
      get copyWith =>
          __$$MentorSignupResponseImplCopyWithImpl<_$MentorSignupResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorSignupResponseImplToJson(
      this,
    );
  }
}

abstract class _MentorSignupResponse implements MentorSignupResponse {
  const factory _MentorSignupResponse(
          {@JsonKey(name: 'part') required final String part,
          @JsonKey(name: 'club') required final String club}) =
      _$MentorSignupResponseImpl;

  factory _MentorSignupResponse.fromJson(Map<String, dynamic> json) =
      _$MentorSignupResponseImpl.fromJson;

  @override
  @JsonKey(name: 'part')
  String get part;
  @override
  @JsonKey(name: 'club')
  String get club;
  @override
  @JsonKey(ignore: true)
  _$$MentorSignupResponseImplCopyWith<_$MentorSignupResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
