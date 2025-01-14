import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.userDetails,
    required this.userName,
    required this.userId,
    required this.age,
    required this.profession,
    required this.imgUrl,
  });

  final dynamic userDetails;
  final String userName;
  final int userId;
  final int age;
  final String profession;

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 290,
        width: 500,
        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 270,
                width: 200,
                // padding: const EdgeInsets.fromLTRB(15, 10, 50, 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 100, 0, 0),
              // EdgeInsets.fromLTRB(30, 100, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDetail(user: "Name", userDetail: userName),
                  UserDetail(user: "UserID", userDetail: userId),
                  UserDetail(user: "Age", userDetail: age),
                  UserDetail(user: "Profession", userDetail: profession),
                ],
              ),
            )
          ],
        ));
  }
}

class UserDetail extends StatelessWidget {
  const UserDetail({
    super.key,
    required this.user,
    required this.userDetail,
  });

  final dynamic userDetail;

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            "$user",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          ":",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          child: Text(
            "   $userDetail",
            style: TextStyle(color: Colors.yellow),
          ),
        )
      ],
    );
  }
}
