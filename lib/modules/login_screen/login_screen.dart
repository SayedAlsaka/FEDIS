import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/home_screen.dart';
import 'package:fedis/modules/login_screen/cubit/states.dart';
import 'package:fedis/modules/register_screen/register_screen.dart';
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
            print(state.loginModel!.userId);
            print(state.loginModel!.twoFactorEnabled);
            if(context.locale.toString() == 'en')
            {
              Fluttertoast.showToast(
                msg: 'Login ${state.loginModel!.result}full',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
            else if(context.locale.toString() == 'ar')
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
              navigateandFinish(context, HomeScreen());
            });
          }
          if (state is LoginErrorState) {

            if(context.locale.toString() == 'en')
            {
              Fluttertoast.showToast(
                msg: state.loginModel!.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
            else if(context.locale.toString() == 'ar')
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
                  onPressed: () async{
                    print(context.locale.toString());
                    if (context.locale.toString() == 'ar') {
                      await context.setLocale(Locale('en'));
                    }
                    else if (context.locale.toString() == 'en') {
                      await context.setLocale(Locale('ar'));
                    }


                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all() ,),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child:
                    Text(
                      '${LocaleKeys.LoginScreen_LangButton.tr()}',
                      style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              return 'please enter your email address';
                            }
                            if (value.length < 5 ||
                                !value.contains('@') ||
                                !value.endsWith('.com')) {
                              return 'please enter a valid email address';
                            }
                            return null;
                          },
                          label: '${LocaleKeys.LoginScreen_Email.tr()}',
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
                              return 'please enter your password';
                            }
                            return null;
                          },
                          label: '${LocaleKeys.LoginScreen_Password.tr()}',
                          picon: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defalultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: '${LocaleKeys.LoginScreen_LoginButton.tr()}',
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
                             Text(
                              '${LocaleKeys.LoginScreen_NewAccount.tr()}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            defaultTextButton(
                                function: () {
                                  navigatepush(context, RegisterScreen());
                                  emailController.clear();
                                  passwordController.clear();
                                },
                                text: '${LocaleKeys.LoginScreen_RegisterNow.tr()}'),
                          ],
                        ),
                      ],
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
