import 'package:chatflutter/helper/show_snack_bar.dart';
import 'package:chatflutter/page/freindspage.dart';
import 'package:chatflutter/page/pagechat.dart';
import 'package:chatflutter/page/pagesignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore:, camel_case_types
class pagelogin extends StatefulWidget {
  const pagelogin({super.key});
  final bool? obscuretext = true;
  @override
  State<pagelogin> createState() => _pageloginState();
}

// ignore: camel_case_types
class _pageloginState extends State<pagelogin> {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text("data"),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 0,
                ),
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "This is Empty";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "email",
                  ),
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "This is Empty";
                    }
                  },
                  decoration: const InputDecoration(hintText: "password"),
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          // ignore: use_build_context_synchronously
                          // showSnackBar(context, "Success");
                          Get.to(Freindspage(), arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == "user-not-found") {
                            // ignore: use_build_context_synchronously
                            showSnackBar(context, "user not found");
                          } else if (ex.code == "wrong-password") {
                            //ignore: use_build_context_synchronously
                            showSnackBar(context, "wrong password");
                          }
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context, e.toString());
                        }
                        isloading = false;
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent,
                      ),
                      height: 40,
                      width: 170,
                      child: const Center(child: Text("Log In")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("you don't have Account ? "),
                    InkWell(
                      onTap: () {
                        Get.to(const pagesignup());
                      },
                      child: const Text(
                        "  Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
