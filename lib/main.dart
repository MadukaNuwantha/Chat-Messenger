import 'package:chat_messenger/firebase_options.dart';
import 'package:chat_messenger/services/auth_services/auth_gate.dart';
import 'package:chat_messenger/services/auth_services/auth_service.dart';
import 'package:chat_messenger/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const ChatMessenger(),
    ),
  );
}

class ChatMessenger extends StatelessWidget {
  const ChatMessenger({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Messenger Application',
      theme: lightTheme,
      home: const AuthenticationGate(),
    );
  }
}
