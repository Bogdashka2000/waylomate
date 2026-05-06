part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class ChatConnectEvent extends ChatEvent {
  const ChatConnectEvent();
}

class ChatSendMessageEvent extends ChatEvent {
  final String text;
  const ChatSendMessageEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class ChatDisconnectEvent extends ChatEvent {
  const ChatDisconnectEvent();
}

class ChatReconnectEvent extends ChatEvent {
  const ChatReconnectEvent();
}

class ChatClearMessagesEvent extends ChatEvent {
  const ChatClearMessagesEvent();
}
