import 'Main.dart';
import 'Controller.dart';
import 'ConsoleUI.dart';
import 'Board.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class WebClient{
  accessWebService(String url) async {
    print(0);
    var uri = Uri.parse(url);
    print(1);
    var response = await http.get(uri);
    print(2);
    var info = json.decode(response.body);

    print(info['strategies']);
    return info;
  }


  createNewGame(strategy){
    //implement
  }
}