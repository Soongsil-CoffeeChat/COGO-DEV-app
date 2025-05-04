import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ///토큰
  Future<String?> readAccessToken() async {
    return await _storage.read(key: "access_token");
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: "access_token", value: accessToken);
  }

  Future<String?> readRefreshToken() async {
    return await _storage.read(key: "refresh_token");
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: "refresh_token", value: refreshToken);
  }

  ///유저 정보
  Future<String?> readUserName() async {
    return await _storage.read(key: "user_name");
  }

  Future<void> saveUserName(String name) async {
    await _storage.write(key: "user_name", value: name);
  }

  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: "user_email", value: email);
  }

  Future<String?> readUserEmail() async {
    return await _storage.read(key: "user_email");
  }

  Future<String?> readRole() async {
    return await _storage.read(key: "role");
  }

  Future<void> saveRole(String role) async {
    await _storage.write(key: "role", value: role);
  }

  Future<String?> readInterest() async {
    return await _storage.read(key: "interest");
  }

  Future<void> saveInterest(String interest) async {
    await _storage.write(key: "interest", value: interest);
  }

  ///동아리
  Future<String?> readClub() async {
    return await _storage.read(key: "club");
  }

  Future<void> saveClub(String club) async {
    await _storage.write(key: "club", value: club);
  }

  /// 멘토 자기소개 입력 여부
  Future<void> saveIntroductionCompleted(bool value) async {
    await _storage.write(
        key: "introduction_completed", value: value.toString());
  }

  Future<bool> readIntroductionCompleted() async {
    final result = await _storage.read(key: "introduction_completed");
    if (result == null) return false; // 저장된 값이 없으면 false
    return result.toLowerCase() == 'true'; // 저장된 값이 'true'면 true, 아니면 false
  }

  ///모든 데이터 삭제
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
