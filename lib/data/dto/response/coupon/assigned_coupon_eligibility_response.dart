class AssignedCouponEligibilityResponse {
  final bool eligible;
  final bool alreadyIssued;
  final String? name;
  final String? couponNumber;
  final String? status;
  final DateTime? issuedAt;
  final DateTime? usedAt;

  AssignedCouponEligibilityResponse({
    required this.eligible,
    required this.alreadyIssued,
    this.name,
    this.couponNumber,
    this.status,
    this.issuedAt,
    this.usedAt,
  });

  factory AssignedCouponEligibilityResponse.fromJson(Map<String, dynamic> json) {
    return AssignedCouponEligibilityResponse(
      eligible: json['eligible'] as bool,
      alreadyIssued: json['alreadyIssued'] as bool,
      name: json['name'] as String?,
      couponNumber: json['couponNumber'] as String?,
      status: json['status'] as String?,
      issuedAt: json['issuedAt'] != null ? DateTime.parse(json['issuedAt'] as String) : null,
      usedAt: json['usedAt'] != null ? DateTime.parse(json['usedAt'] as String) : null,
    );
  }
}
