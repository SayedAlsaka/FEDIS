import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:fedis/layout/home_screen/cubit/states.dart';
import 'package:fedis/models/client_response_model.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/network/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  late ClientModel clientModel;
  void getData() async
  {
    emit(HomeGetClientDataLoadingState());
    var url = Uri.parse(URL);
    final response = await  http.post(Uri.parse(URL) , body: {
      'action': GETCLIENT,
      'username': username,
      'password': passwordA,
      'accesskey': passwordA,
      'clientid': '${clientId}',
      'responsetype':'json',
      'stats':'${true}',
    }).then((value) {
      print(value.body);
      clientModel = ClientModel.fromJson(json.decode(value.body));
      print(clientModel.result);
      print(clientModel.stats!.numPaidInvoices);

      if (clientModel.result == 'success')
        emit(HomeGetClientDataSuccessState(clientModel));
      else
        emit(HomeGetClientDataErrorState(clientModel));

    }).catchError((error){
      print(error.toString());
      emit(HomeGetClientDataErrorState(error));
    });
  }



}