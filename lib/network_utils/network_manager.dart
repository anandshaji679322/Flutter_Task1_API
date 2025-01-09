import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  static getresponse(String a) async {
    final api =
        "https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock/users/";
    try {
      final response = await http.get(Uri.parse('$api$a'));
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(http.Response('{"error":"Some Thing Went Wrong"}', 500));
      }
      return http.Response('{"error":"Some Thing Went Wrong"}', 500);
    }
  }
}
