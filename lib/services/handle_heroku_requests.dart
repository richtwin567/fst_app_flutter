import 'package:http/http.dart' as http;
import 'dart:convert';

/// Simple class for fetching and parsing data from the fst-app on Heroku.
class HandleHerokuRequests {
  /// The [query] should be the end of the url for sending a request to the server.
  ///
  /// eg. To get all contacts from the Chemistry department, I should pass
  /// ```
  /// 'contact/?department=CHEM'
  /// ```
  ///
  /// The response body is returned as a [String].
  static Future<String> _getResultsString(dynamic query) async {
    String queryString = query.toString();
    String contactUrl = 'https://fst-app-2.herokuapp.com/$queryString';

    http.Response response = await http.get(Uri.encodeFull(contactUrl));

    return response.body;
  }

  /// Parses the response from `_getResultsString` and returns a [List] of
  /// `dynamic` objects. The objects are in JSON format which is
  /// [Map<dynamic,dynamic>] format in flutter.
  ///
  /// A [Map] can be treated like a dictionary in Python in terms of
  /// declaration and accessing its members.
  ///
  /// Continuing from the example given for `_getResultsString`, to get the
  /// name of the first contact from the list of Chemistry department contacts,
  /// I would call `data[0]['name']`.
  static Future<List<dynamic>> getResultsJSON(dynamic value) async {
    return HandleHerokuRequests._getResultsString(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      return data;
    });
  }
}
