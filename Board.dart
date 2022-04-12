import 'Main.dart';
import 'Controller.dart';
import 'WebClient.dart';
import 'ConsoleUI.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';

class Board{
  final size;
  var places;
  Board(this.size){
    places = List.generate(this.size, (i) => List(this.size), growable: false);
    for(int i = 0; i < this.size; i++){
      for(int j = 0; j < this.size; j++){
        places[i][j] = 0;
      }
    }
  }
  update(move, actor){
    places[move[0]][move[1]] = actor;
  }
}