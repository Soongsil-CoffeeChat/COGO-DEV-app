class EventStatusResponse {
  final String status;
  final int remainingCount;

  EventStatusResponse({
    required this.status,
    required this.remainingCount,
  });

  factory EventStatusResponse.fromJson(Map<String, dynamic> json) {
    return EventStatusResponse(
      status: json['status'] as String,
      remainingCount: json['remainingCount'] as int,
    );
  }
}
