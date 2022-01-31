class LoginResponseModel
{
    String? result;
    int? userId;
    String? passwordHash;
    bool? twoFactorEnabled;
    String? message;
  LoginResponseModel.fromJson(Map<String , dynamic> json )
  {
    result = json['result'];
    userId=json['userid'];
    passwordHash=json['passwordhash'];
    twoFactorEnabled=json['twoFactorEnabled'];
    message=json['message'];
  }

      toJson() {
      return {
        'result': result,
        'userid': userId,
        'passwordHash': passwordHash,
        'twoFactorEnabled': twoFactorEnabled,
        'message':message,
      };
    }
}