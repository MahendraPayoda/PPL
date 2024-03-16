class ApiUrls {
  static const String baseUrl = 'http://192.168.7.57/api/';

  static const String login = '${baseUrl}Account/login';
  static const String forgotPasswordRequest = '${baseUrl}Account/forgotPassword/request';
  static const String verifyOtp = '${baseUrl}Account/forgotPassword/verifyCode';
  static const String resetPasswordRequest = '${baseUrl}Account/forgotPassword/reset';
  static const String changePasswordRequest = '${baseUrl}Account/changePassword';
  static const String getAllEmployeeCount = '${baseUrl}Employeedata/totalEmployeesCount';
  static const String getTotalTeamsCount = '${baseUrl}Teams/totalTeamsCount';
  static const String getEmployeeNameList = '${baseUrl}Employeedata/employeeNames?';
  static const String getTeamList = '${baseUrl}Teams/teamDetails';
  static const String individualTeamDetail = '${baseUrl}Teams/getIndividualTeamDetails/';
  static const String allAssignedUnAssignedEmployee = '${baseUrl}Teams/getEmployeeTeams';
  static const String createTeam = '${baseUrl}Teams/CreateTeam';
  static const String getEngagementQuaterData = '${baseUrl}Engagement/ScheduleEngagementsInQuarters';
  static const String engagementUpload = '${baseUrl}Engagement/UploadEngagement';
  static const String createEngagement = '${baseUrl}Engagement/CreateEngagement';
  static const String engagementType = '${baseUrl}Engagement/EngagementTypes';
}
