import 'package:flutter/material.dart';
import 'package:pp_19/business/services/navigation/navigation_observer.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/business/services/navigation/routes.dart';
import 'package:pp_19/business/services/service_locator.dart';
import 'package:pp_19/presentation/themes/app_theme.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await _initApp();
  runApp(const SportQuiz());

}

Future<void> _initApp() async {
  await ServiceLocator.setup();
}

class SportQuiz extends StatelessWidget {
  const SportQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports for 365 types of news',
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
