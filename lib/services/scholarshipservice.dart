import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:fst_app_flutter/models/scholarship.dart';
import 'package:fst_app_flutter/models/scholarshiplist.dart';

class ScholarshipService{

  static String api = "http://192.168.137.88:8000/scholarship/";
  static String url = "https://www.mona.uwi.edu/osf/scholarships-bursaries";

  static Future<List<Scholarship>> getAllScholarships() async {
    try {
      var response = await http.get(api);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return Future(() => ScholarshipList.fromJson(jsonResponse).scholarList);
      } else {
        throw Exception('Failed to Load List from Server');
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  static Future<void> launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not load webiste';
    }
  }

  static List<Scholarship> search(String query, List<Scholarship> lst) {
    List<Scholarship> result = new List<Scholarship>();
    for (Scholarship a in lst) {
      if (a.scholarshipName.toLowerCase().contains(query.toLowerCase())) {
        result.add(a);
      }
    }
    return result;
  }
}