class Scholarship {
  //Attributes of the Class
  String name, details, numAwards, tenure, value, eligible, criteria ,method , special, condition;

  //Constructor for the Scholarship Class
  Scholarship({this.name, 
    this.details,
    this.numAwards,
    this.value,
    this.tenure,
    this.eligible,
    this.criteria,
    this.method,
    this.special,
    this.condition
  });

  //Getter Methods for the attributes
  String get scholarshipName => name;
  String get scholarshipDetails => details;
  String get scholarshipAwards => numAwards;
  String get scholarshipValue => value;
  String get scholarshipTenure => tenure;
  String get scholarshipCriteria => criteria;
  String get scholarshipEligibility => eligible;
  String get scholarshipMethod => method;
  String get scholarshipSpecial => special;
  String get scholarshipCondition => condition;

  //This method converts a json map into an Scholarship Object
  factory Scholarship.fromJson(Map<String, dynamic> parsedJSON) {

    String name, details, numAwards, value, tenure, eligible, criteria ,method , special, condition;

    parsedJSON['name'] == "" ?  name = null :  name = parsedJSON['name'];
    parsedJSON['additional_details'] == "" ?  details = null :  details = parsedJSON['additional_details'];
    parsedJSON['number_of_awards'] == "" ?  numAwards = null :  numAwards = parsedJSON['number_of_awards'];
    parsedJSON['value'] == "" ?  value = null :  value = parsedJSON['value'];
    parsedJSON['max_tenure'] == "" ?  tenure = null :  tenure = parsedJSON['max_tenure'];
    parsedJSON['eligibility'] == "" ?  eligible = null :  eligible = parsedJSON['eligibility'];
    parsedJSON['criteria'] == "" ?  criteria = null :  criteria = parsedJSON['criteria'];
    parsedJSON['method_of_selection'] == "" ?  method = null :  method = parsedJSON['method_of_selection'];
    parsedJSON['special_requirements'] == "" ?  special = null :  special = parsedJSON['special_requirements'];
    parsedJSON['condition'] == "" ?  condition = null :  condition = parsedJSON['condition'];
    

    return Scholarship(
      name: name,
      details: details,
      numAwards: numAwards,
      value: value,
      tenure: tenure,
      eligible: eligible,
      criteria: criteria,
      method: method,
      special: special,
      condition: condition,
    );
  }
}
