import 'package:cogo/data/repository/remote/refresh_repository.dart';
import 'package:cogo/data/service/refresh_service.dart';

import '../../dto/token.dart';

class RefreshRepositoryImpl implements RefreshRepository {
  final RefreshService _refreshService;

  RefreshRepositoryImpl(this._refreshService);

  @override
  Future<Token> getAccessToken(String authCode) async {
    return await _refreshService.getAccessToken(authCode);
  }
}
