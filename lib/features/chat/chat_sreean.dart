import 'package:cogo/common/widgets/atoms/texts/styles.dart';
import 'package:cogo/constants/constants.dart';
import 'package:cogo/features/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Scaffold(),
    );
  }
}
