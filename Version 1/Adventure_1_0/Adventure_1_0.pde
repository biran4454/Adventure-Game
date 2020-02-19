/*
Adventure Game
Created by Biran4454
v1.0
build 1
16/02/2020
*/
/*
TODO:
  Make centre of blue square centre of screen
  Work in tile co-ordinates
  Use two dimentional arrayList
  Add block destroyed property to skip maths, but don't delete.
  Use two dimentional fixed array?
  
*/
World world;
void setup(){
  size(1200, 800);
  background(255);
  world = new World();
  world.createPlayer();
  int size = 70;
  for(int x = 0; x < size * 100; x += size){
    for(int y = 0; y < size * 100; y += size){
      world.addBlock(x, y);
    }
  }
}
void draw(){
  background(255);
  if(keyPressed){
    switch(keyCode){
      case 37: world.move(-2, 0); break; // Left
      case 38: if(world.posY <= 70){world.move(0, -1);} break; // Up
      case 39: world.move(2, 0); break; // Right
      case 40: world.move(0, 1); break; // Down
    }
  }
  
  world.drawBlocks(70);
  world.drawPlayer();
}
