import 'dart:core';

abstract class Apis {
  Apis._();

  /// 변수명은 동사+목적어로 명명한다.
  /// baseUrl 끝에 /가 있어서, 여기서는 맨 앞에 /을 빼고 기입한다.

  // 유저 관련 api
  static const String saveImage = "api/v2/users/picture";
  static const String userInfo = "api/v2/users";
  static const String signUpMentor = "api/v2/users/mentor";
  static const String signUpMentee = "api/v2/users/mentee";
  static const String setPhoneNumber = "api/v2/users/phone";
  static const String setEmail = "api/v2/users/email";
  static const String sendSms = "api/v2/users/sms";

  // Application 관련 api
  static const String application = "api/v2/applications";

  // 커피챗 시간 관련 api
  static const String possibleDates = "api/v2/possibleDates";

  // S3 관련 api
  static const String s3 = "api/v2/s3";

  // 멘토 관련 api
  static const String mentor = "api/v2/mentors";
}
