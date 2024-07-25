import 'package:chatflutter/models/user.dart';
import 'package:chatflutter/widget/costomtitlefreind.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Freindspage extends StatelessWidget {
  Freindspage({super.key});
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    String Myemail = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<user> usersList = [];
          // if (snapshot.connectionState == ConnectionState.done) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            // ignore: avoid_print
            print(user.fromJson(snapshot.data!.docs[i]));
            usersList.add(user.fromJson(snapshot.data!.docs[i]));
          }
          // }
          return Scaffold(
              appBar: AppBar(
                elevation: 90,
                title: const Text(
                  "Freinds",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        // reverse: true,
                        // controller: _controller,
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          return titlefrinds(Myemail, usersList, index);
                        }),
                  ),
                ],
              ));
        } else {
          return const Scaffold(body: Text("loading ......"));
        }
      },
    );
  }
}
