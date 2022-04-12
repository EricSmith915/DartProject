import 'Main.dart';
import 'Controller.dart';
import 'ConsoleUI.dart';
import 'Board.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class WebClient{
  accessWebService(String url) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var info = json.decode(response.body);

    return info;
  }

  getNewGame(String url, int selection, options) async {
    var strategy = options['strategies'][selection - 1];
    strategy = strategy.toLowerCase();
    url = url + "?strategy=" + strategy;
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var info = json.decode(response.body);

    return info;
  }

}