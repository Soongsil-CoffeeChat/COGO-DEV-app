

abstract class UserRepository {
  Future<Map<String, dynamic>> requestSmsVerification(String phoneNumber);
}
