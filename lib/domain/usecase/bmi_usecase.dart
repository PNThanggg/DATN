import '../../data/local_repository.dart';
import '../model/bmi_model.dart';

class BMIUseCase {
  final LocalRepository _localRepository;

  BMIUseCase(this._localRepository);

  Future saveBMI(BMIModel bmi) => _localRepository.saveBMIModel(bmi);

  List<BMIModel> getAll() => _localRepository.getAllBMI();

  List<BMIModel> filterBMI(int start, int end) => _localRepository.filterBMI(start, end);

  Future<bool> setWeightUnitId(int id) => _localRepository.setWeightUnitId(id);

  int? getWeightUnitId() => _localRepository.getWeightUnitId();

  Future<bool> setHeightUnitId(int id) => _localRepository.setHeightUnitId(id);

  int? getHeightUnitId() => _localRepository.getHeightUnitId();

  Future updateBMI(BMIModel bmi) => _localRepository.updateBMI(bmi);

  Future deleteBMI(String key) => _localRepository.deleteBMI(key);
}
