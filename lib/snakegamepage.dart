import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}
enum Direction{up,down,left,right}
class _SnakeGamePageState extends State<SnakeGamePage> {
  int row=20,column=20;
  List<int> borderlist=[10];
  List<int> snakePosition=[];
  int snakeHead=0;
  int score =0;
  late Direction direction;
  late int foodPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   startGame();
  }

  void startGame(){
    score=0;
    makeborder();
    generateFood();
    direction=Direction.right;
    snakePosition=[45,44,43];
    snakeHead=snakePosition.first;
    Timer.periodic(Duration(milliseconds: 300), (timer){
      updateSnake();
      if(checkCollision()){
        timer.cancel();
        showGameOverDialogue();
        
      }
    });
  }
  void showGameOverDialogue(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Score is $score"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            startGame();
          }, child: Text("Play Again"))
        ],
      );
    });
  }
  bool checkCollision(){
    if(borderlist.contains(snakeHead)) return true;
    if(snakePosition.sublist(1).contains(snakeHead)) return true;
    return false;
  }
  void generateFood(){
    foodPosition=Random().nextInt(row*column);
    if(borderlist.contains(foodPosition)){
      generateFood();
    }
  }
  void updateSnake(){
    setState(() {
      switch(direction){
        case Direction.up:
          snakePosition.insert(0, snakeHead-column);
          break;
        case Direction.down:
         snakePosition.insert(0, snakeHead+column);
          break;
        case Direction.left:
          snakePosition.insert(0, snakeHead-1);
          break;
        case Direction.right:
          snakePosition.insert(0, snakeHead+1);
          break;
      }
      
    });
    if(snakeHead==foodPosition){
      score++;
      generateFood();
    }else{
      snakePosition.removeLast();
    }
    snakeHead=snakePosition.first;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    body: Column(
      children: [
        Expanded(child: _buildGameView()),
        Container(
          height: MediaQuery.of(context).size.height*0.5,
          child: _buildGameControls()),
      ],),
    );
  }
  Widget _buildGameView(){
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: column), itemCount: row*column,itemBuilder: (context,index){
      return Container(
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: fillBoxColor(index)),
      );
    });
  }

  Widget _buildGameControls(){
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score : ${score}",style: TextStyle(color: Colors.white,),),
          IconButton(onPressed: (){
            if(direction!=Direction.down){
              direction=Direction.up;
            }
          }, icon: Icon(Icons.arrow_circle_up,color: Colors.white,),iconSize: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){
                if(direction!=Direction.right){
                  direction=Direction.left;
                }
              }, icon: Icon(Icons.arrow_circle_left_outlined,color: Colors.white,),iconSize: 100,),
               IconButton(onPressed: (){
                if(direction!=Direction.left){
                  direction=Direction.right;
                }
               }, icon: Icon(Icons.arrow_circle_right_outlined,color: Colors.white,),iconSize: 100),
            ],
          ),
         
          IconButton(onPressed: (){
            if(direction!=Direction.up){
                  direction=Direction.down;
                }
          }, icon: Icon(Icons.arrow_circle_down,color: Colors.white,),iconSize: 100,),

        ],),
    );
  }

  Color fillBoxColor(int index){
    if(borderlist.contains(index)) 
      return Colors.yellow;
    else{
      if(snakePosition.contains(index)){
        if(snakeHead==index){
        return Colors.green;
        }else{
          return Colors.white.withOpacity(0.9);
        }
      }else{
        if(index==foodPosition){
          return Colors.red;
        }
      }
    }
      return Colors.grey.withOpacity(0.05);
  }
  makeborder(){
    for(int i=0;i<column;i++){
      if(!borderlist.contains(i)){
        borderlist.add(i);
      }
    }
    for(int i=0;i<row*column;i=i+column){
      if(!borderlist.contains(i)){
        borderlist.add(i);
      }
    }
    for(int i=column-1;i<row*column;i=i+column){
      if(!borderlist.contains(i)){
        borderlist.add(i);
      }
    }
    for(int i=(column*column)-column;i<row*column;i++){
      if(!borderlist.contains(i)){
        borderlist.add(i);
      }
    }
  }
}