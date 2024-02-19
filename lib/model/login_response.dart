class LoginResponse {
  bool? success;
  bool? isFirstLogin;
  String? message;
  String? token;

  LoginResponse({this.success, this.isFirstLogin, this.message,this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    isFirstLogin = json['isFirstLogin'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['isFirstLogin'] = isFirstLogin;
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}
