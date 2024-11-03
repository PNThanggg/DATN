import '../model/bmi_model.dart';
import 'local_repository.dart';

class BmiUseCase {
  BmiUseCase._();

  static Future<void> saveBMI(BMIModel bmi) async => await LocalRepository.saveBMIModel(bmi);

  static List<BMIModel> getAll() => LocalRepository.getAllBMI();

  static List<BMIModel> filterBMI(int start, int end) => LocalRepository.filterBMI(start, end);

  static Future<void> updateBMI(BMIModel bmi) async => await LocalRepository.updateBMI(bmi);

  static Future<void> deleteBMI(String key) async => await LocalRepository.deleteBMI(key);
}
