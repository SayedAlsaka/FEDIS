

import 'package:fedis/models/register_response_model.dart';

abstract class RegisterStates {}


class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates
{
  final RegisterResponseModel? registerResponseModel;

  RegisterSuccessState(this.registerResponseModel);
}

class RegisterErrorState extends RegisterStates
{
  final RegisterResponseModel? registerResponseModel;

  RegisterErrorState(this.registerResponseModel);
}

class ChangePasswordShowState extends RegisterStates{}