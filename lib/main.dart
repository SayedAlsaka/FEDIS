import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedis/modules/splash_screen/splash_screen.dart';
import 'package:fedis/shared/bloc_observer.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/styles/themes.dart';
import 'package:fedis/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/home_screen/cubit/cubit.dart';
import 'layout/home_screen/home_screen.dart';
import 'shared/network/local/cash_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  late Widget widget;
  await CashHelper.init();
  clientId = CashHelper.getData(key: 'clientId');
  print(clientId);
  if (clientId != null) {
    widget = HomeScreen();
  } else {
    widget = Splash();
  }
  runApp(EasyLocalization(
    path: 'assets/translations/',
    startLocale: Locale('ar'),
    assetLoader: CodegenLoader(),
    supportedLocales: [
     Locale('ar'),
      Locale('en'),
    ],
    fallbackLocale: Locale('ar'),
    child: MyApp(
      startWidget: widget,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => HomeCubit()..getData())
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
