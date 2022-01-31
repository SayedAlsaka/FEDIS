class RegisterResponseModel
{
  String? result;
  int? clientId;

  RegisterResponseModel.fromJson(Map<String , dynamic> json )
  {
    result = json['result'];
    clientId=json['clientid'];
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'clientid': clientId,
    };
  }
}