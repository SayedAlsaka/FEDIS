class ClientModel
{
  String? result;
  int? userId;
  String? uuid;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? lastLogin;
  String? companyName;
  String? address;
  String? city;
  String? state;
  String? postCode;
  String? mobileNumber;
  String? defaultPayment;
  String? countryName;
  String? language;
  String? address2;
  String? vatNumber;
  String? accountType;
  // EmailPreferences? em;
  ClientStats? stats;
ClientModel.fromJson(Map<String,dynamic> json)
{
  result = json['result'];
  userId = json['userid'];
  uuid=json['uuid'];
  firstName = json['firstname'];
  lastName = json['lastname'];
  fullName=json['fullname'];
  address = json['address1'];
  address2 = json['address2'];
  state=json['fullstate'];
  email=json['email'];
  lastLogin=json['lastlogin'];
  companyName=json['companyname'];
  city=json['city'];
  postCode=json['postcode'];
  defaultPayment = json['defaultgateway'];
  language = json['language'];
  accountType = json['customfields1'];
  mobileNumber = json['phonenumber'];
  countryName = json['countryname'];
  vatNumber=json['tax_id'];
  // em=EmailPreferences.fromJson(json['email_preferences']);
 stats=ClientStats.fromJson(json['stats']);
  
}

}

// class EmailPreferences
// {
//   int? general;
//   int? invoice;
//   int? support;
//   int? product;
//   int? domain;
//   int? affiliate;
//
//   EmailPreferences.fromJson(Map<String,dynamic> json)
//   {
//     general = json['general'];
//     invoice = json['invoice'];
//     support = json['support'];
//     domain=json['domain'];
//     affiliate=json['affiliate'];
//   }
// }
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