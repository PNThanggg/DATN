class InsightModel {
  final String title;
  final List<String> contents;
  final String icon;

  InsightModel({
    required this.title,
    required this.contents,
    required this.icon,
  });

  factory InsightModel.fromJson(Map json) {
    return InsightModel(
      title: json["title"],
      contents: List<String>.from(json['content']),
      icon: json['icon'],
    );
  }

  static List<InsightModel> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray.map((json) => InsightModel.fromJson(json)).toList();
  }

  @override
  String toString() {
    return "InsightModel($title)";
  }
}
