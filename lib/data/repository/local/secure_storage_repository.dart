import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 데이터 저장
  // Future<void> writeData(String key, String value) async {
  //   await _storage.write(key: key, value: value);
  // }
  //
  // // 데이터 읽기
  // 데이터 읽기
  // Future<String?> readData(String key) async {
  //   return await _storage.read(key: key);

  // // 데이터 삭제
  // Future<void> deleteData(String key) async {
  //   await _storage.delete(key: key);
  // }

  Future<String?> readAccessToken() async {
    return await _storage.read(key: "access_token");
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: "access_token", value: accessToken);
  }

  Future<void> saveUserName(String name) async {
    await _storage.write(key: "user_name", value: name);
  }

  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: "user_email", value: email);
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

  // 모든 데이터 삭제
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
