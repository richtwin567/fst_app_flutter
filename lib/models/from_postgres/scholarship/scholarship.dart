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

  //This constructor converts a json map into an Scholarship Object
  Scholarship.fromJson( Map<String, dynamic> parsedJson){
    parsedJson['name'] == "" ?  name = null :  name = parsedJson['name'];
    parsedJson['additional_details'] == "" ?  details = null :  details = parsedJson['additional_details'];
    parsedJson['number_of_awards'] == "" ?  numAwards = null :  numAwards = parsedJson['number_of_awards'];
    parsedJson['value'] == "" ?  value = null :  value = parsedJson['value'];
    parsedJson['max_tenure'] == "" ?  tenure = null :  tenure = parsedJson['max_tenure'];
    parsedJson['eligibility'] == "" ?  eligible = null :  eligible = parsedJson['eligibility'];
    parsedJson['criteria'] == "" ?  criteria = null :  criteria = parsedJson['criteria'];
    parsedJson['method_of_selection'] == "" ?  method = null :  method = parsedJson['method_of_selection'];
    parsedJson['special_requirements'] == "" ?  special = null :  special = parsedJson['special_requirements'];
    parsedJson['condition'] == "" ?  condition = null :  condition = parsedJson['condition'];
  }
 
  //TODO: documentation @palmer-matthew
  String buildListItem(String title, content, bool inList){
    
    if(content == "" && inList){
      return "\u2022 $title\n";
    }
    
    return "- $title \n $content\n";
  }

  String buildHeading(title, content){
    List<String> secondary;
    String result = ""; 
    try {
      if(content.contains(":")){
        List<String> list = content.split(":");
        if(list[1].contains(";") && list.length == 2){
          secondary = list[1].split(";");
          String slist  = "";
          for(String b in secondary){
            if(b != ""){
              slist += buildListItem(b, "", true);
            }
          }
          result += buildListItem(title, list[0]+":", false);
          result += slist;
          return result;
        }else if(list[1].contains(";") && list.length == 3){
          secondary = list[1].split(";");
          String slist  = "";
          result += buildListItem(title, "" , false);
          result += "\t" + buildListItem(list[0], "", true);
          for(String b in secondary){
            if(b != ""){
              slist += "\t\t" + buildListItem(b, "", true);
            }
          }
          result += slist;
          result += "\t" + buildListItem(list[2], "", true);
          return result;
        }else if(list.length == 2 && !list[1].contains(";")){
          result += buildListItem(title, list[0]+":", false);
          result += "\t" + buildListItem(list[1], "", true);
          return result;
        }else {
          return buildListItem(title, list[1], false);
        }
      }else if(content.contains(";")){
        List<String> list = content.split(";");
        String slist  = "";
        for(String b in list){
          if(b != ""){
            slist += "\t" + buildListItem(b, "", true);
          }
        }
        result += buildListItem(title, "", false);
        result += slist;
        return result;
      }else{
        return buildListItem(title, content, false);
      }
    } on Exception catch (e) {
      print(e);
      return "Something went wrong";
    }

  }

  String buildDescriptionContent(){
    String result = "";
    try{
     
      if(numAwards != null){
        result += buildHeading('Number of Awards', numAwards) + "_____________________\n\n";
      }

      if(value != null){
        result += buildHeading('Value', value) + "_____________________\n\n";
      }

      if(tenure != null){
        result += buildHeading('Maximum Tenure', tenure) + "_____________________\n\n";
      }

      if(eligible != null){
        result += buildHeading("Eligibility", eligible) + "_____________________\n\n";
      }

    }on Exception catch(e){
      print(e);
      result = "Something went wrong";
    }
    return result;
  }

  String buildDetailContent(){
    String result = "";
    try{

      if(criteria != null){
        result += buildHeading("Criteria", criteria) + "_____________________\n\n";
      }

      if(method != null){
        result += buildHeading("Method Of Selection", method) + "_____________________\n\n";
      }

      if(special != null){
        result += buildHeading("Special Requirements", special) + "_____________________\n\n";
      }

      if(condition != null){
        result += buildHeading("Condition", condition) + "_____________________\n\n";
      }
      
      if(details != null){
        result += buildHeading("Additional Details", details) + "_____________________\n\n";
      }
      
    }on Exception catch(e){
      print(e);
      result = "Something went wrong";
    }
    return result;
  }

  @override
  String toString() {
    return "${name.toUpperCase()}\n\n" + buildDescriptionContent() + buildDetailContent();
  }
}
