import 'package:chatflutter/helper/show_snack_bar.dart';
import 'package:chatflutter/page/freindspage.dart';
import 'package:chatflutter/page/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable, camel_case_types
class pagesignup extends StatefulWidget {
  const pagesignup({super.key});

  @override
  State<pagesignup> createState() => _pagesignupState();
}

// ignore: camel_case_types
class _pagesignupState extends State<pagesignup> {
  String? email;
  String? name;
  String? password;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("data"),
      // ),
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Sign Up",
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
                    hintText: "name",
                  ),
                  onChanged: (data) {
                    name = data;
                  },
                ),
                const SizedBox(
                  height: 30,
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
                          await registerUser();
                          // ignore: use_build_context_synchronously
                          //showSnackBar(context, "Success");
                          Get.to(Freindspage(), arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == "weak-password") {
                            // ignore: use_build_context_synchronously
                            showSnackBar(context, "weak password");
                          } else if (ex.code == "email-already-in-user") {
                            //ignore: use_build_context_synchronously
                            showSnackBar(context, "email already exists");
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
                      child: const Center(child: Text("Sign Up")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("you have account Already ? "),
                    InkWell(
                      onTap: () {
                        Get.to(const pagelogin());
                      },
                      child: const Text(
                        "   Log In",
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

//////////////////
////
  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    ///////////لازم حطو لما ينجح بتسجسل الدخول
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.add({
      "nameuser": name,
      "emailuser": email,
    });
  }
}
