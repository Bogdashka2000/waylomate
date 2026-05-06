import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waylomate/features/main/screens/messages/bloc/chat_bloc.dart';
import 'package:waylomate/features/main/screens/messages/widgets/error_widget.dart';
import 'package:waylomate/features/main/screens/messages/widgets/message_space.dart';
import 'package:waylomate/features/main/screens/messages/widgets/no_message_widget.dart';
import 'package:waylomate/features/main/screens/messages/widgets/send_message_container.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.userId});
  final int userId;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late int _currentUserId;
  int _lastMessageCount = 0;
  StreamSubscription<ChatState>? _blocSubscription; // 🔹 Для отмены подписки

  @override
  void initState() {
    super.initState();
    _currentUserId = widget.userId;

    final bloc = context.read<ChatBloc>();
    if (!bloc.state.isConnected && !bloc.state.isLoading) {
      bloc.add(const ChatConnectEvent());
    }

    _blocSubscription = bloc.stream.listen((state) {
      if (state.messages.length > _lastMessageCount) {
        _lastMessageCount = state.messages.length;
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });
  }

  @override
  void deactivate() {
    context.read<ChatBloc>().add(const ChatDisconnectEvent());
    super.deactivate();
  }

  @override
  void dispose() {
    _blocSubscription?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatBloc>().add(ChatSendMessageEvent(text));
    _messageController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state.error != null) {
            return ErrorChatWidget(error: state.error!);
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: state.messages.isEmpty
                    ? const NoMessageWidget()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return MessageSpace(
                            message: message,
                            currentUserId: _currentUserId,
                          );
                        },
                      ),
              ),
              SendMessageContainer(
                messageController: _messageController,
                isConnected: state.isConnected,
                onSend: _sendMessage,
              ),
            ],
          );
        },
      ),
    );
  }
}
