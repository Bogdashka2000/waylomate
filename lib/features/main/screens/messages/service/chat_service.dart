// lib/features/main/screens/messages/service/chat_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:waylomate/core/network/dio_client.dart';
import 'package:waylomate/core/network/models/message_model/message_model.dart';

class ChatService {
  final DioClient dioClient;
  final String baseUrl;
  final String cookieName;
  final String httpDomain;

  WebSocketChannel? _channel;
  StreamSubscription? _wsSubscription;
  final _messageController = StreamController<MessageModel>.broadcast();

  bool _isDisposed = false;
  bool _isConnected = false;
  bool _isConnecting = false;

  ChatService({
    required this.baseUrl,
    required this.cookieName,
    required this.httpDomain,
    required this.dioClient,
  });

  Stream<MessageModel> get messageStream => _messageController.stream;

  Future<void> connect() async {
    if (_isDisposed || _isConnected || _isConnecting) {
      debugPrint(
        '⚠️ [connect] Aborted: disposed=$_isDisposed, connected=$_isConnected, connecting=$_isConnecting',
      );
      return;
    }

    _isConnecting = true;
    debugPrint('🔌 [connect] Starting connection...');

    final token = await dioClient.getToken();
    if (token == null) {
      _isConnecting = false;
      throw Exception('Токен не найден. Выполните вход.');
    }

    final uri = Uri.parse(
      '$baseUrl/chat/connect_to_chat',
    ).replace(queryParameters: {'token': token});

    try {
      await _cleanup();
      _channel = WebSocketChannel.connect(uri);
      await Future.delayed(const Duration(milliseconds: 300));
      _wsSubscription = _channel!.stream.listen(
        (raw) {
          if (_isDisposed || _messageController.isClosed) return;
          try {
            final json = jsonDecode(raw as String);
            _messageController.add(MessageModel.fromJson(json));
          } catch (e) {
            debugPrint('❌ Parse error: $e');
          }
        },
        onError: (error) {
          debugPrint('⚠️ WS stream error: $error');
          _handleDisconnect();
        },
        onDone: () {
          debugPrint('🔌 WS stream closed by server');
          _handleDisconnect();
        },
        cancelOnError: false,
      );
      _isConnected = true;
      _isConnecting = false;
      debugPrint('✅ WS connected successfully');
    } catch (e) {
      debugPrint('❌ WS connection error: $e');
      _isConnecting = false;
      _isConnected = false;
      await _cleanup();
      rethrow;
    }
  }

  Future<void> _cleanup() async {
    debugPrint('🧹 [cleanup] Starting cleanup...');

    await _wsSubscription?.cancel();
    _wsSubscription = null;
    await _channel?.sink.close();
    _channel = null;

    _isConnected = false;
    _isConnecting = false;

    debugPrint('🧹 [cleanup] Done');
  }

  void sendMessage(String text) {
    if (!_isConnected || _channel == null || text.trim().isEmpty) {
      debugPrint(
        '⚠️ Cannot send: connected=$_isConnected, channel=${_channel != null}, text="${text.trim()}"',
      );
      return;
    }
    try {
      _channel!.sink.add(jsonEncode({'message': text.trim()}));
      debugPrint('📨 Sent: $text');
    } catch (e) {
      debugPrint('❌ WS send error: $e');
    }
  }

  void disconnect() {
    debugPrint('🔌 [disconnect] Manual disconnect requested');
    _cleanup();
  }

  void _handleDisconnect() {
    if (_isDisposed) return;
    debugPrint('🔌 [handleDisconnect] Called');
    _cleanup();
  }

  bool get isConnected => _isConnected;

  void dispose() {
    debugPrint('🗑️ [dispose] ChatService disposing');
    _isDisposed = true;
    _cleanup();
    if (!_messageController.isClosed) {
      _messageController.close();
    }
  }
}
