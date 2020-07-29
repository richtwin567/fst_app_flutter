import 'package:http/http.dart' as http;
import 'dart:convert';

class HandleHerokuRequests {
  static Future<String> _getResultsString(dynamic query) async {
    String queryString = query.toString();
    String contactUrl = 'https://fst-app-2.herokuapp.com/$queryString';

    http.Response response = await http.get(Uri.encodeFull(contactUrl));

    return response.body;
  }

  static Future<List<dynamic>> getResultsJSON(dynamic value) async {
    return HandleHerokuRequests._getResultsString(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      return data;
    });
  }
}
