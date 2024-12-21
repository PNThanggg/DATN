import 'package:hive/hive.dart';

import '../../common/config/hive_config/hive_constants.dart';

part 'blood_sugar_model.g.dart';

@HiveType(typeId: HiveTypeConstants.bloodSugar)
class BloodSugarModel extends HiveObject {
  @override
  @HiveField(0)
  String? key;
  @HiveField(1)
  String? stateCode;
  @HiveField(2)
  double? measure;
  @HiveField(3)
  String? unit;
  @HiveField(4)
  String? infoCode;
  @HiveField(5)
  int? dateTime;

  BloodSugarModel({
    this.key,
    this.stateCode,
    this.measure,
    this.unit,
    this.infoCode,
    this.dateTime,
  });

  DateTime get bloodSugarDate => DateTime.fromMillisecondsSinceEpoch(dateTime!);
}
