import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fst_app_flutter/models/scholarshiplist.dart';

class ScholarshipService{

  static String api = "https://fst-app-2.herokuapp.com/scholarship/";
  static String url = "https://www.mona.uwi.edu/osf/scholarships-bursaries";

  static Future<ScholarshipList> getAllScholarships() async {
    try {
      var response = await http.get(api);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return Future(() => ScholarshipList.fromJson(jsonResponse));
      } else {
        throw Exception('Failed to Load List from Server');
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}