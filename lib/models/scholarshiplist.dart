import 'package:fst_app_flutter/models/scholarship.dart';
import 'package:fst_app_flutter/utils/debouncer.dart';
import 'package:flutter/foundation.dart';

// Defines the model for the manager of the list of Scholarships
class ScholarshipList with ChangeNotifier{

  bool isPerformingRequest; // illustrates if the manager is processing a request
  bool isAtEnd; // signifies if the list has shown all the data
  bool hasResults; // signifies if the search results has any data
  int start; //signifies the start index in the original list of scholarship from data request

  List<Scholarship> scholarships; // original list of scholarships from http requests
  List<Scholarship> current; // The current list which is used in the list view
  List<Scholarship> viewList; // The paginated list of scholarship

  final int size = 10; //The amount of scholarships added during each request

  ScholarshipList({scholarships}){
    this.scholarships = scholarships;
    start = 0;
    isPerformingRequest = false;
    isAtEnd  = false;
    hasResults = true;


    //If the original list of scholarships has a length less than size then it will assigned the list as the viewList
    //otherwise it will get a list with length of size from the original list and assign it to viewlist
    if(scholarships.length <= size){
      viewList = scholarships.getRange(start, scholarships.length).toList();
      start += (scholarships.length - start);
    }else{
      viewList = scholarships.getRange(start, start+size).toList();
      start += size;
    }
    current = viewList;
  }

  //Getter Methods
  List<Scholarship> get scholarList => current;
  bool get atEnd => isAtEnd;
  bool get doesHaveResults  => hasResults;
  bool get processRequests => isPerformingRequest;
  bool get isViewList => current == viewList;

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
    }else if(query == ""){
      current = viewList;
      hasResults = true;
    }else{
      hasResults = true;
    }


    notifyListeners();

  }

  void getMoreData() async{
    
    if (!isPerformingRequest) {

      isPerformingRequest = true;

      notifyListeners();

      List<Scholarship> newEntries; //new entries of scholarships for the paginated list

      if((scholarships.length - start) == 0){
        newEntries = [];
      }else if((scholarships.length - start) < size){
        newEntries = scholarships.getRange(start, scholarships.length).toList();
        start += (scholarships.length - start);
      }else {
        newEntries = scholarships.getRange(start, start+size).toList();
        start += size;
      }
      
      if (newEntries.isEmpty){
        isAtEnd = true;
      }

      await Debouncer.wait();
      
      viewList.addAll(newEntries);
      isPerformingRequest = false;

      notifyListeners();
    }
  }

  //switches the list from to the paginated list
  void switchList(){
    current = viewList;
    notifyListeners();
  }


}
