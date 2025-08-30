// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_verification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SmsVerificationResponse _$SmsVerificationResponseFromJson(
    Map<String, dynamic> json) {
  return _SmsVerificationResponsee.fromJson(json);
}

/// @nodoc
mixin _$SmsVerificationResponse {
  @JsonKey(name: 'verificationCode')
  String get verificationCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmsVerificationResponseCopyWith<SmsVerificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsVerificationResponseCopyWith<$Res> {
  factory $SmsVerificationResponseCopyWith(SmsVerificationResponse value,
          $Res Function(SmsVerificationResponse) then) =
      _$SmsVerificationResponseCopyWithImpl<$Res, SmsVerificationResponse>;
  @useResult
  $Res call({@JsonKey(name: 'verificationCode') String verificationCode});
}

/// @nodoc
class _$SmsVerificationResponseCopyWithImpl<$Res,
        $Val extends SmsVerificationResponse>
    implements $SmsVerificationResponseCopyWith<$Res> {
  _$SmsVerificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationCode = null,
  }) {
    return _then(_value.copyWith(
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsVerificationResponseeImplCopyWith<$Res>
    implements $SmsVerificationResponseCopyWith<$Res> {
  factory _$$SmsVerificationResponseeImplCopyWith(
          _$SmsVerificationResponseeImpl value,
          $Res Function(_$SmsVerificationResponseeImpl) then) =
      __$$SmsVerificationResponseeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'verificationCode') String verificationCode});
}

/// @nodoc
class __$$SmsVerificationResponseeImplCopyWithImpl<$Res>
    extends _$SmsVerificationResponseCopyWithImpl<$Res,
        _$SmsVerificationResponseeImpl>
    implements _$$SmsVerificationResponseeImplCopyWith<$Res> {
  __$$SmsVerificationResponseeImplCopyWithImpl(
      _$SmsVerificationResponseeImpl _value,
      $Res Function(_$SmsVerificationResponseeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationCode = null,
  }) {
    return _then(_$SmsVerificationResponseeImpl(
      verificationCode: null == verificationCode
          ? _value.verificationCode
          : verificationCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsVerificationResponseeImpl implements _SmsVerificationResponsee {
  const _$SmsVerificationResponseeImpl(
      {@JsonKey(name: 'verificationCode') required this.verificationCode});

  factory _$SmsVerificationResponseeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsVerificationResponseeImplFromJson(json);

  @override
  @JsonKey(name: 'verificationCode')
  final String verificationCode;

  @override
  String toString() {
    return 'SmsVerificationResponse(verificationCode: $verificationCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsVerificationResponseeImpl &&
            (identical(other.verificationCode, verificationCode) ||
                other.verificationCode == verificationCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, verificationCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsVerificationResponseeImplCopyWith<_$SmsVerificationResponseeImpl>
      get copyWith => __$$SmsVerificationResponseeImplCopyWithImpl<
          _$SmsVerificationResponseeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsVerificationResponseeImplToJson(
      this,
    );
  }
}

abstract class _SmsVerificationResponsee implements SmsVerificationResponse {
  const factory _SmsVerificationResponsee(
      {@JsonKey(name: 'verificationCode')
      required final String verificationCode}) = _$SmsVerificationResponseeImpl;

  factory _SmsVerificationResponsee.fromJson(Map<String, dynamic> json) =
      _$SmsVerificationResponseeImpl.fromJson;

  @override
  @JsonKey(name: 'verificationCode')
  String get verificationCode;
  @override
  @JsonKey(ignore: true)
  _$$SmsVerificationResponseeImplCopyWith<_$SmsVerificationResponseeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
