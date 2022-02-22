class NoInvoicesModel
{
  String? result;
  int? totalInvoices;
  List<dynamic>? invoices;
  NoInvoicesModel.fromJson(Map<String,dynamic> json)
  {
    result = json['result'];
    totalInvoices = json['totalresults'];
    invoices = List.castFrom<dynamic, dynamic>(json['invoices']);
  }

}