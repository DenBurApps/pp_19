import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pp_19/business/services/navigation/navigation_observer.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/business/services/navigation/routes.dart';
import 'package:pp_19/business/services/service_locator.dart';
import 'package:pp_19/firebase_options.dart';
import 'package:pp_19/presentation/themes/app_theme.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await _initApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, 
    DeviceOrientation.portraitDown, 
  ]);
  runApp(const WalleTadorSavingAPP());

}

Future<void> _initApp() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } on Exception catch (e) {
    log("Failed to initialize Firebase: $e");
  }

  await ServiceLocator.setup();
 
}

class WalleTadorSavingAPP extends StatelessWidget {
  const WalleTadorSavingAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olymp Trade WalleTad SavingAPP',
      debugShowCheckedModeBanner: false,
      routes: Routes.get(context),
      initialRoute: RouteNames.splash,
      theme: DefaultThemeGetter.get(),
      navigatorObservers: [
        CustomNavigatorObserver(),
      ],
    );
  }
}
