import 'package:fst_app_flutter/models/enums/department.dart';

class Properties {
  final String title;
  final Department associatedWith;
  final String description;
  final String altName;

  Properties(
      {this.title = '',
      this.description = '',
      this.associatedWith = Department.other,
      this.altName = ''});

  toGeoJsonFile() {
    return {
      '\"title\"': '\"$title\"',
      '\"associatedWith\"': '\"${associatedWith.toShortString()}\"',
      '\"description\"': '\"$description\"',
      '\"altName\"': '\"$altName\"'
    };
  }

  toGeoJson() {
    return {
      'title': title,
      'associatedWith': associatedWith.toShortString(),
      'description': description,
      'altName': altName
    };
  }
}
