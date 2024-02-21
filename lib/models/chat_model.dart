class ChatModel {
  final String message;
  final String email;
  ChatModel({required this.message, required this.email});

  factory ChatModel.fromJson(json) {
    return ChatModel(
      message: json['Message'],
      email: json['email'],
    );
  }
}
