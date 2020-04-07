/*
Adventure Game
Created by Biran4454
v1.8
03/04/2020
*/
/*
TODO:
  Sort inventory
  Problem: player overlaps left tiles whem moving left. Solution: Re check position after moving and go BACK a certain amount if necessary. Actually, no, but it gets worse if you speed up playerSpeed.
  ADD COMMENTS!!!!
*/
World world;
UI ui;
int blockSize;
Table itemData;
String errorText, errorDesc;
boolean isError, isErrorFatal;

boolean isGamePaused;
void setup(){
  size(1200, 800);
  background(255);
  blockSize = 70;
  errorText = "";
  errorDesc = "";
  isErrorFatal = false;
  isError = false;
  isGamePaused = false;
  itemData = loadTable("ItemData.csv", "header");
  
  ui = new UI();
  world = new World(100, 100);
  world.createPlayer();
  world.populateBlocks();
  /*for(int x = 0; x < size * 100; x += size){
    for(int y = 0; y < size * 100; y += size){
      world.addBlock(x, y);
    }
  }*/
}
void draw(){
  background(255);
  if(!isGamePaused){
    world.checkKeys();
  }
  world.drawBlocks();
  world.drawPlayer();
  ui.drawNotifications();
  ui.checkKeys();
  if(isError){
    println("ERROR: " + errorText);
    if(isErrorFatal){
      textSize(50);
      fill(255, 0, 0);
      text("FATAL ERROR: " + errorText, 30, height / 2);
      noLoop();
    } else {
      textSize(15);
      fill(150, 150, 0);
      text("Error: " + errorText, 10, 50);
    }
  }
}

void error(String error, String description, boolean isFatal, int id){
  println("******");
  println("ERROR: " + error);
  println("ID: " + id);
  println(description);
  println("******");
  errorText = error;
  errorDesc = description;
  isErrorFatal = isFatal;
  isError = true;
}
