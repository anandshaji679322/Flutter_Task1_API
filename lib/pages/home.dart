import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/network_utils/network_manager.dart';
import '../widgets/data_card.dart';


enum status{
  active,
  loading,
  data,
  error;

}
late status currentStatus = status.active;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

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
  String _error=" ";



  Future<dynamic> getData(String a) {
    return NetworkService.getresponce(a);
  }

  void ButtonPressed() async {
  setState(() {
    currentStatus=status.loading;
    print(currentStatus.name);
  });
  final input = textEditingController.text;
  final responce = await getData(input);
  var decodedresponce = json.decode(responce.body);
  if (responce.statusCode == 200) {
  setState(() {
  _userName = decodedresponce['data']['user']['name'];
  _userId = decodedresponce['data']['user']['user_id'];
  _age = decodedresponce['data']['user']['age'];
  _profession = decodedresponce['data']['user']['profession'];
  _userDetails = decodedresponce;
  currentStatus= status.data;
    print(currentStatus.name);
  });
  } else {
  setState(() {
  _error = decodedresponce['error'];
  currentStatus = status.error;
  print(currentStatus.name);
  });
  print(_error);
  }
// print("responce is :$");
}

  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

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
                ButtonPressed()
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
                            "$_error",
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
