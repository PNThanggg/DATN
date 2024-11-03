class HeartRateModel {
  int? timeStamp;
  int? value;
  int? age;
  String? genderId;

  HeartRateModel({
    this.timeStamp,
    this.value,
    this.age,
    this.genderId,
  });

  HeartRateModel.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'] as int?;
    value = json['value'] as int?;
    age = json['age'] as int?;
    genderId = json['genderId'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['timeStamp'] = timeStamp;
    json['value'] = value;
    json['age'] = age;
    json['genderId'] = genderId;
    return json;
  }
}
