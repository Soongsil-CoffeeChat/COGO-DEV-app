// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmailVerificationResponse _$EmailVerificationResponseFromJson(
    Map<String, dynamic> json) {
  return _EmailVerificationResponse.fromJson(json);
}

/// @nodoc
mixin _$EmailVerificationResponse {
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailVerificationResponseCopyWith<EmailVerificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationResponseCopyWith<$Res> {
  factory $EmailVerificationResponseCopyWith(EmailVerificationResponse value,
          $Res Function(EmailVerificationResponse) then) =
      _$EmailVerificationResponseCopyWithImpl<$Res, EmailVerificationResponse>;
  @useResult
  $Res call({@JsonKey(name: 'code') String code});
}

/// @nodoc
class _$EmailVerificationResponseCopyWithImpl<$Res,
        $Val extends EmailVerificationResponse>
    implements $EmailVerificationResponseCopyWith<$Res> {
  _$EmailVerificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailVerificationResponseImplCopyWith<$Res>
    implements $EmailVerificationResponseCopyWith<$Res> {
  factory _$$EmailVerificationResponseImplCopyWith(
          _$EmailVerificationResponseImpl value,
          $Res Function(_$EmailVerificationResponseImpl) then) =
      __$$EmailVerificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'code') String code});
}

/// @nodoc
class __$$EmailVerificationResponseImplCopyWithImpl<$Res>
    extends _$EmailVerificationResponseCopyWithImpl<$Res,
        _$EmailVerificationResponseImpl>
    implements _$$EmailVerificationResponseImplCopyWith<$Res> {
  __$$EmailVerificationResponseImplCopyWithImpl(
      _$EmailVerificationResponseImpl _value,
      $Res Function(_$EmailVerificationResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$EmailVerificationResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailVerificationResponseImpl implements _EmailVerificationResponse {
  const _$EmailVerificationResponseImpl(
      {@JsonKey(name: 'code') required this.code});

  factory _$EmailVerificationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailVerificationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'code')
  final String code;

  @override
  String toString() {
    return 'EmailVerificationResponse(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationResponseImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationResponseImplCopyWith<_$EmailVerificationResponseImpl>
      get copyWith => __$$EmailVerificationResponseImplCopyWithImpl<
          _$EmailVerificationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailVerificationResponseImplToJson(
      this,
    );
  }
}

abstract class _EmailVerificationResponse implements EmailVerificationResponse {
  const factory _EmailVerificationResponse(
          {@JsonKey(name: 'code') required final String code}) =
      _$EmailVerificationResponseImpl;

  factory _EmailVerificationResponse.fromJson(Map<String, dynamic> json) =
      _$EmailVerificationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'code')
  String get code;
  @override
  @JsonKey(ignore: true)
  _$$EmailVerificationResponseImplCopyWith<_$EmailVerificationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
