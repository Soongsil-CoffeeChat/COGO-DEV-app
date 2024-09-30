import 'package:cogo/data/repository/remote/refresh_repository.dart';
import 'package:cogo/data/service/refresh_service.dart';

class RefreshRepositoryImpl implements RefreshRepository {
  final RefreshService _refreshService;

  RefreshRepositoryImpl(this._refreshService);

  @override
  Future<String> getAccessToken(String authCode) async {
    return await _refreshService.getAccessToken(authCode);
  }
}
