import 'package:chatflutter/constant/constant.dart';
import 'package:chatflutter/models/message.dart';
import 'package:chatflutter/widget/costomchatbuble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// ignore: camel_case_types, must_be_immutable
class pagechat extends StatelessWidget {
  final String myemail;
  final String otheremail;
  final String othername;

  pagechat(
      {super.key,
      required this.myemail,
      required this.otheremail,
      required this.othername});
  //static String id = 'chatpage';
  final ScrollController _controller = ScrollController();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagescollection);

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //String Myemail = ModalRoute.of(context)!.settings.arguments as String;

    // final args = Get.arguments;
    // // ignore: non_constant_identifier_names
    // var Myemail = args['myEmail'];
    // var otherEmail = args['otherEmail'];
    print(myemail);
    print(otheremail);

    // print("messages =====>>${messages}");
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
      // stream: messages
      //     .where('participants', arrayContainsAny: [myemail, otheremail])
      //     .orderBy(kcreatedAt, descending: true)
      //     .snapshots(),
      // stream: messages
      //     .where('sendId', isEqualTo: myemail)
      //     .where('otherEmail', isEqualTo: otheremail)
      //     .orderBy(kcreatedAt, descending: true)
      //     .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var message = Message.fromJson(snapshot.data!.docs[i]);
            if ((message.id == myemail && message.otherEmail == otheremail) ||
                (message.id == otheremail && message.otherEmail == myemail)) {
              messagesList.add(message);
            }
            // ignore: avoid_print
            // print(Message.fromJson(snapshot.data!.docs[i]));
            // messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              appBar: AppBar(
                elevation: 90,
                title: Text(
                  othername,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // centerTitle: true,
                backgroundColor: Colors.blueAccent,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == myemail
                              ? costomchatbuble(
                                  message: messagesList[index],
                                )
                              : costomchatbubleforfreinds(
                                  message: messagesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'sendId': myemail,
                          'otherEmail': otheremail,
                          kmessage: data,
                          kcreatedAt: DateTime.now(),

                          ////
                        });
                        // print(data);
                        // print("\n email: $email \n data : $data");
                        controller.clear();
                        _controller.animateTo(
                          0,
                          //  _controller.position.maxScrollExtent,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 100),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: "Send Massage",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.send,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                            )),
                      ),
                    ),
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
