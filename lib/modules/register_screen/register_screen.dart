import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/modules/login_screen/login_screen.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:country_picker/country_picker.dart';
import '../../shared/network/local/cash_helper.dart';
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
  var items = ['حساب فرد', 'حساب شركة'];
  var account = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
          if (state is SelectCountryState)
            {
              countryController.text = RegisterCubit.get(context).countryName!;
            }
          if (state is RegisterSuccessState)
            {
              currentLanguage = CashHelper.getData(key: 'Language');
              if (currentLanguage == 'en') {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                        msg: 'Register ${state.registerResponseModel!.result}fully',
                        state: ToastStates.SUCCESS)
                );
              } else if (currentLanguage == 'ar') {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                        msg: 'تم التسجيل بنجاح',
                        state: ToastStates.SUCCESS)
                );
              }
              navigateAndFinish(context,  LoginScreen());
            }
          if (state is RegisterErrorState)
            {
              currentLanguage = CashHelper.getData(key: 'Language');
              if (currentLanguage == 'en') {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                        msg: state.registerResponseModel!.message.toString(),
                        state: ToastStates.ERROR)
                );
              } else if (currentLanguage == 'ar') {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBar(
                        msg: 'يوجد مستخدم بالفعل بعنوان البريد الإلكتروني هذا',
                        state: ToastStates.ERROR)
                );
              }
            }
        },
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
                        LocaleKeys.RegisterScreen_title.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        LocaleKeys.RegisterScreen_title1.tr(),
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
                                  return LocaleKeys.RegisterScreen_Validate
                                      .tr();
                                }
                                return null;
                              },
                              label: LocaleKeys.RegisterScreen_Fname.tr(),
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
                                  return LocaleKeys.RegisterScreen_Validate
                                      .tr();
                                }
                                return null;
                              },
                              label: LocaleKeys.RegisterScreen_Lname.tr(),
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
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          if (value.length < 5 ||
                              !value.contains('@') ||
                              !value.contains('.com')) {
                            return 'please enter a valid email address';
                          }
                          return null;
                        },
                        label: LocaleKeys.RegisterScreen_Email.tr(),
                        picon: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      IntlPhoneField(
                        cursorColor: Colors.black,
                        controller: phoneController,
                        autovalidateMode: AutovalidateMode.disabled,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          return null;
                        },
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: LocaleKeys.RegisterScreen_mobile.tr(),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusColor: Colors.red,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          //  border: OutlineInputBorder(),
                          labelStyle: const TextStyle(color: Colors.black),
                        ),
                        initialCountryCode: 'EG',
                      ),
                      // const SizedBox(height: 15,),
                      defaultFormField(
                        controller: companyNameController,
                        type: TextInputType.text,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: null,
                        label: LocaleKeys.RegisterScreen_company.tr(),
                        picon: Icons.business,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: countryController,
                          type: TextInputType.text,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.RegisterScreen_Validate.tr();
                            }
                            return null;
                          },
                          label: LocaleKeys.RegisterScreen_country.tr(),
                          picon: Icons.location_city,
                          sicon: Icons.arrow_drop_down,
                          suffixPressed: (){
                            RegisterCubit.get(context).showCountryList(context);
                          }

                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: addressController,
                        type: TextInputType.text,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          return null;
                        },
                        label: LocaleKeys.RegisterScreen_Street.tr(),
                        picon: Icons.location_on,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //city - postCode
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 235,
                            child: defaultFormField(
                              controller: cityController,
                              type: TextInputType.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys.RegisterScreen_Validate
                                      .tr();
                                }
                                return null;
                              },
                              label: LocaleKeys.RegisterScreen_city.tr(),
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
                              lab: Text(LocaleKeys.RegisterScreen_postcode.tr(),
                                  style: const TextStyle(
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
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          return null;
                        },
                        label: LocaleKeys.RegisterScreen_state.tr(),
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
                          const Spacer(),
                          Text(
                            LocaleKeys.RegisterScreen_addinfo.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            width: 100,
                            height: 1.0,
                            color: defaultColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          focusColor: Colors.red,
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
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
                        validator: (account) {
                          if (account == null) {
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          return null;
                        },
                        hint: Text(
                          LocaleKeys.RegisterScreen_account.tr(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        iconEnabledColor: Colors.black,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            child: Text(items),
                            value: items,
                          );
                        }).toList(),
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (newValue) {
                          accountType = newValue.toString();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                        controller: nationalIdController,
                        type: TextInputType.number,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          if (value.length < 14) {
                            return LocaleKeys.RegisterScreen_nationalIDValidate
                                .tr();
                          }
                          return null;
                        },
                        label: LocaleKeys.RegisterScreen_ID.tr(),
                        picon: Icons.person,
                      ),
                      const SizedBox(
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
                            return LocaleKeys.RegisterScreen_Validate.tr();
                          }
                          return null;
                        },
                        label: LocaleKeys.RegisterScreen_password.tr(),
                        picon: Icons.lock_outline,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
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
                                  nationalId: nationalIdController.text,
                                );
                                // navigateAndFinish(context, LoginScreen());
                              }
                            },
                            text: LocaleKeys.RegisterScreen_button.tr(),
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
