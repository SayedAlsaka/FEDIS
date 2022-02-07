class RegisterRequestModel
{
  String? action;
  String? username;
  String? passwordA;
  String? accessKey;
  String? responseType;
  String? fName;
  String? lName;
  String? email;
  String? phoneNumber;
  String? companyNumber;
  String? address;
  String? country;
  String? city;
  String? state;
  String? postCode;
  String? password;
  List<CustomFields>? customFields;
  int? nationalId;
  String? accountType;


  RegisterRequestModel(
      this.action,
      this.username,
      this.passwordA,
      this.accessKey,
      this.responseType,
      this.fName,
      this.lName,
      this.email,
      this.phoneNumber,
      this.companyNumber,
      this.address,
      this.country,
      this.city,
      this.state,
      this.postCode,
      this.password,
      this.customFields,
      this.nationalId,
      this.accountType
      );

  RegisterRequestModel.fromJson(Map<String , dynamic> json )
  {
    action = json['action'];
    username=json['username'];
    passwordA=json['password'];
    accessKey=json['password'];
    responseType=json['responsetype'];
    fName=json['firstname'];
    lName=json['lastname'];
    email=json['email'];
    phoneNumber=json['phonenumber'];
    companyNumber=json['companynumber'];
    address=json['address1'];
    country=json['country'];
    city=json['city'];
    state=json['state'];
    postCode=json['postcode'];
    password=json['password2'];
    json['customfields'].forEach((element) {
      customFields!.add(CustomFields.fromJson(element));
    });
    nationalId=json['customfield[8]'];
    password=json['customfield[9]'];
  
  }
  toJson() {
    return {
      'action': action,
      'username': username,
      'password': passwordA,
      'password': accessKey,
      'responsetype': responseType,
      'firstname': fName,
      'lastname': lName,
      'email': email,
      'phonenumber': phoneNumber,
      'companynumber': companyNumber,
      'address1': address,
      'country': country,
      'city': city,
      'postcode': postCode,
      'password2': password,
      'customfields':customFields.toString(),
      'customfield[8]':nationalId,
      'customfield[9]':accountType,
    };
  }



}

class CustomFields
{
  int? id;
  String? value;


  CustomFields(this.id, this.value);

  CustomFields.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    value=json['value'];
  }

  toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}