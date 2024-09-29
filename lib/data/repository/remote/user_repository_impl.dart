import 'package:cogo/data/model/sms_verification_result.dart';
import 'package:cogo/data/service/user_service.dart';

import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<SmsVerificationResult> requestSmsVerification(
      String phoneNumber) async {
    return await _userService.sendVerificationCode(phoneNumber);
  }
}
