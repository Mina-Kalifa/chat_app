import 'package:def_app/views/chat_view.dart';

import 'views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/login_view.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.loginId: (context) => LoginView(),
        RegisterView.registerId: (context) => RegisterView(),
        ChatView.chatId: (context) => ChatView(),
      },
      initialRoute: LoginView.loginId,
    );
  }
}
