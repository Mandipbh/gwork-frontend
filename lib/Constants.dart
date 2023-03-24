class API {
  static const String baseUrl = "https://gwork.macca.cloud";
}

class ApiEndPoints {
  static const String login = "/worker/auth/login";
  static const String adminLogin = "/admin/auth/login";
  static const String signUp = "/worker/auth/register";
  static const String getOtp = "/worker/auth/request-otp";
  static const String checkMobileNumber = "/worker/auth/check-phone";
  static const String checkEmail = "/worker/auth/check-email";
  static const String verifyOtp = "/worker/auth/otp-verify-phone";
  static const String updateName = "/worker/profile/name";
  static const String updateLastName = "/worker/profile/surname";
  static const String updatePassword = "/worker/profile/password";
  static const String updateEmail = "/worker/profile/email";
  static const String updateProfileImage = "/worker/profile/image";
  static const String updateBirthDate = "/worker/profile/birth_date";
  static const String updateVatNumber = "/worker/profile/vat_number";
  static const String requestChangePhoneNumber =
      "/worker/auth/request-phone-change";
  static const String verifyPhoneNumberOtp = "/worker/auth/verify-phone-otp";
  static const String updatePhoneNumber = "/worker/auth/phone-number";
  static const String otpVerifyPhone = "/worker/auth/otp-verify";
  static const String requestOtp = "/worker/auth/request-reset";
  static const String changePassword = "/worker/auth/change-password";
  static const String getProfile = "/worker/auth/";
  static const String removeProfileImage = "/worker/profile/image";

  //Client job list
  static const String getClientJobList = "/worker/jobs/job-list";
  static const String createClientJobList = '/worker/jobs/add-job';

  //Get province List
  static const String getProvinceList = '/worker/activities/province';

  //Get Professional List
  static const String getProfessionalJobList =
      "/worker/jobs/job-list-professional";
}

class DashboardFilters {
  static const int all = 0;
  static const int today = 1;
  static const int thisWeek = 2;
  static const int thisMonth = 3;
  static const int thisYear = 4;
}

class JobsFilters {
  static const int all = 0;
  static const int applied = 1;
  static const int accepted = 2;
  static const int doing = 3;
  static const int rejected = 4;
  static const int completed = 5;
  static const int expired = 6;
}

class JobsType {
  static const String all = "All";
  static const String cleaning = "Cleaning";
  static const String babySitting = "BabySitting";
  static const String handyman = "HandyMan";
  static const String tutoring = "Tutoring";
}

class UserFilters {
  static const int registered = 1;
  static const int applications = 2;
}

class ProfileFieldType {
  static const int firstName = 0;
  static const int lastName = 1;
  static const int email = 2;
  static const int password = 3;
  static const int vatNumber = 4;
  static const int birthdate = 5;
  static const int phoneNumber = 6;
  static const int paymentMethod = 7;
}

class UserType {
  static const int client = 0;
  static const int admin = 2;
  static const int professional = 1;
}

class SelectionType {
  static const int signUp = 1;
  static const int signIn = 2;
  static const int searchJobs = 1;
  static const int myJobs = 2;
}
