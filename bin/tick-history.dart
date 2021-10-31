import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void getTick(String? userInput) {
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');
    
  channel.stream.listen((tick) {
  final decodedMessage = jsonDecode(tick);
  final symbolName = decodedMessage['tick']['symbol'];
  final symbolPrice = decodedMessage['tick']['quote'];
  final serverTimeAsEpoch = decodedMessage['tick']['epoch'];

  final serverTime = DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);

  print('Name : $symbolName, Price : $symbolPrice, Date: $serverTime');
  });

  channel.sink.add('{ "ticks": "$userInput", "subscribe": 1}');
}