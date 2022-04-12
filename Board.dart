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
  Board(this.size);
}