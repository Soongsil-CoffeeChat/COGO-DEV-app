// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'linked_cogo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LinkedCogoResponse _$LinkedCogoResponseFromJson(Map<String, dynamic> json) {
  return _LinkedCogoResponse.fromJson(json);
}

/// @nodoc
mixin _$LinkedCogoResponse {
  @JsonKey(name: 'applicationId')
  int get applicationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'startTime')
  String get startTime => throw _privateConstructorUsedError;

  /// Serializes this LinkedCogoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinkedCogoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkedCogoResponseCopyWith<LinkedCogoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkedCogoResponseCopyWith<$Res> {
  factory $LinkedCogoResponseCopyWith(
          LinkedCogoResponse value, $Res Function(LinkedCogoResponse) then) =
      _$LinkedCogoResponseCopyWithImpl<$Res, LinkedCogoResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'applicationId') int applicationId,
      @JsonKey(name: 'date') String date,
      @JsonKey(name: 'startTime') String startTime});
}

/// @nodoc
class _$LinkedCogoResponseCopyWithImpl<$Res, $Val extends LinkedCogoResponse>
    implements $LinkedCogoResponseCopyWith<$Res> {
  _$LinkedCogoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkedCogoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
    Object? date = null,
    Object? startTime = null,
  }) {
    return _then(_value.copyWith(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkedCogoResponseImplCopyWith<$Res>
    implements $LinkedCogoResponseCopyWith<$Res> {
  factory _$$LinkedCogoResponseImplCopyWith(_$LinkedCogoResponseImpl value,
          $Res Function(_$LinkedCogoResponseImpl) then) =
      __$$LinkedCogoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'applicationId') int applicationId,
      @JsonKey(name: 'date') String date,
      @JsonKey(name: 'startTime') String startTime});
}

/// @nodoc
class __$$LinkedCogoResponseImplCopyWithImpl<$Res>
    extends _$LinkedCogoResponseCopyWithImpl<$Res, _$LinkedCogoResponseImpl>
    implements _$$LinkedCogoResponseImplCopyWith<$Res> {
  __$$LinkedCogoResponseImplCopyWithImpl(_$LinkedCogoResponseImpl _value,
      $Res Function(_$LinkedCogoResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkedCogoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
    Object? date = null,
    Object? startTime = null,
  }) {
    return _then(_$LinkedCogoResponseImpl(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkedCogoResponseImpl implements _LinkedCogoResponse {
  const _$LinkedCogoResponseImpl(
      {@JsonKey(name: 'applicationId') required this.applicationId,
      @JsonKey(name: 'date') required this.date,
      @JsonKey(name: 'startTime') required this.startTime});

  factory _$LinkedCogoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkedCogoResponseImplFromJson(json);

  @override
  @JsonKey(name: 'applicationId')
  final int applicationId;
  @override
  @JsonKey(name: 'date')
  final String date;
  @override
  @JsonKey(name: 'startTime')
  final String startTime;

  @override
  String toString() {
    return 'LinkedCogoResponse(applicationId: $applicationId, date: $date, startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkedCogoResponseImpl &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, applicationId, date, startTime);

  /// Create a copy of LinkedCogoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkedCogoResponseImplCopyWith<_$LinkedCogoResponseImpl> get copyWith =>
      __$$LinkedCogoResponseImplCopyWithImpl<_$LinkedCogoResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkedCogoResponseImplToJson(
      this,
    );
  }
}

abstract class _LinkedCogoResponse implements LinkedCogoResponse {
  const factory _LinkedCogoResponse(
          {@JsonKey(name: 'applicationId') required final int applicationId,
          @JsonKey(name: 'date') required final String date,
          @JsonKey(name: 'startTime') required final String startTime}) =
      _$LinkedCogoResponseImpl;

  factory _LinkedCogoResponse.fromJson(Map<String, dynamic> json) =
      _$LinkedCogoResponseImpl.fromJson;

  @override
  @JsonKey(name: 'applicationId')
  int get applicationId;
  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(name: 'startTime')
  String get startTime;

  /// Create a copy of LinkedCogoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkedCogoResponseImplCopyWith<_$LinkedCogoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
