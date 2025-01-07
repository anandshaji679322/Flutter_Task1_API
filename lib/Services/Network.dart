import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service{
  Future<http.Response> getresponce(String a) async {
    dynamic err;
    try{
      final response = await http.get(Uri.parse(
          'https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock/users/$a'));
      return response;
    }catch(e){
      print(http.Response('{"error":"Some Thing Went Wrong"}',500));
      return http.Response('{"error":"Some Thing Went Wrong"}',500);
      throw e;

    }
  }
}