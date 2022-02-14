import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/modules/login_screen/login_screen.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/network/local/cash_helper.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
 String? x ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {
      },

      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! HomeGetClientDataLoadingState,
            builder: (BuildContext context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${LocaleKeys.HomeScreen_welcome.tr()}, ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                          ),
                        ),
                        //here we add user name
                        Text(
                          HomeCubit.get(context)
                              .clientModel
                              .fullName
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            size: 30,
                          ),
                          onPressed: () {
                            CashHelper.removeDate(key: 'clientId');
                            navigateAndFinish(context, LoginScreen());
                          },
                        ),
                      ],
                    ),
                  if (context.locale.toString() == 'en')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        HomeCubit.get(context)
                            .clientModel
                            .lastLogin
                            .toString()
                            .split("<br>")
                            .first
                            .replaceRange(0, 5, '${LocaleKeys.HomeScreen_LastLogin.tr()}:',)
                            .replaceRange(22, 23, ' ${LocaleKeys.HomeScreen_at.tr()} ',),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  if(context.locale.toString() == 'ar')
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        HomeCubit.get(context)
                            .clientModel
                            .lastLogin
                            .toString()
                            .split("<br>")
                            .first
                            .replaceRange(0, 5, '${LocaleKeys.HomeScreen_LastLogin.tr()}:',)
                            .replaceRange(26, 27, ' ${LocaleKeys.HomeScreen_at.tr()} ',),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 2,

                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            'assets/images/file.png',
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${HomeCubit.get(context).clientModel.stats!.numPaidInvoices}',
                                            style: const TextStyle(
                                                fontSize: 60.0,
                                                color: Color.fromRGBO(
                                                    51, 122, 183, 1.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                     Text(LocaleKeys.HomeScreen_pInvoices.tr(),
                                        style: const TextStyle(
                                            fontSize: 25.0, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 2,

                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            'assets/images/file.png',
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 0),
                                      child: Row(
                                        children:[
                                          Text(
                                            '${HomeCubit.get(context).clientModel.stats!.numUnPaidInvoices}',
                                            style: const TextStyle(
                                                fontSize: 60.0,
                                                color: Color.fromRGBO(
                                                    51, 122, 183, 1.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                     Text(LocaleKeys.HomeScreen_unpInvoices.tr(),
                                        style: const TextStyle(
                                            fontSize: 25.0, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            'assets/images/cube.png',
                                            color: Colors.grey[500],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 0),
                                      child: Row(
                                        children:  [
                                          Text(
                                            '${HomeCubit.get(context).clientModel.stats!.productNumActive}',
                                            style: const TextStyle(
                                                fontSize: 60.0,
                                                color: Color.fromRGBO(
                                                    51, 122, 183, 1.0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                     Text(LocaleKeys.HomeScreen_producsActive.tr(),
                                        style: const TextStyle(
                                            fontSize: 25.0, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator(
              color: defaultColor,
            )),
          ),
        );
      },
    );
  }
}
