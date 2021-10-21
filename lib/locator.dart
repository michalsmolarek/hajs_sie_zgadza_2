import 'package:get_it/get_it.dart';
import 'package:hajs_sie_zgadza_2/core/services/auth_service.dart';
import 'package:hajs_sie_zgadza_2/core/services/user_service.dart';
import 'package:hajs_sie_zgadza_2/core/services/wallet_service.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/user_view_model.dart';
import 'package:hajs_sie_zgadza_2/core/viewmodels/wallet_view_model.dart';

import 'core/services/operation_service.dart';
import 'core/viewmodels/operation_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => OperationService());
  locator.registerLazySingleton(() => WalletService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => AuthService.instance());
  locator.registerLazySingleton(() => OperationViewModel());
  locator.registerLazySingleton(() => UserViewModel());
  locator.registerLazySingleton(() => WalletViewModel());
}
