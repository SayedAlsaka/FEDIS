import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fedis/models/register_response_model.dart';
import 'package:fedis/modules/register_screen/cubit/states.dart';
import 'package:fedis/shared/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterResponseModel registerModel;


  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String address,
    required String city,
    required String state,
    required String postcode,
    required String country,
    required String phoneNumber,
    required String companyName,
    required String accountType,
    required String nationalId,
  }) async {

    emit(RegisterLoadingState());

    if (address.isEmpty) {
      address = " ";
    }
    if (city.isEmpty) {
      city = " ";
    }
    if (country.isEmpty) {
      country = " ";
    }
    if (postcode.isEmpty) {
      postcode = " ";
    }

    print(int.parse(nationalId));
    print(nationalId);
    print(accountType);
    var url = Uri.parse(URL);
    final response = await http.post(Uri.parse(URL), body: {
      'action': REGISTER,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'responsetype': 'json',
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'phonenumber': phoneNumber,
      'companyname': companyName,
      'address1': address,
      'country': country,
      'city': city,
      'state': state,
      'postcode': postcode,
      'password2': password,
      'customfields':' ',
      'customfield[8]':nationalId,
      'customfield[9]':accountType,
    }).then((value) {
      print(value.body);
     registerModel = RegisterResponseModel.fromJson(json.decode(value.body));
      print(registerModel.result);
      print(registerModel.clientId);
      if (registerModel.result == 'success') {
        emit(RegisterSuccessState(registerModel));
      } else {
        emit(RegisterErrorState(registerModel));
      }
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordShowState());
  }
}
