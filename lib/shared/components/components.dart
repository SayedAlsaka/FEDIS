import 'package:easy_localization/easy_localization.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/network/local/cash_helper.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart';

void navigatePush(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget localizedApp(Widget widget) {
  var currentLanguage = CashHelper.getData(key: 'Language');
  Locale locale = LOCALES[0];
  if (currentLanguage == null) {
    CashHelper.saveData(key: 'Language', value: 'ar');
  } else if (currentLanguage == 'ar') {
    locale = LOCALES[0];
  } else {
    locale = LOCALES[1];
  }

  return EasyLocalization(
    path: 'assets/translations/',
    assetLoader: const CodegenLoader(),
    supportedLocales: LOCALES,
    fallbackLocale: locale,
    startLocale: LOCALES[0],
    child: MyApp(
      startWidget: widget,
    ),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  String? Function(String?)? validate,
  String? label,
  Widget? lab,
  required IconData picon,
  bool isPassword = false,
  Function? onChange,
  IconData? sicon,
  Function()? suffixPressed,
  Function()? onTab,
  Function? onSubmit,
  EdgeInsets? contentPadding,
  String? hint,
  TextStyle? style,
}) =>
    TextFormField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      cursorColor: Colors.black,
      style: const TextStyle(fontFamily: 'Tajawal'),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hint,
        labelText: label,
        label: lab,
        focusColor: Colors.red,
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor, width: 1.0),
        ),
        //  border: OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.black),

        prefixIcon: Icon(
          picon,
          color: Colors.black,
        ),
        suffixIcon: sicon != null
            ? IconButton(
                icon: Icon(
                  sicon,
                  color: Colors.black,
                ),
                onPressed: suffixPressed,
              )
            : null,
      ),
      validator: validate,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onTap: onTab,
      onChanged: onChange as void Function(String)?,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.grey,
  bool isUpperCase = true,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        color: defaultColor,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal'),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text!.toUpperCase(),
        style: const TextStyle(
          color: defaultColor,
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
        ),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

SnackBar snackBar({
  required String msg,
  required ToastStates state,
}) =>
    SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: chooseToastColor(state),
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Tajawal', fontSize: 18.0, color: Colors.white),
        ));

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.grey;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = defaultColor;
      break;
  }
  return color;
}
