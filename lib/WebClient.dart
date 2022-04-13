//Eric Smith
//Programming Languages
//Dart Project
// 4/12/2022

import 'package:http/http.dart' as http;
import 'dart:convert';


class WebClient{

  //Accesses the web service and returns the json object.
  accessWebService(String url) async {
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var info = json.decode(response.body);

    return info;
  }

  //Creates a new game from the web server
  getNewGame(String url, int selection, options) async {
    var strategy = options['strategies'][selection];
    strategy = strategy.toLowerCase();
    url = url + "?strategy=" + strategy;
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var info = json.decode(response.body);

    return info;
  }

}