// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentee_signup_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MenteeSignupResponse _$MenteeSignupResponseFromJson(Map<String, dynamic> json) {
  return _MenteeSignupResponse.fromJson(json);
}

/// @nodoc
mixin _$MenteeSignupResponse {
  String get part => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenteeSignupResponseCopyWith<MenteeSignupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenteeSignupResponseCopyWith<$Res> {
  factory $MenteeSignupResponseCopyWith(MenteeSignupResponse value,
          $Res Function(MenteeSignupResponse) then) =
      _$MenteeSignupResponseCopyWithImpl<$Res, MenteeSignupResponse>;
  @useResult
  $Res call({String part});
}

/// @nodoc
class _$MenteeSignupResponseCopyWithImpl<$Res,
        $Val extends MenteeSignupResponse>
    implements $MenteeSignupResponseCopyWith<$Res> {
  _$MenteeSignupResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
  }) {
    return _then(_value.copyWith(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenteeSignupResponseImplCopyWith<$Res>
    implements $MenteeSignupResponseCopyWith<$Res> {
  factory _$$MenteeSignupResponseImplCopyWith(_$MenteeSignupResponseImpl value,
          $Res Function(_$MenteeSignupResponseImpl) then) =
      __$$MenteeSignupResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String part});
}

/// @nodoc
class __$$MenteeSignupResponseImplCopyWithImpl<$Res>
    extends _$MenteeSignupResponseCopyWithImpl<$Res, _$MenteeSignupResponseImpl>
    implements _$$MenteeSignupResponseImplCopyWith<$Res> {
  __$$MenteeSignupResponseImplCopyWithImpl(_$MenteeSignupResponseImpl _value,
      $Res Function(_$MenteeSignupResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
  }) {
    return _then(_$MenteeSignupResponseImpl(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenteeSignupResponseImpl implements _MenteeSignupResponse {
  const _$MenteeSignupResponseImpl({required this.part});

  factory _$MenteeSignupResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenteeSignupResponseImplFromJson(json);

  @override
  final String part;

  @override
  String toString() {
    return 'MenteeSignupResponse(part: $part)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenteeSignupResponseImpl &&
            (identical(other.part, part) || other.part == part));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, part);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MenteeSignupResponseImplCopyWith<_$MenteeSignupResponseImpl>
      get copyWith =>
          __$$MenteeSignupResponseImplCopyWithImpl<_$MenteeSignupResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenteeSignupResponseImplToJson(
      this,
    );
  }
}

abstract class _MenteeSignupResponse implements MenteeSignupResponse {
  const factory _MenteeSignupResponse({required final String part}) =
      _$MenteeSignupResponseImpl;

  factory _MenteeSignupResponse.fromJson(Map<String, dynamic> json) =
      _$MenteeSignupResponseImpl.fromJson;

  @override
  String get part;
  @override
  @JsonKey(ignore: true)
  _$$MenteeSignupResponseImplCopyWith<_$MenteeSignupResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
