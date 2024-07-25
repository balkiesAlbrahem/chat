// ignore: camel_case_types
class user {
  final String emailuser;
  final String nameuser;
  user(this.emailuser, this.nameuser);

  factory user.fromJson(dynamic jsonData) {
    return user(jsonData['emailuser'], jsonData['nameuser']);
  }
}
