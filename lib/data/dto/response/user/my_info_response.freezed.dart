// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyInfoResponse _$MyInfoResponseFromJson(Map<String, dynamic> json) {
  return _MyInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$MyInfoResponse {
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNum => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get part => throw _privateConstructorUsedError;
  String? get club => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyInfoResponseCopyWith<MyInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyInfoResponseCopyWith<$Res> {
  factory $MyInfoResponseCopyWith(
          MyInfoResponse value, $Res Function(MyInfoResponse) then) =
      _$MyInfoResponseCopyWithImpl<$Res, MyInfoResponse>;
  @useResult
  $Res call(
      {String name,
      String? email,
      String? phoneNum,
      String? role,
      String? part,
      String? club,
      String? picture});
}

/// @nodoc
class _$MyInfoResponseCopyWithImpl<$Res, $Val extends MyInfoResponse>
    implements $MyInfoResponseCopyWith<$Res> {
  _$MyInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = freezed,
    Object? phoneNum = freezed,
    Object? role = freezed,
    Object? part = freezed,
    Object? club = freezed,
    Object? picture = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNum: freezed == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      part: freezed == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
      club: freezed == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyInfoResponseImplCopyWith<$Res>
    implements $MyInfoResponseCopyWith<$Res> {
  factory _$$MyInfoResponseImplCopyWith(_$MyInfoResponseImpl value,
          $Res Function(_$MyInfoResponseImpl) then) =
      __$$MyInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? email,
      String? phoneNum,
      String? role,
      String? part,
      String? club,
      String? picture});
}

/// @nodoc
class __$$MyInfoResponseImplCopyWithImpl<$Res>
    extends _$MyInfoResponseCopyWithImpl<$Res, _$MyInfoResponseImpl>
    implements _$$MyInfoResponseImplCopyWith<$Res> {
  __$$MyInfoResponseImplCopyWithImpl(
      _$MyInfoResponseImpl _value, $Res Function(_$MyInfoResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = freezed,
    Object? phoneNum = freezed,
    Object? role = freezed,
    Object? part = freezed,
    Object? club = freezed,
    Object? picture = freezed,
  }) {
    return _then(_$MyInfoResponseImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNum: freezed == phoneNum
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      part: freezed == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
      club: freezed == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyInfoResponseImpl implements _MyInfoResponse {
  const _$MyInfoResponseImpl(
      {required this.name,
      this.email,
      this.phoneNum,
      this.role,
      this.part,
      this.club,
      this.picture});

  factory _$MyInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyInfoResponseImplFromJson(json);

  @override
  final String name;
  @override
  final String? email;
  @override
  final String? phoneNum;
  @override
  final String? role;
  @override
  final String? part;
  @override
  final String? club;
  @override
  final String? picture;

  @override
  String toString() {
    return 'MyInfoResponse(name: $name, email: $email, phoneNum: $phoneNum, role: $role, part: $part, club: $club, picture: $picture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyInfoResponseImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNum, phoneNum) ||
                other.phoneNum == phoneNum) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.part, part) || other.part == part) &&
            (identical(other.club, club) || other.club == club) &&
            (identical(other.picture, picture) || other.picture == picture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, email, phoneNum, role, part, club, picture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyInfoResponseImplCopyWith<_$MyInfoResponseImpl> get copyWith =>
      __$$MyInfoResponseImplCopyWithImpl<_$MyInfoResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _MyInfoResponse implements MyInfoResponse {
  const factory _MyInfoResponse(
      {required final String name,
      final String? email,
      final String? phoneNum,
      final String? role,
      final String? part,
      final String? club,
      final String? picture}) = _$MyInfoResponseImpl;

  factory _MyInfoResponse.fromJson(Map<String, dynamic> json) =
      _$MyInfoResponseImpl.fromJson;

  @override
  String get name;
  @override
  String? get email;
  @override
  String? get phoneNum;
  @override
  String? get role;
  @override
  String? get part;
  @override
  String? get club;
  @override
  String? get picture;
  @override
  @JsonKey(ignore: true)
  _$$MyInfoResponseImplCopyWith<_$MyInfoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
