// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_save_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageSaveResponse _$ImageSaveResponseFromJson(Map<String, dynamic> json) {
  return _ImageSaveResponse.fromJson(json);
}

/// @nodoc
mixin _$ImageSaveResponse {
  String? get savedUrl => throw _privateConstructorUsedError;

  /// Serializes this ImageSaveResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageSaveResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageSaveResponseCopyWith<ImageSaveResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageSaveResponseCopyWith<$Res> {
  factory $ImageSaveResponseCopyWith(
          ImageSaveResponse value, $Res Function(ImageSaveResponse) then) =
      _$ImageSaveResponseCopyWithImpl<$Res, ImageSaveResponse>;
  @useResult
  $Res call({String? savedUrl});
}

/// @nodoc
class _$ImageSaveResponseCopyWithImpl<$Res, $Val extends ImageSaveResponse>
    implements $ImageSaveResponseCopyWith<$Res> {
  _$ImageSaveResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageSaveResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedUrl = freezed,
  }) {
    return _then(_value.copyWith(
      savedUrl: freezed == savedUrl
          ? _value.savedUrl
          : savedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageSaveResponseImplCopyWith<$Res>
    implements $ImageSaveResponseCopyWith<$Res> {
  factory _$$ImageSaveResponseImplCopyWith(_$ImageSaveResponseImpl value,
          $Res Function(_$ImageSaveResponseImpl) then) =
      __$$ImageSaveResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? savedUrl});
}

/// @nodoc
class __$$ImageSaveResponseImplCopyWithImpl<$Res>
    extends _$ImageSaveResponseCopyWithImpl<$Res, _$ImageSaveResponseImpl>
    implements _$$ImageSaveResponseImplCopyWith<$Res> {
  __$$ImageSaveResponseImplCopyWithImpl(_$ImageSaveResponseImpl _value,
      $Res Function(_$ImageSaveResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageSaveResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedUrl = freezed,
  }) {
    return _then(_$ImageSaveResponseImpl(
      savedUrl: freezed == savedUrl
          ? _value.savedUrl
          : savedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageSaveResponseImpl implements _ImageSaveResponse {
  const _$ImageSaveResponseImpl({this.savedUrl});

  factory _$ImageSaveResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageSaveResponseImplFromJson(json);

  @override
  final String? savedUrl;

  @override
  String toString() {
    return 'ImageSaveResponse(savedUrl: $savedUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageSaveResponseImpl &&
            (identical(other.savedUrl, savedUrl) ||
                other.savedUrl == savedUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, savedUrl);

  /// Create a copy of ImageSaveResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageSaveResponseImplCopyWith<_$ImageSaveResponseImpl> get copyWith =>
      __$$ImageSaveResponseImplCopyWithImpl<_$ImageSaveResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageSaveResponseImplToJson(
      this,
    );
  }
}

abstract class _ImageSaveResponse implements ImageSaveResponse {
  const factory _ImageSaveResponse({final String? savedUrl}) =
      _$ImageSaveResponseImpl;

  factory _ImageSaveResponse.fromJson(Map<String, dynamic> json) =
      _$ImageSaveResponseImpl.fromJson;

  @override
  String? get savedUrl;

  /// Create a copy of ImageSaveResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageSaveResponseImplCopyWith<_$ImageSaveResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
