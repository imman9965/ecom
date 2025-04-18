class SectionModel {
  final String type;
  final List<dynamic> data;

  SectionModel({required this.type, required this.data});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(type: json['type'], data: json['data']);
  }
}
