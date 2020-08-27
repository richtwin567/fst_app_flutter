class Scholarship {
  //Attributes of the Class
  String name;
  String description;
  String details;

  //Constructor for the Scholarship Class
  Scholarship({this.name, this.description, this.details});

  //Getter Methods for the attributes
  String get scholarshipName => name;
  String get scholarshipDescription => description;
  String get scholarshipDetails => details;

  //This method converts a json map into an Scholarship Object
  factory Scholarship.fromJson(Map<String, dynamic> parsedJSON) {
    return Scholarship(
        name: parsedJSON['name'],
        description: parsedJSON['description'],
        details: parsedJSON['details']);
  }
}
