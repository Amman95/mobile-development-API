import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) 
  {
    final decodedMessage = jsonDecode(message);
    final symbolName = decodedMessage['tick']['symbol'];
    final symbolPrice = decodedMessage['tick']['quote'];
    final serverTimeAsEpoch = decodedMessage['tick']['epoch'];
    // final tradeName = decodedMessage['active_symbols']['display_name'];
    // final tradeSymbol = decodedMessage['active_symbols']['symbol'];
    final serverTime = DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);

    // print('Trade Name : $tradeName, Trade Symbol : $tradeSymbol');

    print('Name : $symbolName, Price : $symbolPrice, Date: $serverTime');
  });

  print('Please Enter Symbol Name : ');
  final userInput = stdin.readLineSync();

  // channel.sink.add('{ "active_symbols": "brief", "product_type": "basic" }');
  channel.sink.add('{ "ticks": "$userInput", "subscribe": 1}');
}
