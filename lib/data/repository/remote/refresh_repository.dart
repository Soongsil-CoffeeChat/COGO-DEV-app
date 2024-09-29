import 'package:cogo/data/dto/response/token_response.dart';

abstract class RefreshRepository {
  Future<TokenResponse?> getAccessToken(String authCode);
}
