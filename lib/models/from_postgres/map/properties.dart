class Properties {
  final String title;
  final String associatedWith;
  final String description;
  final String altName;

  Properties({this.title, this.description, this.associatedWith, this.altName});

  toGeoJSONFile() {
    return {
      '\"title\"': '\"$title\"',
      '\"associatedWith\"': '\"$associatedWith\"',
      '\"description\"': '\"$description\"',
      '\"altName\"': '\"$altName\"'
    };
  }

  toGeoJSON() {
    return {
      'title': title,
      'associatedWith': associatedWith,
      'description': description,
      'altName': altName
    };
  }
}
