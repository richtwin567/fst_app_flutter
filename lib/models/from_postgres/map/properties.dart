class Properties {
  String title;
  String associatedWith;
  String description;
  String altName;

  Properties({this.title, this.description, this.associatedWith, this.altName});

  toGeoJSON() {
    return {
      '\"title\"': '\"$title\"',
      '\"associatedWith\"': '\"$associatedWith\"',
      '\"description\"': '\"$description\"',
      '\"altName\"': '\"$altName\"'
    };
  }
}
