import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/modules/login_screen/cubit/cubit.dart';
import 'package:fedis/modules/login_screen/cubit/states.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Form(
                      key: formKey,
                      child: SizedBox(
                        width: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.ResetPassword_Lost.tr(),
                              style: const TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Container(
                                width: double.infinity,
                                height: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              LocaleKeys.LostPassword_text.tr(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                              controller: emailController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys.RegisterScreen_Validate
                                      .tr();
                                }
                              },
                              type: TextInputType.emailAddress,
                              label: LocaleKeys.LoginScreen_Email.tr(),
                              picon: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: defaultButton(
                                width: 100,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context)
                                        .resetPassword(emailController.text);
                                  }
                                },
                                text: LocaleKeys.LostPassword_button.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
