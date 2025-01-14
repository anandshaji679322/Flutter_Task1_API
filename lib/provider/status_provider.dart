import 'package:untitled/status_enum.dart';
import 'package:flutter/foundation.dart';

import '../model/service_model.dart';
import '../network_utils/network_manager.dart';

class StatusProvider extends ChangeNotifier {
  dynamic userDetails;
  late int userId;
  String userName = " ";
  late int age;
  String profession = " ";
  var error = " ";
  dynamic imgUrl;
  Status currentStatus = Status.active;

  Future<ServiceModel> getData(String a) {
    return NetworkService().getresponse(a);
  }

  void buttonPressed(String input) async {
    currentStatus = Status.loading;
    notifyListeners();
    if (kDebugMode) {
      print(currentStatus.name);
    }
    if (kDebugMode) {
      print("textfied input :$input");
    }
    final response = await getData(input);
    if (kDebugMode) {
      print("API Call sucess and data returned");
      print(response.data?.user.name);
    }

    if (response.success == true) {
      userName = response.data?.user.name as String;
      userId = response.data?.user.userId as int;
      age = response.data?.user.age as int;
      profession = response.data?.user.profession as String;
      userDetails = response;
      imgUrl = response.data?.user.profileImage;
      currentStatus = Status.data;
      notifyListeners();
      if (kDebugMode) {
        print(currentStatus.name);
      }
    } else {
      error = response.error;
      if (kDebugMode) {
        print(error);
      }
      currentStatus = Status.error;
      notifyListeners();
      if (kDebugMode) {
        print(currentStatus.name);
      }

      if (kDebugMode) {
        print(error);
      }
    }
// print("response is :$");
  }
}
