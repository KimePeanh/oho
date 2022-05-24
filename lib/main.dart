import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onecam/app_localiztion.dart';
import 'package:onecam/src/features/language/bloc/bloc/language_bloc.dart';
import 'package:onecam/src/features/language/bloc/bloc/language_event.dart';
import 'package:onecam/src/features/language/bloc/bloc/language_state.dart';
import 'package:onecam/src/features/splash/screen/splashscreen.dart';
import 'package:onecam/src/utils/app_con.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  systemOverlayStyle:
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Red,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LanguageBloc>(
              create: (BuildContext context) =>
                  LanguageBloc()..add(LanguageLoadStarted())),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: [Locale('en', 'US'), Locale('km', 'KH')],
              title: 'One Cam',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen(),
            );
          },
        ));
  }
}
