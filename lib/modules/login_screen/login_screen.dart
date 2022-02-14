import 'package:bot_toast/bot_toast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/home_screen.dart';
import 'package:fedis/modules/login_screen/cubit/states.dart';
import 'package:fedis/modules/register_screen/register_screen.dart';
import 'package:fedis/modules/reset_password/reset_password.dart';
import 'package:fedis/modules/splash_screen/splash_screen.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/network/local/cash_helper.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            currentLanguage = CashHelper.getData(key: 'Language');
            if( currentLanguage == 'en')
            {
              Fluttertoast.showToast(
                msg: 'Login ${state.loginModel!.result}full',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
            else if(currentLanguage == 'ar')
            {
              Fluttertoast.showToast(
                msg: 'تم تسجيل الدخول بنجاح',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }

            CashHelper.saveData(
                    key: 'clientId', value: state.loginModel!.userId)
                .then((value) {
              clientId = CashHelper.getData(key: 'clientId');
              HomeCubit.get(context).getData();
              navigateAndFinish(context, HomeScreen());
            });
          }
          if (state is LoginErrorState) {
            currentLanguage = CashHelper.getData(key: 'Language');
            if(currentLanguage == 'en')
            {
              Fluttertoast.showToast(
                msg: state.loginModel!.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
            else if(currentLanguage== 'ar')
            {
              Fluttertoast.showToast(
                msg: 'البريد الالكتروني او كلمة السر غير صحيحة',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }

          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                MaterialButton(
                  onPressed: () {
                   navigateAndFinish(context,const Splash());
                    formKey.currentState!.reset();
                     currentLanguage = CashHelper.getData(key: 'Language');
                    if (currentLanguage ==null)
                    {
                      CashHelper.saveData(key: 'Language', value: 'ar');
                    } else if (currentLanguage == 'ar'){
                       CashHelper.saveData(key: 'Language', value: 'en');
                       currentLanguage = CashHelper.getData(key: 'Language');

                    }else if(currentLanguage == 'en'){
                       CashHelper.saveData(key: 'Language', value: 'ar');
                      currentLanguage = CashHelper.getData(key: 'Language');
                    }
                    EasyLocalization.of(context)!.setLocale(Locale(currentLanguage!));

                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all() ,),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child:
                    Text(
                      LocaleKeys.LoginScreen_LangButton.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),
                    ),
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
                                return LocaleKeys.LoginScreen_emailValidate1.tr();
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
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.LoginScreen_passwordValidate.tr();
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
                            condition: state is! LoginLoadingState ,
                            builder: (context) => defalultButton(
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
                                  text: LocaleKeys.LoginScreen_ResetPassword.tr()),
                            ],
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                LocaleKeys.LoginScreen_NewAccount.tr(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              defaultTextButton(
                                  function: () {
                                    navigatePush(context, RegisterScreen());
                                    formKey.currentState!.reset();
                                    emailController.clear();
                                    passwordController.clear();
                                  },
                                  text: LocaleKeys.LoginScreen_RegisterNow.tr()),
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
