import 'dart:core';

abstract class Apis {
  Apis._();

  /// 변수명은 동사+목적어로 명명한다.
  /// baseUrl 끝에 /가 있어서, 여기서는 맨 앞에 /을 빼고 기입한다.

  /// 토큰 관련 api
  static const String getGoogleAccessToken = "auth/login/google";
  static const String getAppleAccessToken = "auth/login/apple";
  static const String reissueToken = "auth/reissue";
  static const String sendEmail = "auth/email";

  /// 유저 관련 api
  static const String saveImage = "users/picture";
  static const String user = "users";
  static const String signUpMentor = "users/mentor";
  static const String signUpMentee = "users/mentee";
  static const String setPhoneNumber = "users/phone";
  static const String setEmail = "users/email";
  static const String sendSms = "users/sms";

  /// Application 관련 api
  static const String application = "applications";

  /// 커피챗 시간 관련 api
  static const String possibleDates = "possibleDates";

  /// S3 관련 api
  static const String s3 = "s3";

  /// 멘토 관련 api
  static const String mentor = "mentors";
  static const String mentorPart = "mentors/list";
  static const String mentorIntroduction = "mentors/introductions";
}
