import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // 데이터 저장
  Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // 데이터 읽기
  Future<String?> readData(String key) async {
    return await _storage.read(key: key);
  }

  // 데이터 삭제
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  // 모든 데이터 삭제
  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
