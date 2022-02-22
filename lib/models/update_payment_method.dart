class ChangePaymentModel
{
  late final String result;
  late final int invoiceID;


  ChangePaymentModel.fromJson(Map<String, dynamic> json){
    result = json['result'];
    invoiceID = json['invoiceid'];

  }
}