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
      final SmsVerificationResult response =
          await _userService.sendVerificationCode(phoneNumber);

      return response;
    } catch (e) {
      return SmsVerificationResult.failure(
        errorMessage: 'Error requesting SMS verification: ${e.toString()}',
      );
    }
  }
}
