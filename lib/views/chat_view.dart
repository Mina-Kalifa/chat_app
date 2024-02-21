import 'package:def_app/models/chat_model.dart';
import 'package:def_app/widgets/bubble_chat_widget.dart';
import 'package:def_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  static String chatId = 'ChatView';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('time', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/OIP.jpeg',
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _messagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final messagesList = snapshot.data!.docs.map((doc) {
            return ChatModel.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return BubbleChat(
                      chat: messagesList[index],
                      isSender: messagesList[index].email == email,
                    );
                  },
                ),
              ),
              CustomTextField(
                addMessage: (message) {
                  FirebaseFirestore.instance.collection('messages').add({
                    'Message': message,
                    'time': DateTime.now(),
                    'email': email,
                  }).then((value) {
                    print("Message Added");
                  }).catchError((error) {
                    print("Failed to add message: $error");
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
