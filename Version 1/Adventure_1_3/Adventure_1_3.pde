/*
Adventure Game
Created by Biran4454
v1.3
build 4
19/02/2020
*/
/*
TODO:
  Add visible inventory
  Make inventory use an item class instead of String, with weight, type, name, etc.
*/
World world;
UI ui;
int blockSize;
void setup(){
  size(1200, 800);
  background(255);
  blockSize = 70;
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
  
  world.checkKeys();
  world.drawBlocks();
  world.drawPlayer();
  ui.drawNotifications();
}
