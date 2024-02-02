import 'package:get_it/get_it.dart';
import 'package:pp_19/data/database/database_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    GetIt.I.registerSingletonAsync<DatabaseService>(() => DatabaseService().init());
    await GetIt.I.isReady<DatabaseService>();
  }
}
