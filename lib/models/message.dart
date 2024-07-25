class Message {
  final String message;
  final String id;
  final String otherEmail;
  Message(this.message, this.id, this.otherEmail);

  factory Message.fromJson(dynamic jsonData) {
    return Message(
        jsonData['message'], jsonData['sendId'], jsonData['otherEmail']);
  }
}
