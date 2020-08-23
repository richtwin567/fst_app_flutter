import 'package:fst_app_flutter/models/scholarship.dart';
import 'package:fst_app_flutter/utils/debouncer.dart';
import 'package:flutter/foundation.dart';

class ScholarshipList with ChangeNotifier{

  bool isPerformingRequest;
  bool isAtEnd;
  bool hasResults;
  bool hasData;
  int start;

  List<Scholarship> scholarships;
  List<Scholarship> current;
  List<Scholarship> viewList;

  final int size = 10;

  ScholarshipList({scholarships}){
    this.scholarships = scholarships;
    start = 0;
    isPerformingRequest = false;
    isAtEnd  = false;
    hasResults = true;

    if(scholarships.length <= size){
      viewList = scholarships.getRange(start, scholarships.length).toList();
      start += (scholarships.length - start);
    }else{
      viewList = scholarships.getRange(start, start+size).toList();
      start += size;
    }
    current = viewList;
  }


  List<Scholarship> get scholarList => current;
  bool get atEnd => isAtEnd;
  bool get doesHaveResults  => hasResults;
  bool get processRequests => isPerformingRequest;
  bool get isViewList => current == viewList;

  factory ScholarshipList.fromJson(List<dynamic> parsedJson) {
    List<Scholarship> lst = new List<Scholarship>();
    lst = parsedJson.map((i) => Scholarship.fromJson(i)).toList();
    return new ScholarshipList(
      scholarships: lst,
    );
  }

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

      List<Scholarship> newEntries;

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

  void switchList(){

    current = viewList;
    notifyListeners();
  }


}
