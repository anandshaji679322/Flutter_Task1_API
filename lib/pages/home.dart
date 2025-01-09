import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/network_utils/network_manager.dart';
import '../widgets/data_card.dart';


enum Status{
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
  var _userDetails;
  late int _userId;
  String _userName =" ";
  late int _age;
  String _profession=" ";
  var _error=" ";



  Future<dynamic> getData(String a) {
    return NetworkService.getresponse(a);
  }

  void buttonPressed() async {
  setState(() {
    currentStatus=Status.loading;
    if (kDebugMode) {
      print(currentStatus.name);
    }
  });
  final input = textEditingController.text;
  final response = await getData(input);
  var decodedresponce = json.decode(response.body);
  if (response.statusCode == 200) {
  setState(() {
  _userName = decodedresponce['data']['user']['name'];
  _userId = decodedresponce['data']['user']['user_id'];
  _age = decodedresponce['data']['user']['age'];
  _profession = decodedresponce['data']['user']['profession'];
  _userDetails = decodedresponce;
  currentStatus= Status.data;
    if (kDebugMode) {
      print(currentStatus.name);
    }
  });
  } else {
  setState(() {
  _error = decodedresponce['error'];
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
              onPressed:()=>{
                buttonPressed()
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              child: Text(
                "Fetch User",
                style: TextStyle(color: Colors.white)
              ),
            ),
            SizedBox(height: 10),
            currentStatus.name =='loading'
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
                            profession: _profession)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
