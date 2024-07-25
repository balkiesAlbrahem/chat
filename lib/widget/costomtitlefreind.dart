// ignore: non_constant_identifier_names
import 'package:chatflutter/models/user.dart';
import 'package:chatflutter/page/pagechat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
ListTile titlefrinds(String Myemail, List<user> usersList, int index) {
  return ListTile(
    onTap: () {
      Get.to(
        pagechat(
          myemail: Myemail,
          otheremail: usersList[index].emailuser,
          othername: usersList[index].nameuser,
        ),
        // arguments: {
        //   "Myemail": Myemail,
        //   "otherEmail": usersList[index].emailuser,
        // },
      );
    },
    leading: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.black45,
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/one.jpg"),
        ),
      ),
      width: 60,
      height: 60,
    ),
    title: Text(
      usersList[index].nameuser,
      style: const TextStyle(
        color: Color.fromARGB(255, 17, 117, 200),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    subtitle: Text(usersList[index].emailuser),
    trailing: const Icon(
      Icons.chat,
      color: Colors.grey,
    ),
  );
}
