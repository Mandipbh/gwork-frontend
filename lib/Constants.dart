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
}

class JobsType {
  static const int all = 0;
  static const int cleaning = 1;
  static const int babySitting = 2;
  static const int handyman = 3;
  static const int tutoring = 4;
}

class UserFilters {
  static const int registered = 0;
  static const int applications = 1;
}

class ProfileFieldType {
  static const int firstName = 0;
  static const int lastName = 1;
  static const int email = 2;
  static const int password = 3;
  static const int vatNumber = 4;
  static const int birthdate = 5;
}

class UserType {
  static const int client = 0;
  static const int admin = 1;
  static const int professional = 2;
}