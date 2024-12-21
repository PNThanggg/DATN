import '../../data/local_repository.dart';
import '../model/blood_pressure_model.dart';

class BloodPressureUseCase {
  final LocalRepository _localRepository;

  const BloodPressureUseCase(this._localRepository);

  Future saveBloodPressure(
    BloodPressureModel bloodPressureModel,
  ) =>
      _localRepository.saveBloodPressure(bloodPressureModel);

  Future deleteBloodPressure(String key) => _localRepository.deleteBloodPressure(key);

  List<BloodPressureModel> filterBloodPressureDate(
    int start,
    int end,
  ) =>
      _localRepository.filterBloodPressureDate(
        start,
        end,
      );

  List<BloodPressureModel> getAll() => _localRepository.getAll();
}
