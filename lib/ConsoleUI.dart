//Eric Smith
//Programming Languages
//Dart Project
// 4/12/2022

import 'dart:io';
import 'dart:core';


//This class deals mainly with input and output throughout the program.
//Logic operations are not intended for his class.
class ConsoleUI{

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
  //Displays the options which the server provides
  int chooseOption(ui, options){

    var selection;
    var line;
    var validOption = false;

    //Loop which will keep asking for input until a valid selection is made
    while(validOption == false) {

      //Displays the strategy options which the server provides
      ui.showMessage("Chose which option you would like to select:");
      for(int i=0; i<options['strategies'].length;i++){
        var temp = (i+1).toString();
        ui.showMessage(("[" + temp + "] " + options['strategies'][i]));

      }

      //Prompts the user for selection and determines whethert the selection is valid
      try {
        line = stdin.readLineSync();
        selection = int.parse(line) - 1;

        if (selection >= 0 && selection < options['strategies'].length) {
          stdout.writeln('Creating a new ' + options['strategies'][selection] +
              ' game...');
          validOption = true;
        } else {
          stdout.writeln('Invalid selection');
        }
      }catch (FormatException){
        ui.showMessage("Error. Please enter an integer");
      }
    }

    return selection;
  }



  void showBoard(board){
    //Prints out the first line
    stdout.write("x  ");
    for(int i = 0; i < board.size; i++){
      stdout.write(((i+1) % 10).toString() + " ");
    }
    stdout.writeln();
    stdout.writeln("y ----------------------------------------------------------");
    //Prints out the board as a 2d array
    for(int i = 0; i < board.size; i++){
      stdout.write(((i+1) % 10).toString() + '| ');
      for(int j = 0; j < board.size; j++){
        stdout.write(board.places[i][j].toString() + " ");
      }
      stdout.writeln();
    }
  }


  //Method which will ask the user for input.
  promptMove(int size){
    var validSelect = false;
    var x, y;


    //Loop which will check if the user has made a valid selection.
    while(validSelect == false) {
      try {
        stdout.writeln("Enter move's X coordinate between 1 - " + size.toString());
        var inputX = stdin.readLineSync();
        x = int.parse(inputX);
        if(x > 0 && x < size + 1){
          validSelect = true;
        } else {
          stdout.writeln("Did not enter a valid selection. Try again");
        }
      } catch (FormatException) {
        stdout.writeln("Did not enter a valid selection. Try again");
      }
    }

    validSelect = false;
    while(validSelect == false) {
      try {
        stdout.writeln("Enter move's Y coordinate between 1 - " + size.toString());
        var inputY = stdin.readLineSync();
        y = int.parse(inputY);
        if(y > 0 && y < size + 1){
          validSelect = true;
        } else {
          stdout.writeln("Did not enter a valid selection. Try again");
        }
      } catch (FormatException) {
        stdout.writeln("Did not enter a valid selection. Try again");
      }
    }

    stdout.writeln("Move was well formed with coordinates X:" + x.toString() + " Y:" + y.toString());

    return [x-1, y-1];
  }

}