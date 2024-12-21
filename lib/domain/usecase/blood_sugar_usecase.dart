import '../../data/local_repository.dart';
import '../model/blood_sugar_model.dart';

class BloodSugarUseCase {
  final LocalRepository repository;

  BloodSugarUseCase(this.repository);

  Future<void> saveBloodSugarData(BloodSugarModel model) => repository.saveBloodSugar(model);

  List<BloodSugarModel> getAllBloodSugar() => repository.getAllBloodSugar();

  List<BloodSugarModel> getAllBloodSugarByDate({required DateTime startDate, required DateTime endDate}) {
    return repository.getAllBloodSugarByDate(
      startDate: startDate.millisecondsSinceEpoch,
      endDate: endDate.millisecondsSinceEpoch,
    );
  }

  List<BloodSugarModel> getBloodSugarListByFilter({
    required DateTime startDate,
    required DateTime endDate,
    String? stateCode,
  }) =>
      repository.getBloodSugarListByFilter(
        startDate: startDate.millisecondsSinceEpoch,
        endDate: endDate.millisecondsSinceEpoch,
        stateCode: stateCode,
      );

  Future deleteBloodSugar(String key) => repository.deleteBloodSugar(key);
}
