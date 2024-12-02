import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/data/service/refresh_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/login/login_view_model.dart';
import 'package:cogo/features/auth/signup/club/club_selection_view_model.dart';
import 'package:cogo/features/auth/signup/interest/interest_selection_view_model.dart';
import 'package:cogo/features/auth/signup/name_input/name_input_view_model.dart';
import 'package:cogo/features/auth/signup/phone_number/phone_number_view_model.dart';
import 'package:cogo/features/home/home/view_model/home_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  /**
   * dio 등록
   */
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<MentorService>(() => MentorService());

  getIt.registerLazySingleton<UserService>(() => UserService());

  /**
   * 뷰모델 등록
   */
  getIt.registerFactory<LoginViewModel>(
      () => LoginViewModel(refreshService: getIt<RefreshService>()));

  getIt.registerFactory<PhoneNumberViewModel>(
      () => PhoneNumberViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<NameInputViewModel>(
      () => NameInputViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<InterestSelectionViewModel>(
      () => InterestSelectionViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<ClubSelectionViewModel>(
      () => ClubSelectionViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
}
