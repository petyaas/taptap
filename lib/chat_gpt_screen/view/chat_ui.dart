import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
class ChatUi extends StatefulWidget {
  const ChatUi({super.key});

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _client = const types.User(id: '82291008-a484-4a89-ae75-a22bf8d6f3ac');

  List<String> _answers=[
    "OK tnx","Next time","Good luck","Can i help you?",
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: _user,
    ),
  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async{
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    final random = Random.secure();
    final value =  random.nextInt(3);
    final textMessageClient = types.TextMessage(
      author: _client,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: _answers[value],
    );

    _addMessage(textMessage);
    await Future.delayed(const Duration(seconds: 2));
    _addMessage(textMessageClient);
  }
}