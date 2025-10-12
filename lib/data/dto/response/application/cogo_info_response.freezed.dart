// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cogo_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CogoInfoResponse _$CogoInfoResponseFromJson(Map<String, dynamic> json) {
  return _CogoInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$CogoInfoResponse {
  @JsonKey(name: 'applicationId')
  int get applicationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'otherPartyName')
  String get otherPartyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicationStatus')
  String? get applicationStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'applicationDate')
  String get applicationDate => throw _privateConstructorUsedError;

  /// Serializes this CogoInfoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CogoInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CogoInfoResponseCopyWith<CogoInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CogoInfoResponseCopyWith<$Res> {
  factory $CogoInfoResponseCopyWith(
          CogoInfoResponse value, $Res Function(CogoInfoResponse) then) =
      _$CogoInfoResponseCopyWithImpl<$Res, CogoInfoResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'applicationId') int applicationId,
      @JsonKey(name: 'otherPartyName') String otherPartyName,
      @JsonKey(name: 'applicationStatus') String? applicationStatus,
      @JsonKey(name: 'applicationDate') String applicationDate});
}

/// @nodoc
class _$CogoInfoResponseCopyWithImpl<$Res, $Val extends CogoInfoResponse>
    implements $CogoInfoResponseCopyWith<$Res> {
  _$CogoInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CogoInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
    Object? otherPartyName = null,
    Object? applicationStatus = freezed,
    Object? applicationDate = null,
  }) {
    return _then(_value.copyWith(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
      otherPartyName: null == otherPartyName
          ? _value.otherPartyName
          : otherPartyName // ignore: cast_nullable_to_non_nullable
              as String,
      applicationStatus: freezed == applicationStatus
          ? _value.applicationStatus
          : applicationStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationDate: null == applicationDate
          ? _value.applicationDate
          : applicationDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CogoInfoResponseImplCopyWith<$Res>
    implements $CogoInfoResponseCopyWith<$Res> {
  factory _$$CogoInfoResponseImplCopyWith(_$CogoInfoResponseImpl value,
          $Res Function(_$CogoInfoResponseImpl) then) =
      __$$CogoInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'applicationId') int applicationId,
      @JsonKey(name: 'otherPartyName') String otherPartyName,
      @JsonKey(name: 'applicationStatus') String? applicationStatus,
      @JsonKey(name: 'applicationDate') String applicationDate});
}

/// @nodoc
class __$$CogoInfoResponseImplCopyWithImpl<$Res>
    extends _$CogoInfoResponseCopyWithImpl<$Res, _$CogoInfoResponseImpl>
    implements _$$CogoInfoResponseImplCopyWith<$Res> {
  __$$CogoInfoResponseImplCopyWithImpl(_$CogoInfoResponseImpl _value,
      $Res Function(_$CogoInfoResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CogoInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationId = null,
    Object? otherPartyName = null,
    Object? applicationStatus = freezed,
    Object? applicationDate = null,
  }) {
    return _then(_$CogoInfoResponseImpl(
      applicationId: null == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as int,
      otherPartyName: null == otherPartyName
          ? _value.otherPartyName
          : otherPartyName // ignore: cast_nullable_to_non_nullable
              as String,
      applicationStatus: freezed == applicationStatus
          ? _value.applicationStatus
          : applicationStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationDate: null == applicationDate
          ? _value.applicationDate
          : applicationDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CogoInfoResponseImpl implements _CogoInfoResponse {
  const _$CogoInfoResponseImpl(
      {@JsonKey(name: 'applicationId') required this.applicationId,
      @JsonKey(name: 'otherPartyName') required this.otherPartyName,
      @JsonKey(name: 'applicationStatus') required this.applicationStatus,
      @JsonKey(name: 'applicationDate') required this.applicationDate});

  factory _$CogoInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CogoInfoResponseImplFromJson(json);

  @override
  @JsonKey(name: 'applicationId')
  final int applicationId;
  @override
  @JsonKey(name: 'otherPartyName')
  final String otherPartyName;
  @override
  @JsonKey(name: 'applicationStatus')
  final String? applicationStatus;
  @override
  @JsonKey(name: 'applicationDate')
  final String applicationDate;

  @override
  String toString() {
    return 'CogoInfoResponse(applicationId: $applicationId, otherPartyName: $otherPartyName, applicationStatus: $applicationStatus, applicationDate: $applicationDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CogoInfoResponseImpl &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId) &&
            (identical(other.otherPartyName, otherPartyName) ||
                other.otherPartyName == otherPartyName) &&
            (identical(other.applicationStatus, applicationStatus) ||
                other.applicationStatus == applicationStatus) &&
            (identical(other.applicationDate, applicationDate) ||
                other.applicationDate == applicationDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, applicationId, otherPartyName,
      applicationStatus, applicationDate);

  /// Create a copy of CogoInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CogoInfoResponseImplCopyWith<_$CogoInfoResponseImpl> get copyWith =>
      __$$CogoInfoResponseImplCopyWithImpl<_$CogoInfoResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CogoInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _CogoInfoResponse implements CogoInfoResponse {
  const factory _CogoInfoResponse(
      {@JsonKey(name: 'applicationId') required final int applicationId,
      @JsonKey(name: 'otherPartyName') required final String otherPartyName,
      @JsonKey(name: 'applicationStatus')
      required final String? applicationStatus,
      @JsonKey(name: 'applicationDate')
      required final String applicationDate}) = _$CogoInfoResponseImpl;

  factory _CogoInfoResponse.fromJson(Map<String, dynamic> json) =
      _$CogoInfoResponseImpl.fromJson;

  @override
  @JsonKey(name: 'applicationId')
  int get applicationId;
  @override
  @JsonKey(name: 'otherPartyName')
  String get otherPartyName;
  @override
  @JsonKey(name: 'applicationStatus')
  String? get applicationStatus;
  @override
  @JsonKey(name: 'applicationDate')
  String get applicationDate;

  /// Create a copy of CogoInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CogoInfoResponseImplCopyWith<_$CogoInfoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
