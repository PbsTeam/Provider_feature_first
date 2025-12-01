import 'package:feature_base/features/login/data/repository/login_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'common/widgets/app_storage.dart';
import 'core/api/network_service.dart';
import 'features/home/data/repository/hom_respository.dart';

GetIt getIt = GetIt.instance;

void serviceLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<AppStorage>(() => AppStorage());
  getIt.registerLazySingleton<NetworkApiService>(() => NetworkApiService());

  ///Login
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());


  ///Home
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());

}
