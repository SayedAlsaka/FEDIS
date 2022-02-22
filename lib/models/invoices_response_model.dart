class InvoicesModel
{
  String? result;
  int? totalInvoices;
  InvoicesListModel? invoicesListModel;
  InvoicesModel.fromJson(Map<String,dynamic> json)
  {
    result = json['result'];
    totalInvoices = json['totalresults'];
    invoicesListModel = InvoicesListModel.fromJson(json['invoices']);
  }

}
class InvoicesListModel
{
  List<InvoiceDataModel>? invoice;
  InvoicesListModel.fromJson(Map<String, dynamic> json)
  {
    invoice = List.from(json['invoice']).map((e)=>InvoiceDataModel.fromJson(e)).cast<InvoiceDataModel>().toList();

  }
}
class InvoiceDataModel
{
  int? invoiceID;
  int? userID;
  String? firstName;
  String? invoiceNumber;
  String? date;
  String? dueDate;
  String? datePaid;
  String? dateRefunded;
  String? dateCancelled;
  String? subtotal;
  String? tax;
  String? total;
  String? taxRate;
  String? status;
  String? paymentMethod;
  String? currencyCode;
  String? currencySuffix;

  InvoiceDataModel.fromJson(Map<String,dynamic> json)
  {
    invoiceID=json['id'];
    userID=json['userid'];
    firstName = json['firstname'];
    invoiceNumber=json['invoicenum'];
    date=json['date'];
    dueDate = json['duedate'];
    datePaid=json['datepaid'];
    dateRefunded = json['date_refunded'];
    dateCancelled=json['date_cancelled'];
    subtotal=json['subtotal'];
    tax = json['tax'];
    total=json['total'];
    taxRate=json['taxrate'];
    status = json['status'];
    paymentMethod=json['paymentmethod'];
    currencyCode = json['currencycode'];
    currencySuffix = json['currencysuffix'];

  }
}