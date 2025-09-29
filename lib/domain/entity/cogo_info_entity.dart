import 'package:cogo/data/dto/response/application/cogo_info_response.dart';

class CogoInfoEntity {
  final int applicationId;
  final String otherPartyName;
  final String applicationStatus;
  final DateTime applicationDate;

  CogoInfoEntity({
    required this.applicationId,
    required this.otherPartyName,
    required this.applicationStatus,
    required this.applicationDate,
  });

  factory CogoInfoEntity.fromResponse(CogoInfoResponse response) {
    return CogoInfoEntity(
      applicationId: response.applicationId,
      otherPartyName: response.otherPartyName,
      applicationStatus: response.applicationStatus,
      applicationDate: DateTime.parse(response.applicationDate),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'otherPartyName': otherPartyName,
      'applicationStatus': applicationStatus,
      'application_date': applicationDate,
    };
  }
}
