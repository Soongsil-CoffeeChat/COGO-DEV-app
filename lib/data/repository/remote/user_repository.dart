import 'package:cogo/data/dto/sms_verification_result_response.dart';

abstract class UserRepository {
  Future<SmsVerificationResult?> requestSmsVerification(String phoneNumber);
}
