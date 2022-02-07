import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fedis/modules/splash_screen/splash_screen.dart';
import 'package:fedis/shared/bloc_observer.dart';
import 'package:fedis/shared/components/components.dart';
import 'package:fedis/shared/components/constants.dart';
import 'package:fedis/shared/styles/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  HttpOverrides.global = new MyHttpOverrides();
  runApp(localizedApp(widget));
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
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
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          EasyLocalization.of(context)!.delegate,
        ],
        locale: EasyLocalization.of(context)!.locale,
        localeListResolutionCallback: (locale,supportedLocales){
          if (locale == null)
            {
              EasyLocalization.of(context)!.setLocale(supportedLocales.first);
              Intl.defaultLocale='${supportedLocales.first}';
              return supportedLocales.first;
            }
        },
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
