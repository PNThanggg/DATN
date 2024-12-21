import 'package:hive/hive.dart';

import '../../common/config/hive_config/hive_constants.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveTypeConstants.userModel)
class UserModel extends HiveObject {
  @HiveField(0)
  int? age;
  @HiveField(1)
  String? genderId;

  UserModel({
    this.age,
    this.genderId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    age = json['age'] as int?;
    genderId = json['genderId'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['age'] = age;
    json['genderId'] = genderId;
    return json;
  }
}
