import 'package:loan_management/core/constant/app_string.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  late io.Socket socket;

  void connectSocket(String chatId, Function(dynamic) onMessageReceived) {
    socket = io.io(
      AppStrings.chatBaseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setReconnectionAttempts(3)
          .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      print('Connected to Socket.io ✅');
      socket.emit('join', chatId);
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.io ❌');
    });

    socket.onError((error) {
      print('Socket error: $error ❗');
    });
    socket.onConnectError((error) {
      print('Connection error: $error ❗');
    });
    socket.on('receiveMessage', (data) {
      onMessageReceived(data);
    });
  }

  void sendMessage(String receiverId, String message) {
    socket.emit('sendMessage', {
      "senderId": Supabase.instance.client.auth.currentUser?.id,
      "recipientId": receiverId,
      "message": message,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void disconnectSocket() {
    socket.disconnect();
  }
}
