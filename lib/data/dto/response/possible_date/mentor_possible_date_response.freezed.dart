// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_possible_date_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MentorPossibleDateResponse _$MentorPossibleDateResponseFromJson(
    Map<String, dynamic> json) {
  return _MentorPossibleDateResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorPossibleDateResponse {
  int get possibleDateId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MentorPossibleDateResponseCopyWith<MentorPossibleDateResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorPossibleDateResponseCopyWith<$Res> {
  factory $MentorPossibleDateResponseCopyWith(MentorPossibleDateResponse value,
          $Res Function(MentorPossibleDateResponse) then) =
      _$MentorPossibleDateResponseCopyWithImpl<$Res,
          MentorPossibleDateResponse>;
  @useResult
  $Res call(
      {int possibleDateId,
      String date,
      String startTime,
      String endTime,
      bool active});
}

/// @nodoc
class _$MentorPossibleDateResponseCopyWithImpl<$Res,
        $Val extends MentorPossibleDateResponse>
    implements $MentorPossibleDateResponseCopyWith<$Res> {
  _$MentorPossibleDateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? possibleDateId = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      possibleDateId: null == possibleDateId
          ? _value.possibleDateId
          : possibleDateId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MentorPossibleDateResponseImplCopyWith<$Res>
    implements $MentorPossibleDateResponseCopyWith<$Res> {
  factory _$$MentorPossibleDateResponseImplCopyWith(
          _$MentorPossibleDateResponseImpl value,
          $Res Function(_$MentorPossibleDateResponseImpl) then) =
      __$$MentorPossibleDateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int possibleDateId,
      String date,
      String startTime,
      String endTime,
      bool active});
}

/// @nodoc
class __$$MentorPossibleDateResponseImplCopyWithImpl<$Res>
    extends _$MentorPossibleDateResponseCopyWithImpl<$Res,
        _$MentorPossibleDateResponseImpl>
    implements _$$MentorPossibleDateResponseImplCopyWith<$Res> {
  __$$MentorPossibleDateResponseImplCopyWithImpl(
      _$MentorPossibleDateResponseImpl _value,
      $Res Function(_$MentorPossibleDateResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? possibleDateId = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? active = null,
  }) {
    return _then(_$MentorPossibleDateResponseImpl(
      possibleDateId: null == possibleDateId
          ? _value.possibleDateId
          : possibleDateId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MentorPossibleDateResponseImpl implements _MentorPossibleDateResponse {
  const _$MentorPossibleDateResponseImpl(
      {required this.possibleDateId,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.active});

  factory _$MentorPossibleDateResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MentorPossibleDateResponseImplFromJson(json);

  @override
  final int possibleDateId;
  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final bool active;

  @override
  String toString() {
    return 'MentorPossibleDateResponse(possibleDateId: $possibleDateId, date: $date, startTime: $startTime, endTime: $endTime, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorPossibleDateResponseImpl &&
            (identical(other.possibleDateId, possibleDateId) ||
                other.possibleDateId == possibleDateId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, possibleDateId, date, startTime, endTime, active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorPossibleDateResponseImplCopyWith<_$MentorPossibleDateResponseImpl>
      get copyWith => __$$MentorPossibleDateResponseImplCopyWithImpl<
          _$MentorPossibleDateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorPossibleDateResponseImplToJson(
      this,
    );
  }
}

abstract class _MentorPossibleDateResponse
    implements MentorPossibleDateResponse {
  const factory _MentorPossibleDateResponse(
      {required final int possibleDateId,
      required final String date,
      required final String startTime,
      required final String endTime,
      required final bool active}) = _$MentorPossibleDateResponseImpl;

  factory _MentorPossibleDateResponse.fromJson(Map<String, dynamic> json) =
      _$MentorPossibleDateResponseImpl.fromJson;

  @override
  int get possibleDateId;
  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  bool get active;
  @override
  @JsonKey(ignore: true)
  _$$MentorPossibleDateResponseImplCopyWith<_$MentorPossibleDateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
