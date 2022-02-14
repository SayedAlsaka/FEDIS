class ResetResponseModel
{
  String? result;

  ResetResponseModel.fromJson(Map<String , dynamic> json )
  {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
    };
  }
}