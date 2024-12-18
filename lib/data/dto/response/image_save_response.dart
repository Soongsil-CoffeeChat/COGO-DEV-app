import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_save_response.freezed.dart';
part 'image_save_response.g.dart';

@freezed
class ImageSaveResponse with _$ImageSaveResponse {
  const factory ImageSaveResponse({
    String? savedUrl,
  }) = _ImageSaveResponse;

  factory ImageSaveResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageSaveResponseFromJson(json);
}
