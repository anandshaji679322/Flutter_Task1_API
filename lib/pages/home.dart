import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:untitled/network_utils/network_manager.dart';

import 'package:untitled/service_model.dart';
import '../widgets/data_card.dart';

enum Status {
  active,
  loading,
  data,
  error;
}

Status currentStatus = Status.active;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;
  dynamic _userDetails;
  late int _userId;
  String _userName = " ";
  late int _age;
  String _profession = " ";
  var _error = " ";
  dynamic _imgUrl;

  Future<ServiceModel> getData(String a) {
    return NetworkService().getresponse(a);
  }

  void buttonPressed() async {
    setState(() {
      currentStatus = Status.loading;
      if (kDebugMode) {
        print(currentStatus.name);
      }
    });
    final input = textEditingController.text;
    final response = await getData(input);
    if (kDebugMode) {
      print("API Call sucess and data returned");
      print(response.data?.user.name);
    }

    if (response.success == true) {
      setState(() {
        // var decodedresponce = json.decode(response.body);
        _userName = response.data?.user.name as String;
        _userId = response.data?.user.userId as int;
        _age = response.data?.user.age as int;
        _profession = response.data?.user.profession as String;
        _userDetails = response;
        _imgUrl = response.data?.user.profileImage;
        currentStatus = Status.data;
        if (kDebugMode) {
          print(currentStatus.name);
        }
      });
    } else {
      setState(() {
        _error = response.error;
        if (kDebugMode) {
          print(_error);
        }
        currentStatus = Status.error;
        if (kDebugMode) {
          print(currentStatus.name);
        }
      });

        if (kDebugMode) {
          print(_error);
        }
    }
// print("response is :$");
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(120, 0, 120, 20),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "User ID"),
              ),
            ),
            // SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => {buttonPressed()},
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              child: Text("Fetch User", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            currentStatus.name == 'loading'
                ? CircularProgressIndicator()
                : currentStatus.name == "active"
                    ? const Text(
                        'Enter the user id and click button to get the user details',
                        style: TextStyle(color: Colors.green),
                      )
                    : currentStatus.name == "error"
                        ? Text(
                            _error,
                            style: TextStyle(color: Colors.red),
                          )
                        : DataCard(
                            userDetails: _userDetails,
                            userName: _userName,
                            userId: _userId,
                            age: _age,
                            profession: _profession,
                            imgUrl: _imgUrl,
                          )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
