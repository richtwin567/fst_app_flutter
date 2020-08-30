import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:flutter/foundation.dart';

// Defines the model for the manager of the list of Scholarships
class ScholarshipList with ChangeNotifier{

  bool hasResults; // signifies if the search results has any data

  List<Scholarship> scholarships; // original list of scholarships from http requests
  List<Scholarship> current; // The current list which is used in the list view

  ScholarshipList({scholarships}){
    this.scholarships = scholarships;
    hasResults = true;

    //If the original list of scholarships has a length less than size then it will assigned the list as the viewList
    //otherwise it will get a list with length of size from the original list and assign it to viewlist
    current = this.scholarships;
  }

  //Getter Methods
  List<Scholarship> get scholarList => current;
  bool get doesHaveResults  => hasResults;
  bool get isSearching => current != scholarships;

  //Factory Method for converting json into the model used
  factory ScholarshipList.fromJson(List<dynamic> parsedJson) {
    List<Scholarship> lst = new List<Scholarship>();
    lst = parsedJson.map((i) => Scholarship.fromJson(i)).toList();
    return new ScholarshipList(
      scholarships: lst,
    );
  }

  //Function which searches to see if the query is contained in the Scholarship Name
  //Possibly could be refined for better searching methods
  void search(String query){
    
    current = scholarships.where((p) => p.scholarshipName.toLowerCase().contains(query.toLowerCase())).toList();

    if(current.isEmpty){
      current = [Scholarship(name:"No Search Results")];
      hasResults = false;
    }else{
      hasResults = true;
    }

    notifyListeners();

  }


}
