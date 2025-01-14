import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/status_enum.dart';
import '../provider/status_provider.dart';
import '../widgets/data_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;

  final OutlineInputBorder _decoration = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green), borderRadius: BorderRadius.all(Radius.circular(12)));

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
    return Consumer<StatusProvider>(
      builder: (context, statusChangeProviderModel, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(120, 0, 120, 20),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      enabledBorder: _decoration, focusedBorder: _decoration, border: _decoration, hintText: "User ID"),
                ),
              ),
              // SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => {statusChangeProviderModel.buttonPressed(textEditingController.text)},
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                child: Text("Fetch User", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              statusChangeProviderModel.currentStatus == Status.loading
                  ? CircularProgressIndicator()
                  : statusChangeProviderModel.currentStatus == Status.active
                      ? const Text(
                          'Enter the user id and click button to get the user details',
                          style: TextStyle(color: Colors.green),
                        )
                      : statusChangeProviderModel.currentStatus == Status.error
                          ? Text(
                              statusChangeProviderModel.error,
                              style: TextStyle(color: Colors.red),
                            )
                          : DataCard(
                              userDetails: statusChangeProviderModel.userDetails,
                              userName: statusChangeProviderModel.userName,
                              userId: statusChangeProviderModel.userId,
                              age: statusChangeProviderModel.age,
                              profession: statusChangeProviderModel.profession,
                              imgUrl: statusChangeProviderModel.imgUrl,
                            )
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
