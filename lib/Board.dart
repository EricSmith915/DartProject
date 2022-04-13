//Eric Smith
//Programming Languages
//Dart Project
// 4/12/2022

import 'dart:core';

class Board{
  final size;
  var places;

  //Constructor
  Board(this.size){
    //Generates a 2d list with all values set to 0. Size of the list is equal
    //to the board size
    places = List.generate(this.size, (i) => List(this.size), growable: false);
    for(int i = 0; i < this.size; i++){
      for(int j = 0; j < this.size; j++){
        places[i][j] = 0;
      }
    }
  }

  //Sets a value of the board to the specified player and location
  update(move, actor){
    places[move[1]][move[0]] = actor;
  }
}