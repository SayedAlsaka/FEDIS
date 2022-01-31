import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/home_screen.dart';
import 'package:fedis/modules/login_screen/login_screen.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postCodeController = TextEditingController();
  var countryController = TextEditingController();
  var companyNameController = TextEditingController();
  var addressController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var nationalIdController = TextEditingController();
  var accountType = 'حساب فرد';
  var items = ['حساب شركة', 'حساب فرد'];
  var account = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${LocaleKeys.RegisterScreen_title.tr()}',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        '${LocaleKeys.RegisterScreen_title1.tr()}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //firstName - lastName
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: defaultFormField(
                              controller: firstNameController,
                              type: TextInputType.name,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your first name';
                                }
                                return null;
                              },
                              label: '${LocaleKeys.RegisterScreen_Fname.tr()}',
                              picon: Icons.person,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: defaultFormField(
                              controller: lastNameController,
                              type: TextInputType.name,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your last name';
                                }
                                return null;
                              },
                              label: '${LocaleKeys.RegisterScreen_Lname.tr()}',
                              picon: Icons.person,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          if (value.length < 5 ||
                              !value.contains('@') ||
                              !value.contains('.com')) {
                            return 'please enter a valid email address';
                          }
                          return null;
                        },
                        label: '${LocaleKeys.RegisterScreen_Email.tr()}',
                        picon: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      IntlPhoneField(
                        cursorColor: Colors.black,
                        controller: phoneController,
                        autovalidateMode: AutovalidateMode.disabled,
                        validator: null,
                        onCountryChanged: (country) {
                          countryController.text = country.code;
                        },
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: '${LocaleKeys.RegisterScreen_mobile.tr()}',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusColor: Colors.red,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          //  border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      // const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 200,
                            child: defaultFormField(
                              controller: companyNameController,
                              type: TextInputType.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: null,
                              label:
                                  '${LocaleKeys.RegisterScreen_company.tr()}',
                              picon: Icons.business,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: defaultFormField(
                              controller: countryController,
                              type: TextInputType.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: null,
                              label:
                                  '${LocaleKeys.RegisterScreen_country.tr()}',
                              picon: Icons.location_city,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: addressController,
                        type: TextInputType.text,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: null,
                        label: '${LocaleKeys.RegisterScreen_Street.tr()}',
                        picon: Icons.location_on,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //city - postCode
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 235,
                            child: defaultFormField(
                              controller: cityController,
                              type: TextInputType.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: null,
                              label: '${LocaleKeys.RegisterScreen_city.tr()}',
                              picon: Icons.business,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: defaultFormField(
                              controller: postCodeController,
                              type: TextInputType.number,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: null,
                              lab: Text('${LocaleKeys.RegisterScreen_postcode.tr()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              style: const TextStyle(
                                  fontSize: 3, color: Colors.green),
                              picon: Icons.wb_sunny,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: stateController,
                        type: TextInputType.text,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your state';
                          }
                          return null;
                        },
                        label: '${LocaleKeys.RegisterScreen_state.tr()}',
                        picon: Icons.map,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 1.0,
                            color: defaultColor,
                          ),
                          Spacer(),
                          Text(
                            '${LocaleKeys.RegisterScreen_addinfo.tr()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Container(
                            width: 100,
                            height: 1.0,
                            color: defaultColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          focusColor: Colors.red,
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: defaultColor, width: 1.0),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: defaultColor, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: defaultColor, width: 1.0),
                          ),
                          //  border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (account) {
                          if (account == null) {
                            return 'please select your account type';
                          }
                        },
                        hint: Text(
                          '${LocaleKeys.RegisterScreen_account.tr()}',
                          style: TextStyle(color: Colors.black),
                        ),
                        iconEnabledColor: Colors.black,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            child: Text(items),
                            value: items,
                          );
                        }).toList(),
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (newValue) {
                          accountType = newValue.toString();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                        controller: nationalIdController,
                        type: TextInputType.number,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your national id';
                          }
                          if (value.length < 14) {
                            return 'please enter a valid national id';
                          }
                          return null;
                        },
                        label: '${LocaleKeys.RegisterScreen_ID.tr()}',
                        picon: Icons.person,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        sicon: RegisterCubit.get(context).suffix,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        label: '${LocaleKeys.RegisterScreen_password.tr()}',
                        picon: Icons.lock_outline,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defalultButton(
                            function: () {
                              // navigatepush(context, const HomeScreen());
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  firstName: firstNameController.text,
                                  address: addressController.text,
                                  city: cityController.text,
                                  country: countryController.text,
                                  phoneNumber: phoneController.text,
                                  state: stateController.text,
                                  postcode: postCodeController.text,
                                  lastName: lastNameController.text,
                                  companyName: companyNameController.text,
                                  accountType: accountType,
                                  nationalId:nationalIdController.text,
                                );
                                // navigatepush(context,  LoginScreen());

                              }
                            },
                            text: '${LocaleKeys.RegisterScreen_button.tr()}',
                            isUpperCase: true),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: defaultColor,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
