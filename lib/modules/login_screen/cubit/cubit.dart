import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fedis/models/login_response_model.dart';
import 'package:fedis/modules/login_screen/cubit/states.dart';
import 'package:fedis/shared/network/end_points.dart';
import 'package:fedis/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit():super(LoginInitialState()) ;
  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginResponseModel loginModel;

  void userLogin({required String email, required String password,}) async{
    emit(LoginLoadingState());

    var url = Uri.parse(URL);
    final response = await  http.post(Uri.parse(URL) , body: {
      'action': LOGIN,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'email': email,
      'password2': password,
      'responsetype':'json',
    }).then((value) {
      print(value.body);
      loginModel = LoginResponseModel.fromJson(json.decode(value.body));
      print(loginModel.result);
      if (loginModel.result == 'success')
        emit(LoginSuccessState(loginModel));
      else
        emit(LoginErrorState(loginModel));

    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error));
    });


  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ChangePasswordShowState());
  }
}