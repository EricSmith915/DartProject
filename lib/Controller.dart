//Eric Smith
//Programming Languages
//Dart Project
// 4/12/2022

import 'WebClient.dart';
import 'ConsoleUI.dart';
import 'Board.dart';

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

    //Constructs a valid url which will be used to contact the server
    var pid = info['pid'];
    var playUrl = url + "play/?pid=" + info['pid'];

    //Initialization of variables which will be used in the main game loop.
    //This is done to ensure that they have wider scope.
    var moveResponse;
    var playerWin = false;
    var computerWin = false;
    var isDraw = false;
    var playerMove;
    var computerMove;

    //Enters a loop which requests move from player and accesses the web server
    //until the game is won
    while(playerWin == false && computerWin == false && isDraw == false) {
      //Shows the board to the player, asks for a move, and accesses the web
      //server
      ui.showBoard(gameBoard);
      ui.showMessage("Time to make a move!");
      var indexes = ui.promptMove(gameBoard.size);
      playUrl = playUrl + "&move=" + indexes[0].toString() + "," +
          indexes[1].toString();
      moveResponse = await webClient.accessWebService(playUrl);


      //Parses the web response by applying the player and computer moves to the board.
      computerMove = moveResponse['move'];
      if(moveResponse['response'] == true){
        playerMove = moveResponse['ack_move'];
        //Checks if the player has won the game or drawn.
        if(playerMove['isWin'] == true) {
          playerWin = true;
          gameBoard.update(indexes, 1);
          break;
        } else if (playerMove['isDraw'] == true){
          isDraw = true;
          break;
        }
        //Stores the computer move, and applies it the the visible game board.
        var computerIndexes = [0, 0];
        computerIndexes[0] = computerMove['x'];
        computerIndexes[1] = computerMove['y'];
        gameBoard.update(indexes, 1);
        gameBoard.update(computerIndexes, 2);

        //Checks if the computer has won and ends the game.
        if(computerMove['isWin'] == true){
          computerWin = true;
          break;
        }
      } else {
        //If the server responds that the mave was not true, no changes will be
        //made to the visible board.
        ui.showMessage("Move was not valid. Likely tried playing occupied space");
      }
    }

    var move;

    //Conditions which will end the game.
    if(playerWin){
      //Updates the winning locations to make them visible to the player
      for(int i = 0; i < 10; i+=2){
        move = [playerMove['row'][i], playerMove['row'][i+1]];
        gameBoard.update(move, 5);
      }

      ui.showBoard(gameBoard);
      ui.showMessage("Congratulations you've won!");
      exit(1);
    } else if(computerWin){
      for(int i = 0; i < 10; i+=2){
        move = [computerMove['row'][i], computerMove['row'][i+1]];
        gameBoard.update(move, 9);
      }

      ui.showBoard(gameBoard);
      ui.showMessage("You lost! Maybe next time.");
      exit(1);
    } else if(isDraw){
      ui.showBoard(gameBoard);
      ui.showMessage("Game has drawn! Everyone is a winner");
      exit(1);
    }
  }
}