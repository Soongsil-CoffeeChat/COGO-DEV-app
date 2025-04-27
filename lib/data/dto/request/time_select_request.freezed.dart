// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_select_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeSlotDto _$TimeSlotDtoFromJson(Map<String, dynamic> json) {
  return _TimeSlotDto.fromJson(json);
}

/// @nodoc
mixin _$TimeSlotDto {
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'startTime')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'endTime')
  String get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeSlotDtoCopyWith<TimeSlotDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotDtoCopyWith<$Res> {
  factory $TimeSlotDtoCopyWith(
          TimeSlotDto value, $Res Function(TimeSlotDto) then) =
      _$TimeSlotDtoCopyWithImpl<$Res, TimeSlotDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'date') String date,
      @JsonKey(name: 'startTime') String startTime,
      @JsonKey(name: 'endTime') String endTime});
}

/// @nodoc
class _$TimeSlotDtoCopyWithImpl<$Res, $Val extends TimeSlotDto>
    implements $TimeSlotDtoCopyWith<$Res> {
  _$TimeSlotDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeSlotDtoImplCopyWith<$Res>
    implements $TimeSlotDtoCopyWith<$Res> {
  factory _$$TimeSlotDtoImplCopyWith(
          _$TimeSlotDtoImpl value, $Res Function(_$TimeSlotDtoImpl) then) =
      __$$TimeSlotDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'date') String date,
      @JsonKey(name: 'startTime') String startTime,
      @JsonKey(name: 'endTime') String endTime});
}

/// @nodoc
class __$$TimeSlotDtoImplCopyWithImpl<$Res>
    extends _$TimeSlotDtoCopyWithImpl<$Res, _$TimeSlotDtoImpl>
    implements _$$TimeSlotDtoImplCopyWith<$Res> {
  __$$TimeSlotDtoImplCopyWithImpl(
      _$TimeSlotDtoImpl _value, $Res Function(_$TimeSlotDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$TimeSlotDtoImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeSlotDtoImpl implements _TimeSlotDto {
  const _$TimeSlotDtoImpl(
      {@JsonKey(name: 'date') required this.date,
      @JsonKey(name: 'startTime') required this.startTime,
      @JsonKey(name: 'endTime') required this.endTime});

  factory _$TimeSlotDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeSlotDtoImplFromJson(json);

  @override
  @JsonKey(name: 'date')
  final String date;
  @override
  @JsonKey(name: 'startTime')
  final String startTime;
  @override
  @JsonKey(name: 'endTime')
  final String endTime;

  @override
  String toString() {
    return 'TimeSlotDto(date: $date, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeSlotDtoImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeSlotDtoImplCopyWith<_$TimeSlotDtoImpl> get copyWith =>
      __$$TimeSlotDtoImplCopyWithImpl<_$TimeSlotDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeSlotDtoImplToJson(
      this,
    );
  }
}

abstract class _TimeSlotDto implements TimeSlotDto {
  const factory _TimeSlotDto(
          {@JsonKey(name: 'date') required final String date,
          @JsonKey(name: 'startTime') required final String startTime,
          @JsonKey(name: 'endTime') required final String endTime}) =
      _$TimeSlotDtoImpl;

  factory _TimeSlotDto.fromJson(Map<String, dynamic> json) =
      _$TimeSlotDtoImpl.fromJson;

  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(name: 'startTime')
  String get startTime;
  @override
  @JsonKey(name: 'endTime')
  String get endTime;
  @override
  @JsonKey(ignore: true)
  _$$TimeSlotDtoImplCopyWith<_$TimeSlotDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
