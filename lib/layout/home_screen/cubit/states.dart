import 'package:fedis/models/client_response_model.dart';
import 'package:fedis/models/invoices_response_model.dart';

abstract class HomeStates {}


class HomeInitialState extends HomeStates{}

class HomeGetClientDataLoadingState extends HomeStates{}

class HomeGetClientDataSuccessState extends HomeStates
{
  final ClientModel? clientModel;

  HomeGetClientDataSuccessState(this.clientModel);
}

class HomeGetClientDataErrorState extends HomeStates
{
  final  ClientModel? clientModel;

  HomeGetClientDataErrorState(this.clientModel);
}

class HomeGetUnpaidInvoicesLoadingState extends HomeStates{}

class HomeGetUnpaidInvoicesSuccessState extends HomeStates {}

class HomeGetUnpaidInvoicesErrorState extends HomeStates {}

class HomeGetPaidInvoicesLoadingState extends HomeStates{}

class HomeGetPaidInvoicesSuccessState extends HomeStates {}

class HomeGetPaidInvoicesErrorState extends HomeStates {}

class HomeGetInvoiceDetailsLoadingState extends HomeStates{}

class HomeGetInvoiceDetailsSuccessState extends HomeStates {}

class HomeGetInvoiceDetailsErrorState extends HomeStates {}

class GetPaymentMethodLoadingState extends HomeStates{}

class GetPaymentMethodSuccessState extends HomeStates {}

class GetPaymentMethodErrorState extends HomeStates {}

class GetActiveServicesLoadingState extends HomeStates{}

class GetActiveServicesSuccessState extends HomeStates {}

class GetActiveServicesErrorState extends HomeStates {}

class ChangePaymentMethodLoadingState extends HomeStates{}

class ChangePaymentMethodSuccessState extends HomeStates {}

class ChangePaymentMethodErrorState extends HomeStates {}