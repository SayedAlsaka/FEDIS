import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/models/active_services_model.dart';
import 'package:fedis/models/client_response_model.dart';
import 'package:fedis/models/invoice_details_model.dart';
import 'package:fedis/models/invoices_response_model.dart';
import 'package:fedis/models/noactive_service_model.dart';
import 'package:fedis/models/noinvoices_response_model.dart';
import 'package:fedis/models/payment_methods.dart';
import 'package:fedis/models/update_payment_method.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/network/end_points.dart';
import 'package:fedis/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
   late ClientModel clientModel;
  late InvoicesModel paidInvoicesModel;
  late InvoicesModel unpaidInvoicesModel;
  late NoInvoicesModel noPaidInvoicesModel;
  late NoInvoicesModel noUnPaidInvoicesModel;
  late InvoiceDetails invoiceDetails;
  late PaymentModel paymentModel;
  late ActiveServiceModel activeServiceModel;
  late NoActiveServiceModel noActiveServiceModel;
  late ChangePaymentModel changePaymentModel;
  int? totalInvoices;
  int? totalActiveServices;
  bool allowWriteFile=false;
  var paymentMethods = [];
  var paymentMethodsDisplayName = [];

void getClientData() async
  {
    emit(HomeGetClientDataLoadingState());
    var url = Uri.parse(URL);
    final response = await  http.post(Uri.parse(URL) , body: {
      'action': GETCLIENT,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'clientid': '$clientId',
      'responsetype':'json',
      'stats':'${true}',
    }).then((value) {
      clientModel = ClientModel.fromJson(json.decode(value.body));
      print(clientModel.result);
      if (clientModel.result == 'success') {
        emit(HomeGetClientDataSuccessState(clientModel));
        getPaymentMethod();
      } else {
        emit(HomeGetClientDataErrorState(clientModel));
      }

    }).catchError((error){
      print(error.toString());
      emit(HomeGetClientDataErrorState(error));
    });
  }

Future openFile({required String url, String? fileName}) async{

  final file = await downloadFile(url, fileName!);
  if(file ==null) return;
  print('path: ${file.path}');
  OpenFile.open(file.path);
}
Future<File?> downloadFile(String url , String name) async {

  final appStorage= await getApplicationDocumentsDirectory();
  final file= File('${appStorage.path}/$name');
  try {
    final response = await DioHelper.dio.download(
        url,
        file
    );

    // final raf = file.openSync(mode: FileMode.WRITE);
    // raf.writeFromSync(response.data);
    // await raf.close();
    //
    // return file;
  } catch(e){
    return null;
  }
}
void getAllUnpaidInvoices() async
  {
    emit(HomeGetUnpaidInvoicesLoadingState());
    var url = Uri.parse(URL);
    final response = await  http.post(Uri.parse(URL) , body: {
      'action': GETINVOICES,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'userid':'$clientId',
      'status':'Unpaid',
      'responsetype':'json',
    }).then((value) {
      if (value.body.toString().indexOf('0').compareTo(35) ==0)
        {
          totalInvoices = 0;
          print(value.body);
          print('no invoices');
          noUnPaidInvoicesModel = NoInvoicesModel.fromJson(json.decode(value.body));
          print(noUnPaidInvoicesModel.result);
          if (noUnPaidInvoicesModel.result == 'success') {
            emit(HomeGetUnpaidInvoicesSuccessState());
          } else {
            emit(HomeGetUnpaidInvoicesErrorState());
          }
        }
      else
      {
        print('invoice');
        unpaidInvoicesModel = InvoicesModel.fromJson(json.decode(value.body));
        print(unpaidInvoicesModel.result.toString());
        totalInvoices = unpaidInvoicesModel.totalInvoices;
        if (unpaidInvoicesModel.result == 'success') {
          emit(HomeGetUnpaidInvoicesSuccessState());
        } else {
          emit(HomeGetUnpaidInvoicesErrorState());
        }
      }

    }).catchError((error){
      print(error.toString());
      emit(HomeGetUnpaidInvoicesErrorState());
    });
  }

void getAllPaidInvoices () async
{

  emit(HomeGetPaidInvoicesLoadingState());
  var url = Uri.parse(URL);
  final response = await  http.post(Uri.parse(URL) , body: {
    'action': GETINVOICES,
    'username': username,
    'password': passwordA,
    'accesskey': passwordA,
    'userid':'$clientId',
    'status':'Paid',
    'responsetype':'json',
  }).then((value) {
    if (value.body.toString().indexOf('0').compareTo(35) ==0) // check if invoices founded or not
      {
        totalInvoices = 0;
        print(value.body);
        print('no invoices');
        noPaidInvoicesModel = NoInvoicesModel.fromJson(json.decode(value.body));
        print(noPaidInvoicesModel.result);
        if (noPaidInvoicesModel.result == 'success') {
          emit(HomeGetPaidInvoicesSuccessState());
        } else {
          emit(HomeGetPaidInvoicesErrorState());
        }
      }
    else
      {
        print(value.body);
        print('invoice');
        paidInvoicesModel = InvoicesModel.fromJson(json.decode(value.body));
        print(paidInvoicesModel.result.toString());
        totalInvoices = paidInvoicesModel.totalInvoices;
        if (paidInvoicesModel.result == 'success') {
          emit(HomeGetPaidInvoicesSuccessState());
        } else {
          emit(HomeGetPaidInvoicesErrorState());
        }
      }



  }).catchError((error){
    print(error.toString());
    emit(HomeGetPaidInvoicesErrorState());
  });
}

