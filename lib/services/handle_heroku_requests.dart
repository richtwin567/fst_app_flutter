import 'dart:convert';
import 'package:http/http.dart' as http;

class HerokuRequest<T> {
  /// The [query] should be the end of the url for sending a request to the server.
  ///
  /// eg. To get all contacts from the Chemistry department, I should pass
  /// ```
  /// 'contact/?department=CHEM'
  /// ```
  ///
  /// The response body is returned as a [String].
  Future<String> _getResultsString(
      dynamic query, bool queryIsForFSTHeroku) async {
    String queryString = query.toString();
    String url;
    if (queryIsForFSTHeroku) {
      url = 'https://fst-app-2.herokuapp.com/$queryString';
    } else {
      url = queryString;
    }

    http.Response response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200)
      return response.body;
    else
      return '';
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
  Future<List<T>> getResultsJSON(dynamic valueToQuery, bool queryIsForFSTHeroku,
      _Instantiator<T> constructor) async {
    return _getResultsString(valueToQuery, queryIsForFSTHeroku)
        .then((responseBody) {
      List<dynamic> dataJSON = jsonDecode(responseBody);

      List<T> data =
          List.generate(dataJSON.length, (i) => constructor(dataJSON[i]));
      return data;
    });
  }
}

typedef S _Instantiator<S>(dynamic data);
