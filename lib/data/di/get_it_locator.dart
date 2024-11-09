import 'package:cogo/data/service/possibledate_service.dart';
import 'package:cogo/data/service/refresh_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/login/login_view_model.dart';
import 'package:cogo/features/auth/signup/view_models/shared_views/phone_number_view_model.dart';
import 'package:cogo/features/mypage/mentor_time_setting/mentor_time_setting_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  /**
   * dio 등록
   */
  getIt.registerLazySingleton<Dio>(() => Dio());

  /**
   * 뷰모델 등록
   */
  getIt.registerFactory<LoginViewModel>(
      () => LoginViewModel(refreshService: getIt<RefreshService>()));

  getIt.registerFactory<PhoneNumberViewModel>(
      () => PhoneNumberViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<MentorTimeSettingViewModel>(() =>
      MentorTimeSettingViewModel(
          possibledateService: getIt<PossibledateService>()));
}
