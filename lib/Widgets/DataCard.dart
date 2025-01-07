import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.user_details,
    required this.user_name,
    required this.user_id,
    required this.age,
    required this.profession,
  });

  final dynamic user_details;
  final dynamic user_name;
  final dynamic user_id;
  final dynamic age;
  final dynamic profession;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 290,
        width: 500,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius:
            BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 270,
                width: 200,
                // padding: const EdgeInsets.fromLTRB(15, 10, 50, 10),
                child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(5.0),
                    child: Image.network(
                      user_details['data']['user']
                      ['profile_image'],
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 100, 0, 0),
                // EdgeInsets.fromLTRB(30, 100, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userDetails(user: "Name",user_detail: user_name),
                    userDetails(user: "UserID", user_detail: user_id),
                    userDetails(user: "Age",user_detail: age),
                    userDetails(user: "Profession", user_detail: profession),


                    // Row(
                    //   children: [
                    //     Text("User ID "),
                    //     Text(":"),
                    //     Text(" $user_id")
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text("Age "),
                    //     Text(":"),
                    //     Text(" $age")
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Text("Profession "),
                    //     Text(":"),
                    //     Text(" $profession")
                    //   ],
                    // ),
                    // richText(user: "Name",user_detail: user_name),
                    // richText(user: "User ID",user_detail: user_id),
                    // richText(user: "Age", user_detail: age),
                    // richText(user: "Profession", user_detail: profession)

                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class userDetails extends StatelessWidget {
  const userDetails({
    super.key,
    required this.user,
    required this.user_detail,
  });

  final dynamic user_detail;

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text("$user",style: TextStyle(color: Colors.white),),
        ),
        Text(":",style: TextStyle(color: Colors.white),),
        SizedBox(
          child: Text("   $user_detail",style: TextStyle(color: Colors.yellow),),
        )

      ],
    );
  }
}

