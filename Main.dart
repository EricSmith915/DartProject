
import 'Controller.dart';
import 'WebClient.dart';
import 'ConsoleUI.dart';
import 'Board.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';

void main(){
  //Starts sequence for whole program
  var controller = new Controller();
  controller.start();
}