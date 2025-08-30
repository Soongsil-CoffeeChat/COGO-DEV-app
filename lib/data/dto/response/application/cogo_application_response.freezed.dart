// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cogo_application_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CogoApplicationResponse _$CogoApplicationResponseFromJson(
    Map<String, dynamic> json) {
  return _CogoApplicationResponse.fromJson(json);
}

/// @nodoc
mixin _$CogoApplicationResponse {
  @JsonKey(name: 'applicationId')
  int get applicationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'mentorId')
  int get mentorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'menteeId')
  int get menteeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicationMemo')
  String get applicationMemo => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicationDate')
  String get applicationDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicationStartTime')
  String get applicationStartTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicationEndTime')
  String get applicationEndTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CogoApplicationResponseCopyWith<CogoApplicationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CogoApplicationResponseCopyWith<$Res> {
  factory $CogoApplicationResponseCopyWith(CogoApplicationResponse value,
          $Res Function(CogoApplicationResponse) then) =
      _$CogoApplicationResponseCopyWithImpl<$Res, CogoApplicationResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'applicationId') int applicationId,
      @JsonKey(name: 'mentorId') int mentorId,
      @JsonKey(name: 'menteeId') int menteeId,
      @JsonKey(name: 'applicationMemo') String applicationMemo,
      @JsonKey(name: 'applicationDate') String applicationDate,
      @JsonKey(name: 'applicationStartTime') String applicationStartTime,
      @JsonKey(name: 'applicationEndTime') String applicationEndTime});
}

/// @nodoc
class _$CogoApplicationResponseCopyWithImpl<$Res,
        $Val extends CogoApplicationResponse>
    implements $CogoApplicationResponseCopyWith<$Res> {
  _$CogoApplicationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
    Object? mentorId = null,
    Object? menteeId = null,
    Object? applicationMemo = null,
    Object? applicationDate = null,
    Object? applicationStartTime = null,
    Object? applicationEndTime = null,
  }) {
    return _then(_value.copyWith(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
      mentorId: null == mentorId
          ? _value.mentorId
          : mentorId // ignore: cast_nullable_to_non_nullable
              as int,
      menteeId: null == menteeId
          ? _value.menteeId
          : menteeId // ignore: cast_nullable_to_non_nullable
              as int,
      applicationMemo: null == applicationMemo
          ? _value.applicationMemo
          : applicationMemo // ignore: cast_nullable_to_non_nullable
              as String,
      applicationDate: null == applicationDate
          ? _value.applicationDate
          : applicationDate // ignore: cast_nullable_to_non_nullable
              as String,
      applicationStartTime: null == applicationStartTime
          ? _value.applicationStartTime
          : applicationStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      applicationEndTime: null == applicationEndTime
          ? _value.applicationEndTime
          : applicationEndTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CogoApplicationResponseImplCopyWith<$Res>
    implements $CogoApplicationResponseCopyWith<$Res> {
  factory _$$CogoApplicationResponseImplCopyWith(
          _$CogoApplicationResponseImpl value,
          $Res Function(_$CogoApplicationResponseImpl) then) =
      __$$CogoApplicationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'applicationId') int applicationId,
      @JsonKey(name: 'mentorId') int mentorId,
      @JsonKey(name: 'menteeId') int menteeId,
      @JsonKey(name: 'applicationMemo') String applicationMemo,
      @JsonKey(name: 'applicationDate') String applicationDate,
      @JsonKey(name: 'applicationStartTime') String applicationStartTime,
      @JsonKey(name: 'applicationEndTime') String applicationEndTime});
}

