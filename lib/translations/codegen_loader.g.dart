// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "LoginScreen_Email": "البريد الالكتروني",
  "LoginScreen_Password": "كلمة السر",
  "LoginScreen_LoginButton": "تسجيل الدخول",
  "LoginScreen_NewAccount": "ليس لديك حساب؟",
  "LoginScreen_RegisterNow": "سجل الان",
  "LoginScreen_LangButton": "EN",
  "RegisterScreen_title": "حساب جديد",
  "RegisterScreen_title1": "انشيء حسابك معنا",
  "RegisterScreen_Fname": "الاسم الاول",
  "RegisterScreen_Lname": "الاسم الاخير",
  "RegisterScreen_Email": "البريد الالكتروني",
  "RegisterScreen_mobile": "رقم الجوال",
  "RegisterScreen_company": "اسم الشركة",
  "RegisterScreen_country": "البلد",
  "RegisterScreen_Street": "عنوان الشارع",
  "RegisterScreen_city": "المدينة",
  "RegisterScreen_postcode": "الرمز البريدي",
  "RegisterScreen_state": "المنطقة",
  "RegisterScreen_addinfo": "المعلومات الاضافية",
  "RegisterScreen_account": "اختر نوع الحساب",
  "RegisterScreen_ID": "الرقم القومي",
  "RegisterScreen_password": "كلمة السر",
  "RegisterScreen_button": "التسجيل",
  "HomeScreen_welcome": "مرحباً ",
  "HomeScreen_LastLogin": "اخر تسجيل دخول",
  "HomeScreen_at": "الساعة",
  "HomeScreen_pInvoices": "فواتير مدفوعة",
  "HomeScreen_unpInvoices": "فواتير غير مدفوعة",
  "HomeScreen_producsActive": "الخدمات النشطة"
};
static const Map<String,dynamic> en = {
  "LoginScreen_Email": "Email Address",
  "LoginScreen_Password": "Password",
  "LoginScreen_LoginButton": "Login",
  "LoginScreen_NewAccount": "Don't have an account",
  "LoginScreen_RegisterNow": "Register Now",
  "LoginScreen_LangButton": "ع",
  "RegisterScreen_title": "Register",
  "RegisterScreen_title1": "Create an account with us",
  "RegisterScreen_Fname": "First Name",
  "RegisterScreen_Lname": "Last Name",
  "RegisterScreen_Email": "Email Address",
  "RegisterScreen_mobile": "Phone Number",
  "RegisterScreen_company": "Company Name",
  "RegisterScreen_country": "Country",
  "RegisterScreen_Street": "Street Address",
  "RegisterScreen_city": "City",
  "RegisterScreen_postcode": "Postcode",
  "RegisterScreen_state": "State",
  "RegisterScreen_addinfo": "Additional Information",
  "RegisterScreen_account": "Select an account type",
  "RegisterScreen_ID": "National ID",
  "RegisterScreen_password": "Password",
  "RegisterScreen_button": "REGISTER",
  "HomeScreen_welcome": "Welcome",
  "HomeScreen_LastLogin": "Last Login",
  "HomeScreen_at": "at",
  "HomeScreen_pInvoices": "PAID INVOICES",
  "HomeScreen_unpInvoices": "UNPAID INVOICES",
  "HomeScreen_producsActive": "ACTIVE SERVICES"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
