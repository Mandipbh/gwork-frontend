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
  static const String updatePhoneNumber = "/worker/profile/phone-number";
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
  static const String getProfessionalJobDetails =
      "/worker/jobs/job-overview-professional";
  static const String getGalleryDetails = "worker/jobs/job-gallery";
  static const String applyForJobProfessional =
      "/worker/jobs/add-job-application";
  static const String getClientJobApplications =
      '/worker/jobs/job-applications';
  static const String getClientJobDetails = "/worker/jobs/job-overview";

  static const String deleteJob = '/worker/jobs/remove-job';
  static const String acceptJob = '/worker/jobs/accpet-job-applications';
  static const String rejectJobProf = '/worker/jobs/remove-job-applications';
  static const String rejectApproveJob = '/worker/jobs/change-job-approval';
  static const String startJob = '/worker/jobs/start-job-professional';
  static const String completeJob = '/worker/jobs/complete-job-professional';
  static const String editOffer = '/worker/jobs/update-job-application';
  static const String addOffer = '/worker/jobs/add-job-application';
}

class DashboardFilters {
  static const int all = 0;
  static const int today = 1;
  static const int thisWeek = 2;
  static const int thisMonth = 3;
  static const int thisYear = 4;
}

class JobsFilters {
  static const String all = 'All';
  static const String applied = 'Applied';
  static const String accepted = 'Accepted';
  static const String doing = 'Doing';
  static const String rejected = 'Rejected';
  static const String completed = 'Completed';
  static const String expired = 'Expired';
  static const String pending = 'Pending';
  static const String published = 'Published';
  static const String reported = 'Reported';
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
  static const int bankDetail = 8;
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

class JobStatus {
  static const String published = "Published";
  static const String rejected = "Rejected";
  static const String pending = "Pending";
  static const String completed = "Completed";
  static const String applied = "Applied";
  static const String accepted = "Accepted";
  static const String doing = "Doing";
  static const String expired = "Expired";
  static const String reported = 'Reported';
}

class ChatType {
  static const int fromUser = 1;
  static const int toUser = 2;
}
