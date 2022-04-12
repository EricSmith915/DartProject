import 'Main.dart';
import 'Controller.dart';
import 'WebClient.dart';
import 'Board.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:core';


//This class deals mainly with input and output throughout the program.
//Logic operations are not intended for his class.
class ConsoleUI{
  var board;

  void showMessage(msg){
    print(msg);
  }

  //Method which asks the user for url
  String promptServer(String defaultUrl){
    print("Enter server url (Default: [$defaultUrl])");
    defaultUrl = stdin.readLineSync();

    return defaultUrl;
  }

  //Method which asks the user for which type of game they would like to play
  int chooseOption(options){
    var line = stdin.readLineSync();
    var selection = int.parse(line);
    var validOption = false;

    //Loop which will keep asking for input until a valid selection is made
    while(validOption == false) {
      if (selection == 1) {
        stdout.writeln('Creating a new game...');
        validOption = true;
      } else if (selection == 2) {
        stdout.writeln('Creating a new game...');
        validOption = true;
      } else {
        stdout.writeln('Invalid selection');
      }
    }

    return selection;
  }

  void showBoard(){

  }

  //Method which will ask the user for input.
  promptMove(){
    var validSelect = true;
    var x, y;

    //Loops until the user makes a valid user input
    while(validSelect) {
      try {
        stdout.writeln('Enter X');
        var selectX = stdin.readLineSync();
        x = int.parse(selectX);
        validSelect = false;
      } catch(FormatException) {
        stdout.writeln("Enter a valid selection");
      }
    }

    validSelect = true;
    while(validSelect) {
      try {
        stdout.writeln('Enter Y');
        var selectY = stdin.readLineSync();
        y = int.parse(selectY);
        validSelect = false;
      } catch(FormatException) {
        stdout.writeln("Enter a valid selection");
      }
    }

    return [x, y];
  }

}