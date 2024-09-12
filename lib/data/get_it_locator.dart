import 'package:cogo/data/repository/UserRepositoryImpl.dart';
import 'package:cogo/data/repository/UserRepostory.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/phone_number_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  // 서비스 등록
  // getIt.registerLazySingleton<UserService>(() => UserService(getIt<ApiClient>()));

  // 레포지토리 등록
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt<UserService>()));

  // 뷰모델 등록
  getIt.registerFactory<PhoneNumberVerificationViewModel>(() =>
      PhoneNumberVerificationViewModel(
          userRepository: getIt<UserRepository>()));
}
