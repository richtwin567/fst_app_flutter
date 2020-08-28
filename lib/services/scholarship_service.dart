import 'dart:async';
import 'package:fst_app_flutter/models/from_postgres/scholarship/scholarship.dart';
import 'package:fst_app_flutter/models/scholarshiplist.dart';
import 'package:fst_app_flutter/services/handle_heroku_requests.dart';

class ScholarshipService{

  static String url = "https://www.mona.uwi.edu/osf/scholarships-bursaries";

  static Future<ScholarshipList> getAllScholarships() async {
    try {
      HerokuRequest<Scholarship> handler = HerokuRequest();
      var result = await handler.getResults("scholarship/",true, (data) => Scholarship.fromJson(data));
      return Future(() => ScholarshipList(scholarships: result));
    } catch (e) {
      throw Exception('Cannot load from server');
    }
  }
}