import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/modules/Invoices_screen/invoice_details_screen.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class ActiveServicesScreen extends StatelessWidget {
  const ActiveServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
      if(HomeCubit.get(context).totalActiveServices == null) {
        return Scaffold(
          appBar: AppBar(),
          body:const Center(child: CircularProgressIndicator(color: defaultColor,)),
        );
      }
      if(HomeCubit.get(context).totalActiveServices == 0) {
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! GetActiveServicesLoadingState,
            builder: (BuildContext context) =>
                Center(
                  child: Text(LocaleKeys.ActiveServices_noServiceText.tr()
                    ,style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),
                  ),
                ),
            fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                )),
          ),
        );
      }
      else
        {
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! GetActiveServicesLoadingState,
              builder: (BuildContext context) =>
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: (){},
                            child: Card(
                              elevation: 2,
                              child: Container(
                                height: 100,
                                color: Colors.grey[100],
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15 , right: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            HomeCubit.get(context).activeServiceModel.orders.order[index].lineitems.lineitem[0].product.split('- ').last.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          if(currentLanguage == 'en')
                                            Text(
                                              '${HomeCubit.get(context).activeServiceModel.orders.order[index].amount} EGP',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          if(currentLanguage == 'ar')
                                            Text(
                                              '${HomeCubit.get(context).activeServiceModel.orders.order[index].amount} ${HomeCubit.get(context).activeServiceModel.orders.order[index].currencysuffix}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          if(currentLanguage == 'en')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].status == 'Active')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check_circle_outline_outlined,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  Text(HomeCubit.get(context).activeServiceModel.orders.order[index].status),
                                                ],
                                              ),
                                          if(currentLanguage == 'en')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].status == 'Pending')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                  Text(HomeCubit.get(context).activeServiceModel.orders.order[index].status),
                                                ],
                                              ),
                                          if(currentLanguage == 'ar')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].status == 'Active')
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.check_circle_outline_outlined,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  Text('فعال'),
                                                ],
                                              ),
                                          if(currentLanguage == 'ar')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].status == 'Pending')
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                  Text('غير فعال'),
                                                ],
                                              ),

                                          if(currentLanguage == 'en')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].paymentstatus == 'Paid')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check_circle_outline_outlined,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  Text(HomeCubit.get(context).activeServiceModel.orders.order[index].paymentstatus),
                                                ],
                                              ),
                                          if(currentLanguage == 'en')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].paymentstatus == 'Unpaid')
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.redAccent,
                                                    size: 20,
                                                  ),
                                                  Text(HomeCubit.get(context).activeServiceModel.orders.order[index].paymentstatus),
                                                ],
                                              ),
                                          if(currentLanguage =='ar')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].paymentstatus == 'Paid')
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.check_circle_outline_outlined,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  Text('مدفوعة'),
                                                ],
                                              ),
                                          if(currentLanguage =='ar')
                                            if (HomeCubit.get(context).activeServiceModel.orders.order[index].paymentstatus == 'Unpaid')
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.redAccent,
                                                    size: 20,
                                                  ),
                                                  Text('غير مدفوعة'),
                                                ],
                                              ),

                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {

                                            navigatePush(context,     InvoiceDetailsScreen());
                                            HomeCubit.get(context).getInvoiceDetails(HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].invoiceID.toString());

                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(
                                                10.0),),
                                            child: Text(LocaleKeys.InvoiceScreen_viewInvoiceButton.tr()),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Alert(
                                              context: context,
                                              type: AlertType.warning,
                                              title: LocaleKeys.ActiveService_cancelButton.tr(),
                                              desc:LocaleKeys.CancelService_Alert.tr(),
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    LocaleKeys.CancelService_YesButton.tr(),
                                                    style: const TextStyle(color: Colors.white, fontSize: 20),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: defaultColor,
                                                ),
                                                DialogButton(
                                                  child: Text(
                                                    LocaleKeys.CancelService_NoButton.tr(),
                                                    style: const TextStyle(color: Colors.white, fontSize: 20),
                                                  ),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ).show();
                                          },
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(
                                                10.0), color: defaultColor),
                                            child: Center(
                                              child: Text(LocaleKeys.ActiveService_cancelButton.tr()
                                              ,style: const TextStyle(color: Colors.white),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount:
                      HomeCubit.get(context).totalActiveServices!),
              fallback: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                  )),
            ),
          );
        }
      },
    );
  }
}
