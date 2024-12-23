import 'package:get_it/get_it.dart';

import '../../data/local_repository.dart';
import '../../domain/usecase/alarm_usecase.dart';
import '../../domain/usecase/blood_pressure_usecase.dart';
import '../../domain/usecase/bmi_usecase.dart';
import '../config/hive_config/hive_config.dart';
import '../util/share_preference_utils.dart';

GetIt getIt = GetIt.instance;

void configDI() {
  _configCommonDI();
  _configDataDI();
  _configDomainDI();
}

void _configCommonDI() {
  getIt.registerSingleton(HiveConfig());
  getIt.registerSingleton(SharePreferenceUtils());
}

void _configDataDI() {
  getIt.registerSingleton(
    LocalRepository(
      getIt<HiveConfig>(),
      getIt<SharePreferenceUtils>(),
    ),
  );
}

void _configDomainDI() {
  getIt.registerFactory(
    () => BloodPressureUseCase(
      getIt<LocalRepository>(),
    ),
  );
  getIt.registerSingleton(
    AlarmUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerSingleton(
    BMIUseCase(
      getIt<LocalRepository>(),
    ),
  );
}
