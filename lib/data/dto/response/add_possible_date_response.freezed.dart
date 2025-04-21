// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_possible_date_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddPossibleDateResponse _$AddPossibleDateResponseFromJson(
    Map<String, dynamic> json) {
  return _AddPossibleDateResponse.fromJson(json);
}

/// @nodoc
mixin _$AddPossibleDateResponse {
  @JsonKey(name: 'possibleDateId')
  int get possibleDateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'startTime')
  String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'active')
  bool get active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddPossibleDateResponseCopyWith<AddPossibleDateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPossibleDateResponseCopyWith<$Res> {
  factory $AddPossibleDateResponseCopyWith(AddPossibleDateResponse value,
          $Res Function(AddPossibleDateResponse) then) =
      _$AddPossibleDateResponseCopyWithImpl<$Res, AddPossibleDateResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'possibleDateId') int possibleDateId,
      @JsonKey(name: 'date') String date,
      @JsonKey(name: 'startTime') String? startTime,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'active') bool active});
}

/// @nodoc
class _$AddPossibleDateResponseCopyWithImpl<$Res,
        $Val extends AddPossibleDateResponse>
    implements $AddPossibleDateResponseCopyWith<$Res> {
  _$AddPossibleDateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? possibleDateId = null,
    Object? date = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
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
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddPossibleDateResponseImplCopyWith<$Res>
    implements $AddPossibleDateResponseCopyWith<$Res> {
  factory _$$AddPossibleDateResponseImplCopyWith(
          _$AddPossibleDateResponseImpl value,
          $Res Function(_$AddPossibleDateResponseImpl) then) =
      __$$AddPossibleDateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'possibleDateId') int possibleDateId,
      @JsonKey(name: 'date') String date,
      @JsonKey(name: 'startTime') String? startTime,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'active') bool active});
}

/// @nodoc
class __$$AddPossibleDateResponseImplCopyWithImpl<$Res>
    extends _$AddPossibleDateResponseCopyWithImpl<$Res,
        _$AddPossibleDateResponseImpl>
    implements _$$AddPossibleDateResponseImplCopyWith<$Res> {
  __$$AddPossibleDateResponseImplCopyWithImpl(
      _$AddPossibleDateResponseImpl _value,
      $Res Function(_$AddPossibleDateResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? possibleDateId = null,
    Object? date = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? active = null,
  }) {
    return _then(_$AddPossibleDateResponseImpl(
      possibleDateId: null == possibleDateId
          ? _value.possibleDateId
          : possibleDateId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddPossibleDateResponseImpl implements _AddPossibleDateResponse {
  const _$AddPossibleDateResponseImpl(
      {@JsonKey(name: 'possibleDateId') required this.possibleDateId,
      @JsonKey(name: 'date') required this.date,
      @JsonKey(name: 'startTime') required this.startTime,
      @JsonKey(name: 'endTime') required this.endTime,
      @JsonKey(name: 'active') required this.active});

  factory _$AddPossibleDateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddPossibleDateResponseImplFromJson(json);

  @override
  @JsonKey(name: 'possibleDateId')
  final int possibleDateId;
  @override
  @JsonKey(name: 'date')
  final String date;
  @override
  @JsonKey(name: 'startTime')
  final String? startTime;
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;
  @override
  @JsonKey(name: 'active')
  final bool active;

  @override
  String toString() {
    return 'AddPossibleDateResponse(possibleDateId: $possibleDateId, date: $date, startTime: $startTime, endTime: $endTime, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPossibleDateResponseImpl &&
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
  _$$AddPossibleDateResponseImplCopyWith<_$AddPossibleDateResponseImpl>
      get copyWith => __$$AddPossibleDateResponseImplCopyWithImpl<
          _$AddPossibleDateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddPossibleDateResponseImplToJson(
      this,
    );
  }
}

abstract class _AddPossibleDateResponse implements AddPossibleDateResponse {
  const factory _AddPossibleDateResponse(
          {@JsonKey(name: 'possibleDateId') required final int possibleDateId,
          @JsonKey(name: 'date') required final String date,
          @JsonKey(name: 'startTime') required final String? startTime,
          @JsonKey(name: 'endTime') required final String? endTime,
          @JsonKey(name: 'active') required final bool active}) =
      _$AddPossibleDateResponseImpl;

  factory _AddPossibleDateResponse.fromJson(Map<String, dynamic> json) =
      _$AddPossibleDateResponseImpl.fromJson;

  @override
  @JsonKey(name: 'possibleDateId')
  int get possibleDateId;
  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(name: 'startTime')
  String? get startTime;
  @override
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override
  @JsonKey(name: 'active')
  bool get active;
  @override
  @JsonKey(ignore: true)
  _$$AddPossibleDateResponseImplCopyWith<_$AddPossibleDateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
