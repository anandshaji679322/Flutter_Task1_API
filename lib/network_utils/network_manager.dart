import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/service_model.dart';

class NetworkService {
  Future<ServiceModel> getresponse(String a) async {
    String api =
        "https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock/users/";
      try{
        final response = await http.get(Uri.parse('$api$a'));
        String json = response.body;
        if (kDebugMode) {
          print(json);
        }
        return serviceModelFromJson(json);
      }catch(e){
        final response = http.Response('{"success": false,"error":"Some Thing Went Wrong"}',500);
        String json = response.body;
        if (kDebugMode) {
          print(json);
        }
        return serviceModelFromJson(json);
      }
  }
}
