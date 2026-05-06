// lib/features/main/screens/messages/bloc/chat_bloc.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waylomate/core/network/models/message_model/message_model.dart';
import 'package:waylomate/features/main/screens/messages/service/chat_service.dart';

part 'chat_bloc_events.dart';
part 'chat_bloc_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService;
  StreamSubscription<MessageModel>? _messageSubscription;

  ChatBloc({required ChatService chatService})
    : _chatService = chatService,
      super(ChatState.initial()) {
    on<ChatConnectEvent>(_onConnect);
    on<ChatSendMessageEvent>(_onSendMessage);
    on<ChatDisconnectEvent>(_onDisconnect);
    on<ChatReconnectEvent>(_onReconnect);
    on<ChatClearMessagesEvent>(_onClearMessages);
    on<_MessageReceivedEvent>(_onMessageReceived);
  }

  Future<void> _onConnect(
    ChatConnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isConnected || state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    debugPrint('🎯 [Bloc] Connecting...');

    try {
      // 🔹 1. Отменяем старую подписку
      await _messageSubscription?.cancel();
      _messageSubscription = null;

      // 🔹 2. Подписываемся на сообщения
      _messageSubscription = _chatService.messageStream.listen(
        (message) {
          if (isClosed) return;
          add(_MessageReceivedEvent(message));
        },
        onError: (error) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                isConnected: false,
                isLoading: false,
                error: 'Ошибка потока: $error',
              ),
            );
          }
        },
        cancelOnError: false,
      );

      await _chatService.connect();

      if (!emit.isDone) {
        emit(state.copyWith(isConnected: true, isLoading: false, error: null));
        debugPrint('✅ [Bloc] Connected state emitted');
      }
    } catch (e) {
      debugPrint('❌ [Bloc] Connection failed: $e');
      if (!emit.isDone) {
        emit(
          state.copyWith(
            isConnected: false,
            isLoading: false,
            error: 'Не удалось подключиться: $e',
          ),
        );
      }
    }
  }

  void _onMessageReceived(
    _MessageReceivedEvent event,
    Emitter<ChatState> emit,
  ) {
    if (isClosed) return;

    final updatedMessages = List<MessageModel>.from(state.messages)
      ..add(event.message);
    updatedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    emit(state.copyWith(messages: updatedMessages));
  }

  void _onSendMessage(ChatSendMessageEvent event, Emitter<ChatState> emit) {
    if (event.text.trim().isEmpty || !state.isConnected) return;
    _chatService.sendMessage(event.text.trim());
  }

  void _onDisconnect(ChatDisconnectEvent event, Emitter<ChatState> emit) {
    _messageSubscription?.cancel();
    _messageSubscription = null;

    _chatService.disconnect();
    emit(state.copyWith(isConnected: false, isLoading: false));
  }

  Future<void> _onReconnect(
    ChatReconnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    add(const ChatDisconnectEvent());
    await Future.delayed(const Duration(milliseconds: 500));
    if (!isClosed) {
      add(const ChatConnectEvent());
    }
  }

  void _onClearMessages(ChatClearMessagesEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(messages: []));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
    _chatService.dispose();
    return super.close();
  }
}

class _MessageReceivedEvent extends ChatEvent {
  final MessageModel message;
  const _MessageReceivedEvent(this.message);
}
