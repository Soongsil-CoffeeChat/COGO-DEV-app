import '../../dto/token.dart';

abstract class RefreshRepository {
  Future<Token?> getAccessToken(String authCode);
}
