import '../service/user_service.dart';
import 'UserRepostory.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  // UserService를 생성자에서 주입받음
  UserRepositoryImpl(this._userService);

  @override
  Future<Map<String, dynamic>> requestSmsVerification(
      String phoneNumber) async {
    try {
      // UserService를 사용하여 SMS 인증 요청
      final response = await _userService.sendVerificationCode(phoneNumber);

      // 받은 응답을 처리하고 반환
      return {
        'verificationCode': response['verificationCode'],
        'message': response['message'],
      };
    } catch (e) {
      throw Exception('Error requesting SMS verification: $e');
    }
  }
}
