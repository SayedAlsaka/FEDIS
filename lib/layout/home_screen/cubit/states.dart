import 'package:fedis/models/client_response_model.dart';


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
