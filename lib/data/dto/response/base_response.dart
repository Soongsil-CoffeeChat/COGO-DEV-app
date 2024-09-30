class BaseResponse<T> {
  final String statusCode;
  final String message;
  final T content;

  BaseResponse({
    required this.statusCode,
    required this.message,
    required this.content,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json,
      T Function(dynamic) fromJsonT) {
    return BaseResponse(
      statusCode: json['statusCode'] as String,
      message: json['message'] as String,
      content: fromJsonT(json['content']),
    );
  }
}
