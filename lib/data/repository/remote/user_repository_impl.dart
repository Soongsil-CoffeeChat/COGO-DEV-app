import '../../model/sms_verification_result.dart';
import '../../service/user_service.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<SmsVerificationResult> requestSmsVerification(
      String phoneNumber) async {
    try {
      final response = await _userService.sendVerificationCode(phoneNumber);

      // 성공적인 응답을 처리하고 Freezed 모델로 반환
      return SmsVerificationResult.success(
        verificationCode: response['verificationCode'],
        message: response['message'],
      );
    } catch (e) {
      // 오류 발생 시 Failure 상태 반환
      return SmsVerificationResult.failure(
        errorMessage: 'Error requesting SMS verification: $e',
      );
    }
  }
}
