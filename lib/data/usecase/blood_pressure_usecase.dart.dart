import '../model/blood_pressure_model.dart';
import 'local_repository.dart';

class BloodPressureUseCase {
  const BloodPressureUseCase._();

  static Future<void> saveBloodPressure(BloodPressureModel bloodPressureModel) async =>
      await LocalRepository.saveBloodPressure(bloodPressureModel);

  static Future<void> deleteBloodPressure(String key) async => await LocalRepository.deleteBloodPressure(key);

  static List<BloodPressureModel> filterBloodPressureDate(int start, int end) =>
      LocalRepository.filterBloodPressureDate(start, end);

  static List<BloodPressureModel> getAll() => LocalRepository.getAll();
}
