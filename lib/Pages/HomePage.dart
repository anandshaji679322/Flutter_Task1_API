import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Widgets/DataCard.dart';
import '../Services/Network.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final api =
      "https://2fa0d036-25f8-4bc9-80a4-ff1726e4e097.mock.pstmn.io/caddayn/mock/users/";
  var user_details;
  var user_id;
  var user_name;
  var age;
  var profession;
  var u_error;
  bool iserror = false;
  bool isloading = false;

  Future<http.Response> getData(String a) {
    return Service().getresponce(a);
  }

  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(120, 0, 120, 20),
              child: TextField(
                controller: _textEditingController,
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
              child: Text(
                "Fetch User",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                setState(() {
                  isloading = true;
                });
                final input = _textEditingController.text;
                final responce = await getData(input);
                var decodedresponce = json.decode(responce.body);
                if (responce.statusCode == 200) {
                  setState(() {
                    isloading = false;
                    iserror = false;
                    user_name = decodedresponce['data']['user']['name'];
                    user_id = decodedresponce['data']['user']['user_id'];
                    age = decodedresponce['data']['user']['age'];
                    profession = decodedresponce['data']['user']['profession'];
                    user_details = decodedresponce;
                  });
                } else {
                  setState(() {
                    isloading = false;
                    iserror = true;
                    u_error = decodedresponce['error'];
                  });
                  print(u_error);
                }
                // print("responce is :$");
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            ),
            SizedBox(height: 10),
            isloading
                ? CircularProgressIndicator()
                : user_details == null
                    ? const Text(
                        'Enter the user id and click button to get the user details',
                        style: TextStyle(color: Colors.green),
                      )
                    : iserror
                        ? Text(
                            "$u_error",
                            style: TextStyle(color: Colors.red),
                          )
                        : DataCard(
                            user_details: user_details,
                            user_name: user_name,
                            user_id: user_id,
                            age: age,
                            profession: profession)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
