import 'package:http/http.dart' as http;

class GetContacts {
  static Future<String> getContactsDjangoApi(String query) async {
    String contactUrl = 'http://192.168.100.70:8000/contact/?search=$query';

    http.Response response = await http.get(Uri.encodeFull(contactUrl));

    return response.body;
  }
}
