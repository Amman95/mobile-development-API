import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:io';
import 'tick-history.dart';

bool activeSymbol() {
    final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

    channel.stream.listen((message) {
    final decodedMessage1 = jsonDecode(message);
    final activeSymbol = decodedMessage1['active_symbols'];

    print('---------------------------------------');
    print ('List of Active Symbols');
    print('');

    for(int i = 0; i < 10; i++) {
      var marketName = activeSymbol[i]['display_name'];
      var marketSymbol = activeSymbol[i]['symbol'];

      if(activeSymbol[i]['exchange_is_open'] == 0) {
        print('Market Name   : $marketName');
        print('Market Symbol : $marketSymbol');
        print('Market Status : CLOSED');
        print('');
      } else {
        print('Market Name   : $marketName');
        print('Market Symbol : $marketSymbol');
        print('Market Status : OPEN');
        print('');
      }
    }
    channel.sink.close();
    print('');
    
    print('---------------------------------------');
    print('Please Enter Market Symbol : ');
    final userInput = stdin.readLineSync();

    print('');
    print('');
    print('---------------------------------------');
    print ('Tick History');
    getTick(userInput);
    
    });
    channel.sink.add('{ "active_symbols": "brief", "product_type": "basic" }');
    return true;
}