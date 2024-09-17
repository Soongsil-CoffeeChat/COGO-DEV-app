import '../../model/sms_verification_result.dart';

abstract class UserRepository {
  Future<SmsVerificationResult> requestSmsVerification(String phoneNumber);
}
