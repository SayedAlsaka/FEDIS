import 'package:fedis/models/login_response_model.dart';
import 'package:fedis/models/reset_response_model.dart';

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
class ResetLoadingPassword extends LoginStates{}

class ResetPasswordSuccess extends LoginStates{
  final ResetResponseModel? resetModel;

  ResetPasswordSuccess(this.resetModel);
}

class ResetPasswordError extends LoginStates{
  final ResetResponseModel? resetModel;

  ResetPasswordError(this.resetModel);
}

class ChangeLoadingLanguage extends LoginStates{}

class ChangeLanguageSuccess extends LoginStates{}

class ChangeLanguageError extends LoginStates{}
