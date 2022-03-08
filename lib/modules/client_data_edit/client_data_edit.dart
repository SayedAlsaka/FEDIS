import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedis/layout/home_screen/cubit/cubit.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/styles/color.dart';
import 'package:fedis/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientData extends StatelessWidget {
  ClientData({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var stateController = TextEditingController();
  var postCodeController = TextEditingController();
  var vatNumberController = TextEditingController();
  var accountTypeController = TextEditingController();

  String? payMethod;
  var items = ['Bank/Cash', 'Offline Credit Card', 'fawry'];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {
        stateController.text = HomeCubit.get(context).clientModel.state!;
        postCodeController.text = HomeCubit.get(context).clientModel.postCode!;
        vatNumberController.text = HomeCubit.get(context).clientModel.vatNumber!;
        accountTypeController.text = HomeCubit.get(context).clientModel.accountType!;
      },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: state is! HomeGetClientDataLoadingState &&
              state is! UpdateClientLoadingState,
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey.shade200,
              ),
              title: Text(LocaleKeys.customerData_title.tr()),
              backgroundColor: Colors.grey.shade200,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.customerData_fname.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.firstName}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_lname.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.lastName}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_companyName.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.companyName}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_email.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.email}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_address.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.address}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_city.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.city}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_state.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        //initialValue:'${HomeCubit.get(context).clientModel.state}',
                        controller: stateController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_postCode.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: postCodeController,
                        // initialValue:
                        //     '${HomeCubit.get(context).clientModel.postCode}',
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_country.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.countryName}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_mobileNumber.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.mobileNumber}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_defaultGateway.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText:
                                '${HomeCubit.get(context).clientModel.defaultPayment}',
                            labelStyle: const TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_vatNumber.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: vatNumberController,
                        // initialValue:
                        //     '${HomeCubit.get(context).clientModel.vatNumber}',
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        LocaleKeys.customerData_accountType.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: accountTypeController,
                        // initialValue:
                        //     '${HomeCubit.get(context).clientModel.accountType}',
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: defaultColor, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultButton(
                          function: () {
                            HomeCubit.get(context).updateClient(
                                state: stateController.text,
                                postCode: postCodeController.text,
                                vatNumber: vatNumberController.text,
                                accountType: accountTypeController.text);
                          },
                          text: LocaleKeys.customerData_saveChanges.tr()),
                    ],
                  ),
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