/// @nodoc
class __$$CogoApplicationResponseImplCopyWithImpl<$Res>
    extends _$CogoApplicationResponseCopyWithImpl<$Res,
        _$CogoApplicationResponseImpl>
    implements _$$CogoApplicationResponseImplCopyWith<$Res> {
  __$$CogoApplicationResponseImplCopyWithImpl(
      _$CogoApplicationResponseImpl _value,
      $Res Function(_$CogoApplicationResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
    Object? mentorId = null,
    Object? menteeId = null,
    Object? applicationMemo = null,
    Object? applicationDate = null,
    Object? applicationStartTime = null,
    Object? applicationEndTime = null,
  }) {
    return _then(_$CogoApplicationResponseImpl(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
      mentorId: null == mentorId
          ? _value.mentorId
          : mentorId // ignore: cast_nullable_to_non_nullable
              as int,
      menteeId: null == menteeId
          ? _value.menteeId
          : menteeId // ignore: cast_nullable_to_non_nullable
              as int,
      applicationMemo: null == applicationMemo
          ? _value.applicationMemo
          : applicationMemo // ignore: cast_nullable_to_non_nullable
              as String,
      applicationDate: null == applicationDate
          ? _value.applicationDate
          : applicationDate // ignore: cast_nullable_to_non_nullable
              as String,
      applicationStartTime: null == applicationStartTime
          ? _value.applicationStartTime
          : applicationStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      applicationEndTime: null == applicationEndTime
          ? _value.applicationEndTime
          : applicationEndTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CogoApplicationResponseImpl implements _CogoApplicationResponse {
  const _$CogoApplicationResponseImpl(
      {@JsonKey(name: 'applicationId') required this.applicationId,
      @JsonKey(name: 'mentorId') required this.mentorId,
      @JsonKey(name: 'menteeId') required this.menteeId,
      @JsonKey(name: 'applicationMemo') required this.applicationMemo,
      @JsonKey(name: 'applicationDate') required this.applicationDate,
      @JsonKey(name: 'applicationStartTime') required this.applicationStartTime,
      @JsonKey(name: 'applicationEndTime') required this.applicationEndTime});

  factory _$CogoApplicationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CogoApplicationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'applicationId')
  final int applicationId;
  @override
  @JsonKey(name: 'mentorId')
  final int mentorId;
  @override
  @JsonKey(name: 'menteeId')
  final int menteeId;
  @override
  @JsonKey(name: 'applicationMemo')
  final String applicationMemo;
  @override
  @JsonKey(name: 'applicationDate')
  final String applicationDate;
  @override
  @JsonKey(name: 'applicationStartTime')
  final String applicationStartTime;
  @override
  @JsonKey(name: 'applicationEndTime')
  final String applicationEndTime;

  @override
  String toString() {
    return 'CogoApplicationResponse(applicationId: $applicationId, mentorId: $mentorId, menteeId: $menteeId, applicationMemo: $applicationMemo, applicationDate: $applicationDate, applicationStartTime: $applicationStartTime, applicationEndTime: $applicationEndTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CogoApplicationResponseImpl &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.mentorId, mentorId) ||
                other.mentorId == mentorId) &&
            (identical(other.menteeId, menteeId) ||
                other.menteeId == menteeId) &&
            (identical(other.applicationMemo, applicationMemo) ||
                other.applicationMemo == applicationMemo) &&
            (identical(other.applicationDate, applicationDate) ||
                other.applicationDate == applicationDate) &&
            (identical(other.applicationStartTime, applicationStartTime) ||
                other.applicationStartTime == applicationStartTime) &&
            (identical(other.applicationEndTime, applicationEndTime) ||
                other.applicationEndTime == applicationEndTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      applicationId,
      mentorId,
      menteeId,
      applicationMemo,
      applicationDate,
      applicationStartTime,
      applicationEndTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CogoApplicationResponseImplCopyWith<_$CogoApplicationResponseImpl>
      get copyWith => __$$CogoApplicationResponseImplCopyWithImpl<
          _$CogoApplicationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CogoApplicationResponseImplToJson(
      this,
    );
  }
}

abstract class _CogoApplicationResponse implements CogoApplicationResponse {
  const factory _CogoApplicationResponse(
      {@JsonKey(name: 'applicationId') required final int applicationId,
      @JsonKey(name: 'mentorId') required final int mentorId,
      @JsonKey(name: 'menteeId') required final int menteeId,
      @JsonKey(name: 'applicationMemo') required final String applicationMemo,
      @JsonKey(name: 'applicationDate') required final String applicationDate,
      @JsonKey(name: 'applicationStartTime')
      required final String applicationStartTime,
      @JsonKey(name: 'applicationEndTime')
      required final String
          applicationEndTime}) = _$CogoApplicationResponseImpl;

  factory _CogoApplicationResponse.fromJson(Map<String, dynamic> json) =
      _$CogoApplicationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'applicationId')
  int get applicationId;
  @override
  @JsonKey(name: 'mentorId')
  int get mentorId;
  @override
  @JsonKey(name: 'menteeId')
  int get menteeId;
  @override
  @JsonKey(name: 'applicationMemo')
  String get applicationMemo;
  @override
  @JsonKey(name: 'applicationDate')
  String get applicationDate;
  @override
  @JsonKey(name: 'applicationStartTime')
  String get applicationStartTime;
  @override
  @JsonKey(name: 'applicationEndTime')
  String get applicationEndTime;
  @override
  @JsonKey(ignore: true)
  _$$CogoApplicationResponseImplCopyWith<_$CogoApplicationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
