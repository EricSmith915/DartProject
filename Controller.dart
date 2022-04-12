import 'Main.dart';
import 'WebClient.dart';
import 'ConsoleUI.dart';
import 'Board.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';

class Controller{

  //Main logic sequence of the program. Will lead the user through most of the
  //major steps
  start(){

    var defaultURL = "https://www.cs.utep.edu/cheon/cs3360/project/omok/info/";
    var ui = ConsoleUI();

    //Asks the user for information
    ui.showMessage("Welcome to omok game!");
    var url = ui.promptServer(defaultURL);

    ui.showMessage("Obtaining the server information...");

    var webClient = WebClient();
    webClient.accessWebService(url);



    //Todo: Make get info method
    //var info = webClient.getInfo();

    ui.showMessage("Chose which option you would like to select: 1.Smart 2.Random");
    var selection = ui.chooseOption(['R','S']);

    ui.showMessage('Creating new game with $selection');

    ui.board = Board(16);

    ui.showBoard();
    var indexes = ui.promptMove();

  }
}