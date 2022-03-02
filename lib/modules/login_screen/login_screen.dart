import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/home_screen.dart';
import 'package:fedis/modules/login_screen/cubit/states.dart';
import 'package:fedis/modules/register_screen/register_screen.dart';
import 'package:fedis/modules/reset_password/reset_password.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/network/local/cash_helper.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..toggleSwitch(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            currentLanguage = CashHelper.getData(key: 'Language');
            if (currentLanguage == 'en') {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBar(
                      msg: 'Login ${state.loginModel!.result}full',
                      state: ToastStates.SUCCESS)
              );
            } else if (currentLanguage == 'ar') {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBar(
                      msg: 'تم تسجيل الدخول بنجاح',
                      state: ToastStates.SUCCESS)
              );
            }

            CashHelper.saveData(
                    key: 'clientId', value: state.loginModel!.userId)
                .then((value) {
              clientId = CashHelper.getData(key: 'clientId');
              HomeCubit.get(context).getClientData();
              navigateAndFinish(context, const HomeScreen());
            });
          }
          if (state is LoginErrorState) {
            if (currentLanguage == 'en') {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBar(
                      msg: state.loginModel!.message.toString(),
                      state: ToastStates.ERROR)
              );
            } else if (currentLanguage == 'ar') {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBar(
                    msg: 'البريد الالكتروني او كلمة السر غير صحيحة',
                    state: ToastStates.ERROR)
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20 , right: 20),
                  child: FlutterSwitch(
                    width: 100,
                    height: 50,
                    valueFontSize: 20,
                    toggleSize: 25,
                    activeText: 'EN',
                    activeColor: Colors.grey.shade400,
                    inactiveColor: Colors.grey.shade400,
                    inactiveTextColor: Colors.white,
                    activeTextColor: Colors.white,
                    inactiveText: 'ع',
                    padding: 14,
                    value: LoginCubit.get(context).isSwitched!,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (value) {

                       formKey.currentState!.reset();
                       currentLanguage = CashHelper.getData(key: 'Language');
                       if (currentLanguage == null) {
                         CashHelper.saveData(key: 'Language', value: 'ar');
                       } else if (currentLanguage == 'ar') {
                         CashHelper.saveData(key: 'Language', value: 'en');
                         currentLanguage = CashHelper.getData(key: 'Language');
                       } else if (currentLanguage == 'en') {
                         CashHelper.saveData(key: 'Language', value: 'ar');
                         currentLanguage = CashHelper.getData(key: 'Language');
                       }
                       EasyLocalization.of(context)!
                           .setLocale(Locale(currentLanguage!));
                       LoginCubit.get(context).toggleSwitch();
                    },
                  ),
                ),
            ],
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SizedBox(
                      width: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Fedis-Logo.png'),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.LoginScreen_emailValidate1
                                    .tr();
                              }
                              if (value.length < 5 ||
                                  !value.contains('@') ||
                                  !value.contains('.com')) {
                                return 'please enter a valid email address';
                              }
                              return null;
                            },
                            label: LocaleKeys.LoginScreen_Email.tr(),
                            picon: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            sicon: LoginCubit.get(context).suffix,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.LoginScreen_passwordValidate
                                    .tr();
                              }
                              return null;
                            },
                            label: LocaleKeys.LoginScreen_Password.tr(),
                            picon: Icons.lock_outline,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: LocaleKeys.LoginScreen_LoginButton.tr(),
                                isUpperCase: true),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: defaultColor,
                            )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultTextButton(
                                  function: () {
                                    navigatePush(context, ResetPassword());
                                  },
                                  text: LocaleKeys.LoginScreen_ResetPassword
                                      .tr()),
                            ],
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.LoginScreen_NewAccount.tr(),
                                style:  TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                              defaultTextButton(
                                  function: () {
                                    navigatePush(context, RegisterScreen());
                                    formKey.currentState!.reset();
                                    emailController.clear();
                                    passwordController.clear();
                                  },
                                  text:
                                      LocaleKeys.LoginScreen_RegisterNow.tr()),
                            ],
                          ),
                        ],
                      ),
                    ),
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
