import 'package:cogo/data/service/mentor_service.dart';
import 'package:cogo/data/service/auth_service.dart';
import 'package:cogo/data/service/s3_service.dart';
import 'package:cogo/data/service/user_service.dart';
import 'package:cogo/features/auth/login/login_view_model.dart';
import 'package:cogo/features/auth/signup/club/club_selection_view_model.dart';
import 'package:cogo/features/auth/signup/interest/interest_selection_view_model.dart';
import 'package:cogo/features/auth/signup/mentor_info/mentor_info_view_model.dart';
import 'package:cogo/features/auth/signup/name_input/name_input_view_model.dart';
import 'package:cogo/features/auth/signup/phone_number/phone_number_view_model.dart';
import 'package:cogo/features/home/home_view_model.dart';
import 'package:cogo/features/splash_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  ///dio 등록
  getIt.registerLazySingleton<Dio>(() => Dio());

  ///Service 등록
  getIt.registerLazySingleton<MentorService>(() => MentorService());

  getIt.registerLazySingleton<UserService>(() => UserService());

  getIt.registerLazySingleton<AuthService>(() => AuthService());

  ///뷰모델 등록
  getIt.registerLazySingleton<S3Service>(() => S3Service());

  getIt.registerFactory<LoginViewModel>(() => LoginViewModel());

  getIt.registerFactory<PhoneNumberViewModel>(
      () => PhoneNumberViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<NameInputViewModel>(
      () => NameInputViewModel(userService: getIt<UserService>()));

  getIt.registerFactory<InterestSelectionViewModel>(
      () => InterestSelectionViewModel());

  getIt.registerFactory<ClubSelectionViewModel>(() => ClubSelectionViewModel());

  getIt.registerFactory<MentorInfoViewModel>(() => MentorInfoViewModel());

  getIt.registerFactory<HomeViewModel>(() => HomeViewModel());

  getIt.registerLazySingleton<SplashViewModel>(() => SplashViewModel());
}