void getInvoiceDetails (invoiceID) async
{
  emit(HomeGetInvoiceDetailsLoadingState());
  var url = Uri.parse(URL);
  final response = await  http.post(Uri.parse(URL) , body: {
    'action': GETINVOICEDETAILS,
    'username': username,
    'password': passwordA,
    'accesskey': passwordA,
    'invoiceid':invoiceID,
    'responsetype':'json',
  }).then((value) {

    invoiceDetails = InvoiceDetails.fromJson(json.decode(value.body));
    print(invoiceDetails.result);
    print(invoiceDetails.status);
    if (invoiceDetails.result == 'success') {
      emit(HomeGetInvoiceDetailsSuccessState());
    } else {
      emit(HomeGetInvoiceDetailsErrorState());
    }

  }).catchError((error){
    print(error.toString());
    emit(HomeGetInvoiceDetailsErrorState());
  });
}

void getPaymentMethod() async
{
  emit(GetPaymentMethodLoadingState());
  var url = Uri.parse(URL);
  final response = await  http.post(Uri.parse(URL) , body: {
    'action': GETPAYMENTMETHODS,
    'username': username,
    'password': passwordA,
    'accesskey': passwordA,
    'responsetype':'json',
  }).then((value) {
    paymentModel = PaymentModel.fromJson(json.decode(value.body));
    print(paymentModel.result);
    for(int i=0; i<paymentModel.totalresults; i++)
      {
        paymentMethods.add(paymentModel.paymentmethods.paymentmethod[i].module);
        paymentMethodsDisplayName.add(paymentModel.paymentmethods.paymentmethod[i].displayname);
      }
    if (paymentModel.result == 'success')
      {
        emit(GetPaymentMethodSuccessState());
      }
    else
      {
        emit(GetPaymentMethodErrorState());
      }



  }).catchError((error){
    print(error.toString());
emit(GetPaymentMethodErrorState());
  });
}

void getActiveServices() async
  {
    emit(GetActiveServicesLoadingState());
    var url = Uri.parse(URL);
     final response = await  http.post(Uri.parse(URL) , body: {
      'action': GETACTIVESERVICES,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'responsetype':'json',
      'userid':'$clientId',
      'status':'Active',
    }).then((value) {
      print(value.body);
     if (value.body.toString().indexOf('0').compareTo(35) ==0)
       {
         noActiveServiceModel = NoActiveServiceModel.fromJson(json.decode(value.body));
         if (noActiveServiceModel.result == 'success') {
           totalActiveServices = noActiveServiceModel.totalresults;
           emit(GetActiveServicesSuccessState());
         }
         else
         {
           emit(GetActiveServicesErrorState());
         }
       }
     else
       {
         activeServiceModel = ActiveServiceModel.fromJson(json.decode(value.body));
         if (activeServiceModel.result == 'success') {
           totalActiveServices = activeServiceModel.totalresults;
           emit(GetActiveServicesSuccessState());
         }
         else
         {
           emit(GetActiveServicesErrorState());
         }
       }

    }).catchError((error){
      print(error.toString());
      emit(GetActiveServicesErrorState());
    });
  }

  void changePaymentMethod(payMethod,invoiceID) async
  {

    emit(ChangePaymentMethodLoadingState());
    var url = Uri.parse(URL);
    final response = await  http.post(Uri.parse(URL) , body: {
      'action': CHANGEPAYMENTMETHOD,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'responsetype':'json',
      'paymentmethod':payMethod,
      'invoiceid':invoiceID,
    }).then((value) {
      changePaymentModel = ChangePaymentModel.fromJson(json.decode(value.body));
      print(changePaymentModel.result);
      print(changePaymentModel.invoiceID);
      if (changePaymentModel.result == 'success')
      {
        emit(ChangePaymentMethodSuccessState());
        getInvoiceDetails(changePaymentModel.invoiceID.toString());
      }
      else
      {
        emit(ChangePaymentMethodErrorState());
      }


    }).catchError((error){
      print(error.toString());
      emit(ChangePaymentMethodErrorState());
    });
  }



}