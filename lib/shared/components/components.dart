import 'package:fedis/shared/styles/color.dart';
import 'package:flutter/material.dart';

void navigatepush(context , widget) =>   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateandFinish(context , widget) =>

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>widget,
        ),
            (route) => false
    );



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
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hint,
        labelText: label,
        label: lab,
        focusColor: Colors.red,
        focusedErrorBorder:const OutlineInputBorder(
          borderSide: const BorderSide(color: defaultColor, width: 1.0),
        ) ,
        errorBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: defaultColor, width: 1.0),
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: defaultColor, width: 1.0),
      ),
      //  border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),

        prefixIcon: Icon(picon , color: Colors.black,),
        suffixIcon: sicon != null ? IconButton(
          icon: Icon(sicon , color: Colors.black,) ,
          onPressed: suffixPressed,
        ) : null,
      ),
      validator: validate,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onTap: onTab,
      onChanged: onChange as void Function(String)?,
    );


Widget defalultButton({
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
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text!.toUpperCase() , style: TextStyle(color: defaultColor),),

    );

