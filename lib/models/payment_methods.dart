class PaymentModel
{
  late final String result;
  late final int totalresults;
  late final PaymentMethods paymentmethods;

  PaymentModel.fromJson(Map<String, dynamic> json){
    result = json['result'];
    totalresults = json['totalresults'];
    paymentmethods = PaymentMethods.fromJson(json['paymentmethods']);
  }
}

class PaymentMethods
{
  late final List<PaymentMethod> paymentmethod;

  PaymentMethods.fromJson(Map<String, dynamic> json){
    paymentmethod = List.from(json['paymentmethod']).map((e)=>PaymentMethod.fromJson(e)).toList();
  }

}

class PaymentMethod
{
  late final String module;
  late final String displayname;

  PaymentMethod.fromJson(Map<String, dynamic> json){
    module = json['module'];
    displayname = json['displayname'];
  }
}

