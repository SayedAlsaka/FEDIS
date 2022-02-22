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
class UnpaidInvoicesScreen extends StatelessWidget {
  const UnpaidInvoicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {
      },
      builder: (BuildContext context, Object? state) {
        if (HomeCubit.get(context).totalInvoices ==0 ) {
          return Scaffold(
          appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! HomeGetUnpaidInvoicesLoadingState,
              builder: (BuildContext context) =>
                  Center(
                    child: Text(LocaleKeys.InvoiceScreen_noInvoiceText.tr()
                      ,style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
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
                condition: state is! HomeGetUnpaidInvoicesLoadingState,
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
                                  height: 70,
                                  color: Colors.grey[100],
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15 , right: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if(currentLanguage == 'en')
                                              Text(
                                                '${HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].total!} ${HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].currencyCode!}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            if(currentLanguage == 'ar')
                                              Text(
                                                '${HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].total!} ${HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].currencySuffix!}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            if(currentLanguage == 'en')
                                              if (HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].status == 'Paid')
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.check_circle_outline_outlined,
                                                      color: Colors.green,
                                                      size: 20,
                                                    ),
                                                    Text(HomeCubit.get(context)
                                                        .unpaidInvoicesModel
                                                        .invoicesListModel!
                                                        .invoice![index]
                                                        .status!),
                                                  ],
                                                ),
                                            if(currentLanguage == 'en')
                                              if (HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].status == 'Unpaid')
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.indeterminate_check_box_outlined,
                                                      color: Colors.redAccent,
                                                      size: 20,
                                                    ),
                                                    Text(HomeCubit.get(context)
                                                        .unpaidInvoicesModel
                                                        .invoicesListModel!
                                                        .invoice![index]
                                                        .status!),
                                                  ],
                                                ),
                                            if(currentLanguage =='ar')
                                              if (HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].status == 'Paid')
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
                                              if (HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].status == 'Unpaid')
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.indeterminate_check_box_outlined,
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
                                      MaterialButton(
                                        onPressed: () {
                                          navigatePush(context,  InvoiceDetailsScreen());
                     HomeCubit.get(context).getInvoiceDetails(HomeCubit.get(context).unpaidInvoicesModel.invoicesListModel!.invoice![index].invoiceID.toString());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                          child: Text(LocaleKeys.InvoiceScreen_viewInvoiceButton.tr()),
                                        ),
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
                        HomeCubit.get(context).unpaidInvoicesModel.totalInvoices!.toInt()),
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
