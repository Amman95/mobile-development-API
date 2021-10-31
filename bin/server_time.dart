import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'active-symbol.dart';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) 
  {
    final decodedMessage = jsonDecode(message);
    final serverTimeAsEpoch = decodedMessage['time'];
    final serverTime = DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);

    print('Server Date and Time : $serverTime');
    print('');

    channel.sink.close();
    activeSymbol();
  });

  channel.sink.add('{"time": 1}');
}