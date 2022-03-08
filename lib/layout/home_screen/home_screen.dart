import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/modules/Invoices_screen/paid_invoices_screen.dart';
import 'package:fedis/modules/Invoices_screen/unpaid_invoice_screen.dart';
import 'package:fedis/modules/client_data_edit/client_data_edit.dart';
import 'package:fedis/modules/login_screen/login_screen.dart';
import 'package:fedis/modules/services_screen/active_services_screen.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/network/local/cash_helper.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: state is! HomeGetClientDataLoadingState,
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: Text(
                '${LocaleKeys.HomeScreen_welcome.tr()}, ${HomeCubit.get(context).clientModel.firstName.toString()}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(LocaleKeys.HomeScreen_menuCustomerInfo.tr()),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(LocaleKeys.HomeScreen_PaymentMethods.tr()),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text(LocaleKeys.HomeScreen_PersonalFile.tr()),
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Text(LocaleKeys.HomeScreen_ChangePassword.tr()),
                    ),
                    PopupMenuItem(
                      value: 5,
                      child: Text(LocaleKeys.HomeScreen_SignOut.tr()),
                    ),
                  ],
                  onSelected: (int menu) {
                    if(menu ==1)
                      {
                        HomeCubit.get(context).getClientData();
                        navigatePush(context, ClientData());
                      }
                    if (menu == 5) {
                      CashHelper.removeDate(key: 'clientId');
                      navigateAndFinish(context, LoginScreen());
                    }
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name && LastLogin
                    if (currentLanguage == 'en')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          HomeCubit.get(context)
                              .clientModel
                              .lastLogin
                              .toString()
                              .split("<br>")
                              .first
                              .replaceRange(
                                0,
                                5,
                                '${LocaleKeys.HomeScreen_LastLogin.tr()}:',
                              )
                              .replaceRange(
                                22,
                                23,
                                ' ${LocaleKeys.HomeScreen_at.tr()} ',
                              ),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                    if (currentLanguage == 'ar')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          HomeCubit.get(context)
                              .clientModel
                              .lastLogin
                              .toString()
                              .split("<br>")
                              .first
                              .replaceRange(
                                0,
                                5,
                                '${LocaleKeys.HomeScreen_LastLogin.tr()}:',
                              )
                              .replaceRange(
                                26,
                                27,
                                ' ${LocaleKeys.HomeScreen_at.tr()} ',
                              ),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Paid Invoices
                    InkWell(
                      onTap: () {
                        navigatePush(context, const PaidInvoicesScreen());
                        HomeCubit.get(context).getAllPaidInvoices();
                      },
                      child: Card(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Icon(
                                              Icons.receipt_long_outlined,
                                              size: 40.0,
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
                                              fontSize: 25.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Unpaid Invoices
                    InkWell(
                      onTap: () {
                        navigatePush(context, const UnpaidInvoicesScreen());
                        HomeCubit.get(context).getAllUnpaidInvoices();
                      },
                      child: Card(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Icon(
                                              Icons.receipt_long_outlined,
                                              size: 40.0,
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
                                              '${HomeCubit.get(context).clientModel.stats!.numUnPaidInvoices}',
                                              style: const TextStyle(
                                                  fontSize: 60.0,
                                                  color: Color.fromRGBO(
                                                      51, 122, 183, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          LocaleKeys.HomeScreen_unpInvoices
                                              .tr(),
                                          style: const TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Active Services
                    InkWell(
                      onTap: () {
                        navigatePush(context, const ActiveServicesScreen());
                        HomeCubit.get(context).getAllUnpaidInvoices();
                        HomeCubit.get(context).getAllPaidInvoices();
                        HomeCubit.get(context).getActiveServices();
                      },
                      child: Card(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Icon(
                                              Icons.view_in_ar_outlined,
                                              size: 40.0,
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
                                              '${HomeCubit.get(context).clientModel.stats!.productNumActive}',
                                              style: const TextStyle(
                                                  fontSize: 60.0,
                                                  color: Color.fromRGBO(
                                                      51, 122, 183, 1.0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          LocaleKeys.HomeScreen_producsActive
                                              .tr(),
                                          style: const TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (BuildContext context) => Center(
            child: Scaffold(
              appBar: AppBar(),
              body: const Center(
                  child: CircularProgressIndicator(
                color: defaultColor,
              )),
            ),
          ),
        );
      },
    );
  }
}
