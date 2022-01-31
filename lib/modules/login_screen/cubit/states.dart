import 'package:fedis/models/login_response_model.dart';

abstract class LoginStates {}


class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates
{
  final LoginResponseModel? loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates
{
  final  LoginResponseModel? loginModel;

  LoginErrorState(this.loginModel);
}

class ChangePasswordShowState extends LoginStates{}