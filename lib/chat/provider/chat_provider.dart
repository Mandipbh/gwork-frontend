import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/shared_preference_data.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../model/get_chat.dart';
import '../model/message_model.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> _allMessages = [];
  int _pageCount = 1;
  Socket? socket;
  bool _isLoading = true;

  bool getIsLoading() => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Message> getChatData() => _allMessages;

  //STEP2: Add this function in main function in main.dart file and add incoming data to the stream
  Future<void> connectAndListen(String jobId, String userId) async {
    if (!_isLoading) {
      setIsLoading(true);
    }
    print("opponent :: $userId");
    socket = io(
        'https://gwork.macca.cloud/connection',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setQuery({
          'token': "Bearer ${await SharedPreferenceData().getToken()}",
          'job_id': jobId,
          'to_user_id': userId,
        }) // optional
            .build());

    socket!.onConnect((_) {
      socket!.emit("load message", {
        'page_number': 1,
        'page_size': 10,
      });
      socket!.on('receive message', (data) {
        print('receive data:: $data');
        ClassGetChat chat = ClassGetChat.fromJson(data);
        addMessages(chat.message ?? [], true);
        if (chat.message!.isNotEmpty) {
          _pageCount = _pageCount + 1;
        }
      });
      setIsLoading(false);
    });

    socket!.on('chat message', (data) {
      print('chat data:: $data');
      ClassGetChat chat = ClassGetChat.fromJson(data);

      addMessages(chat.message ?? [], false);
    });

    socket!.onDisconnect((_) => print('disconnected the socket'));
  }

  void sendMessage(String message) {
    socket!.emitWithAck(
        "chat message",
        [
          {'message': message}
        ],
        ack: (data) => print(data));
  }

  void disconnectSocket() {
    if (!socket!.disconnected) {
      socket!.clearListeners();
      socket!.disconnect();
    }
    _pageCount = 1;
    _isLoading = true;
    _allMessages.clear();
  }

  getMoreMessages() {
    print('getMore Called');
    socket!.emit("load message", {
      'page_number': _pageCount,
      'page_size': 10,
    });
  }

  addMessages(List<Message> list, bool reverse) {
    if (_pageCount == 1) {
      _allMessages = [];
    }
    if (reverse) {
      _allMessages.insertAll(0, list);
    } else {
      _allMessages.addAll(list);
    }
    notifyListeners();
  }
}
