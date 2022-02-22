import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceDetailsScreen extends StatelessWidget {
     InvoiceDetailsScreen({Key? key}) : super(key: key);
String? payMethod ;
var items = ['Bank/Cash','Offline Credit Card','fawry'];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (BuildContext context, state) {
        if (state is HomeGetInvoiceDetailsSuccessState)
          {
            if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[0]
            || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[0] ) {
              payMethod = 'Bank/Cash';
            }
             if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[1]
                || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[1] ) {
               payMethod ='Offline Credit Card';
              }
            if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[2]
                || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[2] ) {
              payMethod ='fawry';
            }
            print('$payMethod ${HomeCubit.get(context).invoiceDetails.paymentmethod}');
          }
      },
      builder: (BuildContext context, Object? state) {
       return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! HomeGetInvoiceDetailsLoadingState && state is! ChangePaymentMethodLoadingState,
            builder: (BuildContext context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fixed Egypt Logo
                    Image.asset('assets/images/Fedis-Logo.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    // Invoice number
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        '${LocaleKeys.Invoice_number.tr()} ${HomeCubit.get(context).invoiceDetails.invoicenum}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    // Invoice status
                    if (currentLanguage == 'en')
                      Container(
                      padding: const EdgeInsets.all(4),
                      alignment: AlignmentDirectional.topEnd,
                      child: Text(
                        HomeCubit.get(context).invoiceDetails.status,
                        style: TextStyle(
                            fontSize: 20,
                            backgroundColor: defaultColor.withOpacity(0.7),
                            color: Colors.white),
                      ),
                    ),
                    if(currentLanguage == 'ar' && HomeCubit.get(context).invoiceDetails.status == 'Unpaid')
                      Container(
                        padding: const EdgeInsets.all(4),
                        alignment: AlignmentDirectional.topEnd,
                        child: Text(
                          'مستحقة',
                          style: TextStyle(
                              fontSize: 20,
                              backgroundColor: defaultColor.withOpacity(0.7),
                              color: Colors.white),
                        ),
                      ),
                    if(currentLanguage == 'ar' && HomeCubit.get(context).invoiceDetails.status == 'Paid')
                      Container(
                        padding: const EdgeInsets.all(4),
                        alignment: AlignmentDirectional.topEnd,
                        child: Text(
                          'مدفوعة',
                          style: TextStyle(
                              fontSize: 20,
                              backgroundColor: defaultColor.withOpacity(0.7),
                              color: Colors.white),
                        ),
                      ),

                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 20,),
                     // Invoice Date
                     Container(alignment:AlignmentDirectional.center,child: Text('${LocaleKeys.Invoice_dueDate.tr()}: ${HomeCubit.get(context).invoiceDetails.duedate}')),
                    const SizedBox(height: 15,),
                  // Invoice Payment
                  if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[0]
                      || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[0] )
                    const Center(child: Text('Bank Name: Payee Name')),
                  if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[1]
                      || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[1] )
                    Center(
                      child: defalultButton(
                        width: 100,
                          isUpperCase: false,
                          function: (){},
                          text: LocaleKeys.Invoice_payNowButton.tr(),
                      ),
                    ),
                  if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[2]
                      || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[2] )
                    InkWell(child: Container(alignment:AlignmentDirectional.center,child: Image.asset('assets/images/Fawry-Logo.png'))),
                    const SizedBox(height: 20,),
                    // Invoice Account Bank
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.Invoice_BankAccount.tr(), style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
                        const SizedBox(height: 20,),
                        const Text('26 Ali Amin, Nasr City, Cairo, Egypt'),
                        const SizedBox(height: 5,),
                        const Text('VAT Number:582-019-834'),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // Invoice Pay to
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(LocaleKeys.Invoice_TO.tr(), style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
                        const SizedBox(height: 20,),
                        Text('${HomeCubit.get(context).clientModel.companyName}'),
                        Text('${HomeCubit.get(context).clientModel.fullName}'),
                        Text('${HomeCubit.get(context).clientModel.address},'),
                        Text('${HomeCubit.get(context).clientModel.city}, ${HomeCubit.get(context).clientModel.state},'),
                        Text('${HomeCubit.get(context).clientModel.countryName}'),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // Invoice Payment way
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(LocaleKeys.Invoice_paymentWay.tr() , style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
                        const SizedBox(height: 10,),
                        if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[0]
                            || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[0] )
                          DropdownButton(

                            // Initial Value
                            value: payMethod,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              payMethod = newValue!;
                              print(HomeCubit.get(context).invoiceDetails.invoiceid);
                              print(payMethod);
                              HomeCubit.get(context).changePaymentMethod(payMethod , HomeCubit.get(context).invoiceDetails.invoiceid.toString());
                            },
                          ),
                        if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[1]
                            || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[1] )
                          DropdownButton(

                            // Initial Value
                            value: payMethod,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              payMethod = newValue!;
                              HomeCubit.get(context).changePaymentMethod(payMethod , HomeCubit.get(context).invoiceDetails.invoiceid.toString());
                            },
                          ),
                        if(HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethods[2]
                            || HomeCubit.get(context).invoiceDetails.paymentmethod == HomeCubit.get(context).paymentMethodsDisplayName[2] )
                          DropdownButton(

                            // Initial Value
                            value: payMethod,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              payMethod = newValue!;
                              HomeCubit.get(context).changePaymentMethod(payMethod , HomeCubit.get(context).invoiceDetails.invoiceid.toString());
                            },
                          ),
                        const SizedBox(height: 30,),

                         Text(LocaleKeys.Invoice_date.tr() , style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
                        const SizedBox(height: 10,),
                        Text(HomeCubit.get(context).invoiceDetails.date),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(LocaleKeys.Invoice_Items.tr(), style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 20),),
                        const SizedBox(height: 20,),
                        Row(
                          children:  [
                          Text(LocaleKeys.Invoice_details.tr() , style: const TextStyle(color: Colors.grey ,fontWeight: FontWeight.bold),),
                          const Spacer(),
                          Text(LocaleKeys.Invoice_Amount.tr() , style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        ],),
                        const SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 20,),
                      if(HomeCubit.get(context).invoiceDetails.items.item[0].taxed ==1)
                        Row(
                          children: [
                            Expanded(
                              child: Text('${HomeCubit.get(context).invoiceDetails.items.item[0].description} *',
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text('${HomeCubit.get(context).invoiceDetails.items.item[0].amount} ${LocaleKeys.Invoice_Currency.tr()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      if(HomeCubit.get(context).invoiceDetails.items.item[0].taxed ==0)
                        Row(
                          children: [
                            Expanded(
                              child: Text(HomeCubit.get(context).invoiceDetails.items.item[0].description,
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text('${HomeCubit.get(context).invoiceDetails.items.item[0].amount} ${LocaleKeys.Invoice_Currency.tr()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                             Expanded(
                              child: Text(LocaleKeys.Invoice_subTotal.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text('${HomeCubit.get(context).invoiceDetails.subtotal} ${LocaleKeys.Invoice_Currency.tr()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Expanded(
                              child: Text('14.00% VAT',
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text('${HomeCubit.get(context).invoiceDetails.tax} ${LocaleKeys.Invoice_Currency.tr()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                             Expanded(
                              child: Text(LocaleKeys.Invoice_Credit.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text('${HomeCubit.get(context).invoiceDetails.credit} ${LocaleKeys.Invoice_Currency.tr()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          color: Colors.blue.withOpacity(0.1),
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                               Expanded(
                                child: Text(LocaleKeys.Invoice_total.tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Text('${HomeCubit.get(context).invoiceDetails.total} ${LocaleKeys.Invoice_Currency.tr()}',
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(LocaleKeys.Invoice_tax.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          color: Colors.blue.withOpacity(0.1),
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                               Expanded(
                                child: Text(LocaleKeys.Invoice_totalDue.tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              Text('${HomeCubit.get(context).invoiceDetails.total} ${LocaleKeys.Invoice_Currency.tr()}',
                                style: const TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Center(
                          child: MaterialButton(
                            onPressed: (){
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(border: Border.all(color: defaultColor)),
                                child:  Text(LocaleKeys.Invoice_download.tr(), style: const TextStyle(color: defaultColor),)),
                          ),
                        ),

                      ],
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
