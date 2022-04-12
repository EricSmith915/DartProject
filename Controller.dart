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
  start() async{

    var defaultURL = "https://www.cs.utep.edu/cheon/cs3360/project/omok/";
    var ui = ConsoleUI();

    //Asks the user for  regarding website information
    ui.showMessage("Welcome to omok game!");

    var url;
    try {
      url = ui.promptServer(defaultURL);
    } catch(e){
      ui.showMessage("Could not connect to server. Terminating program");
      exit(0);
    }
    ui.showMessage("Obtaining the server information...");

    //Accesses first section of the website, info, which will
    //access the elements and information of the game
    var webClient = WebClient();
    var infoUrl = url + "info/";
    var options;
    var gameBoard;
    try {
      options = await webClient.accessWebService(infoUrl);
      gameBoard = Board(options['size']);
    } catch(e){
      ui.showMessage("Could not connect to server. Terminating program");
      exit(0);
    }

    //Methods which will handle input
    var selection = ui.chooseOption(ui, options);

    //Instantiates the new section of the server and subsequent logic
    var newUrl = url + "new/";
    var info = await webClient.getNewGame(newUrl, selection, options);
    ui.showMessage("New game successfully created! Game ID = " + info['pid']);

    var pid = info['pid'];
    var playUrl = url + "play/?pid=" + info['pid'];

    var moveResponse;
    var playerWin = false;
    var computerWin = false;
    var playerMove;
    var computerMove;

    //Enters a loop which requests move from player and accesses the web server
    //until the game is won
    while(playerWin == false && computerWin == false) {
      ui.showBoard(gameBoard);
      ui.showMessage("Time to make a move!");
      var indexes = ui.promptMove(gameBoard.size);
      playUrl = playUrl + "&move=" + indexes[0].toString() + "," +
          indexes[1].toString();
      moveResponse = await webClient.accessWebService(playUrl);


      computerMove = moveResponse['move'];

      if(moveResponse['response'] == true){
        playerMove = moveResponse['ack_move'];
        if(playerMove['isWin'] == true) {
          playerWin = true;
          gameBoard.update(indexes, 1);
          break;
        }
        var computerIndexes = [0, 0];
        computerIndexes[0] = computerMove['x'];
        computerIndexes[1] = computerMove['y'];

        gameBoard.update(indexes, 1);
        gameBoard.update(computerIndexes, 2);
        if(computerMove['isWin'] == true){
          computerWin = true;
          break;
        }
      } else {
        ui.showMessage("Move was not valid. Likely tried playing occupied space");
      }
    }

    var move;
    if(playerWin){
      for(int i = 0; i < 10; i+=2){
        move = [playerMove['row'][i], playerMove['row'][i+1]];
        gameBoard.update(move, 5);
      }

      ui.showBoard(gameBoard);
    } else if(computerWin){
      for(int i = 0; i < 10; i+=2){
        move = [computerMove['row'][i], computerMove['row'][i+1]];
        gameBoard.update(move, 9);
      }

      ui.showBoard(gameBoard);
    }
  }
}