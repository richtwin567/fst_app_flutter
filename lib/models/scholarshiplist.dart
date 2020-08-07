import 'package:fst_app_flutter/models/scholarship.dart';

class ScholarshipList {
  List<Scholarship> scholarships;

  ScholarshipList({this.scholarships});

  List<Scholarship> get scholarList => scholarships;

  factory ScholarshipList.fromJson(List<dynamic> parsedJson) {
    List<Scholarship> lst = new List<Scholarship>();
    lst = parsedJson.map((i) => Scholarship.fromJson(i)).toList();
    return new ScholarshipList(
      scholarships: lst,
    );
  }
}
