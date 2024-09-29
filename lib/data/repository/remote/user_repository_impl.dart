import 'package:dio/dio.dart';

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
      return await _userService.sendVerificationCode(phoneNumber);
    } on DioException catch (error) {
      // if (error.response?.statusCode == 400) {
      //   return SmsVerificationResult(
      //     message: error.response?.data['message'] ??
      //         'Failed to send verification code',
      //   );
      // } else {
      throw Exception('Network error: ${error.message}');
      // }
    }
  }
}
