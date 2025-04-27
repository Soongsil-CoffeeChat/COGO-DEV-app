// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_introduction_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MentorIntroductionResponse _$MentorIntroductionResponseFromJson(
    Map<String, dynamic> json) {
  return _MentorIntroductionResponse.fromJson(json);
}

/// @nodoc
mixin _$MentorIntroductionResponse {
  @JsonKey(name: 'introduction_title')
  String? get introductionTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'introduction_description')
  String? get introductionDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'introduction_answer1')
  String? get introductionAnswer1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'introduction_answer2')
  String? get introductionAnswer2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MentorIntroductionResponseCopyWith<MentorIntroductionResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorIntroductionResponseCopyWith<$Res> {
  factory $MentorIntroductionResponseCopyWith(MentorIntroductionResponse value,
          $Res Function(MentorIntroductionResponse) then) =
      _$MentorIntroductionResponseCopyWithImpl<$Res,
          MentorIntroductionResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'introduction_title') String? introductionTitle,
      @JsonKey(name: 'introduction_description')
      String? introductionDescription,
      @JsonKey(name: 'introduction_answer1') String? introductionAnswer1,
      @JsonKey(name: 'introduction_answer2') String? introductionAnswer2});
}

/// @nodoc
class _$MentorIntroductionResponseCopyWithImpl<$Res,
        $Val extends MentorIntroductionResponse>
    implements $MentorIntroductionResponseCopyWith<$Res> {
  _$MentorIntroductionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? introductionTitle = freezed,
    Object? introductionDescription = freezed,
    Object? introductionAnswer1 = freezed,
    Object? introductionAnswer2 = freezed,
  }) {
    return _then(_value.copyWith(
      introductionTitle: freezed == introductionTitle
          ? _value.introductionTitle
          : introductionTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      introductionDescription: freezed == introductionDescription
          ? _value.introductionDescription
          : introductionDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      introductionAnswer1: freezed == introductionAnswer1
          ? _value.introductionAnswer1
          : introductionAnswer1 // ignore: cast_nullable_to_non_nullable
              as String?,
      introductionAnswer2: freezed == introductionAnswer2
          ? _value.introductionAnswer2
          : introductionAnswer2 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MentorIntroductionResponseImplCopyWith<$Res>
    implements $MentorIntroductionResponseCopyWith<$Res> {
  factory _$$MentorIntroductionResponseImplCopyWith(
          _$MentorIntroductionResponseImpl value,
          $Res Function(_$MentorIntroductionResponseImpl) then) =
      __$$MentorIntroductionResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'introduction_title') String? introductionTitle,
      @JsonKey(name: 'introduction_description')
      String? introductionDescription,
      @JsonKey(name: 'introduction_answer1') String? introductionAnswer1,
      @JsonKey(name: 'introduction_answer2') String? introductionAnswer2});
}

/// @nodoc
class __$$MentorIntroductionResponseImplCopyWithImpl<$Res>
    extends _$MentorIntroductionResponseCopyWithImpl<$Res,
        _$MentorIntroductionResponseImpl>
    implements _$$MentorIntroductionResponseImplCopyWith<$Res> {
  __$$MentorIntroductionResponseImplCopyWithImpl(
      _$MentorIntroductionResponseImpl _value,
      $Res Function(_$MentorIntroductionResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? introductionTitle = freezed,
    Object? introductionDescription = freezed,
    Object? introductionAnswer1 = freezed,
    Object? introductionAnswer2 = freezed,
  }) {
    return _then(_$MentorIntroductionResponseImpl(
      introductionTitle: freezed == introductionTitle
          ? _value.introductionTitle
          : introductionTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      introductionDescription: freezed == introductionDescription
          ? _value.introductionDescription
          : introductionDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      introductionAnswer1: freezed == introductionAnswer1
          ? _value.introductionAnswer1
          : introductionAnswer1 // ignore: cast_nullable_to_non_nullable
              as String?,
      introductionAnswer2: freezed == introductionAnswer2
          ? _value.introductionAnswer2
          : introductionAnswer2 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MentorIntroductionResponseImpl implements _MentorIntroductionResponse {
  const _$MentorIntroductionResponseImpl(
      {@JsonKey(name: 'introduction_title') required this.introductionTitle,
      @JsonKey(name: 'introduction_description')
      required this.introductionDescription,
      @JsonKey(name: 'introduction_answer1') required this.introductionAnswer1,
      @JsonKey(name: 'introduction_answer2')
      required this.introductionAnswer2});

  factory _$MentorIntroductionResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MentorIntroductionResponseImplFromJson(json);

  @override
  @JsonKey(name: 'introduction_title')
  final String? introductionTitle;
  @override
  @JsonKey(name: 'introduction_description')
  final String? introductionDescription;
  @override
  @JsonKey(name: 'introduction_answer1')
  final String? introductionAnswer1;
  @override
  @JsonKey(name: 'introduction_answer2')
  final String? introductionAnswer2;

  @override
  String toString() {
    return 'MentorIntroductionResponse(introductionTitle: $introductionTitle, introductionDescription: $introductionDescription, introductionAnswer1: $introductionAnswer1, introductionAnswer2: $introductionAnswer2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorIntroductionResponseImpl &&
            (identical(other.introductionTitle, introductionTitle) ||
                other.introductionTitle == introductionTitle) &&
            (identical(
                    other.introductionDescription, introductionDescription) ||
                other.introductionDescription == introductionDescription) &&
            (identical(other.introductionAnswer1, introductionAnswer1) ||
                other.introductionAnswer1 == introductionAnswer1) &&
            (identical(other.introductionAnswer2, introductionAnswer2) ||
                other.introductionAnswer2 == introductionAnswer2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, introductionTitle,
      introductionDescription, introductionAnswer1, introductionAnswer2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorIntroductionResponseImplCopyWith<_$MentorIntroductionResponseImpl>
      get copyWith => __$$MentorIntroductionResponseImplCopyWithImpl<
          _$MentorIntroductionResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MentorIntroductionResponseImplToJson(
      this,
    );
  }
}

abstract class _MentorIntroductionResponse
    implements MentorIntroductionResponse {
  const factory _MentorIntroductionResponse(
          {@JsonKey(name: 'introduction_title')
          required final String? introductionTitle,
          @JsonKey(name: 'introduction_description')
          required final String? introductionDescription,
          @JsonKey(name: 'introduction_answer1')
          required final String? introductionAnswer1,
          @JsonKey(name: 'introduction_answer2')
          required final String? introductionAnswer2}) =
      _$MentorIntroductionResponseImpl;

  factory _MentorIntroductionResponse.fromJson(Map<String, dynamic> json) =
      _$MentorIntroductionResponseImpl.fromJson;

  @override
  @JsonKey(name: 'introduction_title')
  String? get introductionTitle;
  @override
  @JsonKey(name: 'introduction_description')
  String? get introductionDescription;
  @override
  @JsonKey(name: 'introduction_answer1')
  String? get introductionAnswer1;
  @override
  @JsonKey(name: 'introduction_answer2')
  String? get introductionAnswer2;
  @override
  @JsonKey(ignore: true)
  _$$MentorIntroductionResponseImplCopyWith<_$MentorIntroductionResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
