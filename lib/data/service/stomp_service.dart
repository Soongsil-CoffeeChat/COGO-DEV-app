import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class StompService {
  StompClient? _client;
  bool _isConnected = false;

  void connect({
    required String accessToken,
    required int roomId,
    required void Function(Map<String, dynamic>) onMessage,
  }) {
    _client = StompClient(
      config: StompConfig(
        url: dotenv.get('chat_url'),
        onConnect: (StompFrame frame) {
          print('✅ STOMP connected');
          _isConnected = true;

          _client?.subscribe(
            destination: '/topic/room.$roomId',
            callback: (frame) {
              if (frame.body != null) {
                final json = jsonDecode(frame.body!);
                onMessage(json);
              }
            },
          );
        },
        beforeConnect: () async {
          print('🕐 Connecting to STOMP server...');
        },
        onDisconnect: (_) {
          _isConnected = false;
          print('🛑 STOMP disconnected');
        },
        onWebSocketError: (error) {
          _isConnected = false;
          print('❌ WebSocket error: $error');
        },
        stompConnectHeaders: {
          'Authorization': 'Bearer $accessToken',
        },
        reconnectDelay: const Duration(seconds: 5),
      ),
    );

    _client?.activate();
  }

  void send({
    required int roomId,
    required String message,
  }) {
    if (!_isConnected) {
      print('❌ STOMP not connected. Message not sent.');
      return;
    }

    final body = jsonEncode({
      'roomId': roomId,
      'message': message,
    });

    _client?.send(
      destination: '/app/chat.sendMessage',
      body: body,
    );
  }

  void disconnect() {
    _isConnected = false;
    _client?.deactivate();
  }
}
