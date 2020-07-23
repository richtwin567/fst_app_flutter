import 'package:http/http.dart' as http;
import 'dart:convert';

class GetContacts {
  static Future<String> getContactsDjangoApi(dynamic query) async {
    String queryString = query.toString();
    String contactUrl = 'http://192.168.100.76:8000/contact/?search=$queryString';

    http.Response response = await http.get(Uri.encodeFull(contactUrl));

    return response.body;
  }

  static Future<List<dynamic>> searchDjangoContacts(dynamic value) async {
    return GetContacts.getContactsDjangoApi(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      return data;
    });
  }
}
