// lib/features/main/screens/messages/bloc/chat_bloc_states.dart
part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<MessageModel> messages;
  final bool isConnected;
  final bool isLoading;
  final String? error;

  const ChatState({
    required this.messages,
    required this.isConnected,
    required this.isLoading,
    this.error,
  });

  factory ChatState.initial() =>
      const ChatState(messages: [], isConnected: false, isLoading: false);

  ChatState copyWith({
    List<MessageModel>? messages,
    bool? isConnected,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get hasError => error != null;
  bool get hasMessages => messages.isNotEmpty;

  @override
  List<Object?> get props => [messages, isConnected, isLoading, error];
}
