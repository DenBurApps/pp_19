import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/database/database_keys.dart';
import 'package:pp_19/data/database/database_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _databaseService = GetIt.instance<DatabaseService>();

  void _init() async {
    Timer(const Duration(seconds: 1), _navigate);
  }

  void _navigate() {
    final seenOnboarding = _databaseService.get(DatabaseKeys.seenOnboarding) ?? false;
    Navigator.of(context)
        .pushReplacementNamed(!seenOnboarding ? RouteNames.onboarding : RouteNames.main); //! поставить не забыть
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
