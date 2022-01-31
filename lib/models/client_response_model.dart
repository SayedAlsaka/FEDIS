class ClientModel
{
  String? result;
  int? userId;
  String? uuid;
  String? fullName;
  String? email;
  String? lastLogin;
  EmailPreferences? em;
  ClientStats? stats;
ClientModel.fromJson(Map<String,dynamic> json)
{
  result = json['result'];
  userId = json['userid'];
  uuid=json['uuid'];
  fullName=json['fullname'];
  email=json['email'];
  lastLogin=json['lastlogin'];
  em=EmailPreferences.fromJson(json['email_preferences']);
 stats=ClientStats.fromJson(json['stats']);
  
}

}

class EmailPreferences
{
  String? general;
  String? invoice;
  String? support;
  String? product;
  String? domain;
  String? affiliate;

  EmailPreferences.fromJson(Map<String,dynamic> json)
  {
    general = json['general'];
    invoice = json['invoice'];
    support = json['support'];
    domain=json['domain'];
    affiliate=json['affiliate'];
  }
}
class ClientStats
{
  int? numPaidInvoices;
  int? numUnPaidInvoices;
  int? productNumActive;

ClientStats.fromJson(Map<String,dynamic> json)
{
    numPaidInvoices=json['numpaidinvoices'];
    numUnPaidInvoices=json['numunpaidinvoices'];
    productNumActive = json['productsnumactive'];
}


}