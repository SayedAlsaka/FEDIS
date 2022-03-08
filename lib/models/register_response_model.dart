class RegisterResponseModel
{
  String? result;
  int? clientId;
  String? message;

  RegisterResponseModel.fromJson(Map<String , dynamic> json )
  {
    result = json['result'];
    clientId=json['clientid'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'clientid': clientId,
      'message': message,
    };
  }
}