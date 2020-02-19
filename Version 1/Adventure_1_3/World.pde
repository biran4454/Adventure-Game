public class World{
  World(int xSize, int ySize){
    this.xSize = xSize;
    this.ySize = ySize;
    blocks = new Block[xSize][ySize];
    posX = 0;
    posY = 75;
    posBX = 0;
    posBY = 0;
  }
  public Block[][] blocks;
  public int posX, posY, xSize, ySize, posBX, posBY;
  public Player player;
  
  public void createPlayer(){
    player = new Player(0, -75, blockSize);
    player.setAtt("Kiran", 5, 5);
  }
  public void populateBlocks(){
    for(int x = 0; x < xSize; x++){
      for(int y = 0; y < ySize; y++){
        blocks[x][y] = new Block(x, y, blockSize);
        int random = int(random(1000));
        if(random < 150){
          blocks[x][y].setAtt("Coal", 1, 70);
        } else if(random < 200){
          blocks[x][y].setAtt("Iron", 1, 100);
        }
      }
    }
  }
  /*public void addBlock(int x, int y){
    blocks.add(new Block(x, y));
  }*/
  public void drawBlocks(){
    for(int x = 0; x < xSize; x++){
      for(int y = 0; y < ySize; y++){
        Block block = blocks[x][y];
        if(!block.destroyed){
          block.moveBlock(posX, posY);
          block.drawBlock();
        }
      }
    }
  }
  public void drawPlayer(){
    player.drawPlayer();
  }
  public void checkKeys(){
    int moveSpeed = player.moveSpeed;
    if(keyPressed){
      switch(keyCode){
        case 37: if(moveCheck(-1, 0)){
          move(-2 * moveSpeed, 0);
        } 
        break; // Left
        
        case 38: if(posY <= 70 && moveCheck(0, -1)){
          move(0, -1 * moveSpeed);
        } 
        break; // Up
        
        case 39: if(moveCheck(1, 0)){
          move(2 * moveSpeed, 0);
        }
        break; // Right
        
        case 40: if(moveCheck(0, 1)){
          move(0, moveSpeed);
        } 
        break; // Down
      }
    }
  }
  public boolean moveCheck(int bX, int bY){
    int playerX, playerY;
    boolean playerYOver, playerXOver;
    playerX = player.bX;
    playerY = player.bY;
    Block blockA, blockB;
    blockB = null;
    playerXOver = player.x + player.size > (player.bX + 1) * blockSize;
    playerYOver = player.y + player.size > (player.bY + 1) * blockSize;
    try{
      if(bX == -1){
        blockA = blocks[playerX][playerY];
        if(playerYOver){
          blockB = blocks[playerX][playerY + 1];
        }
      } else if(bX == 1){
        blockA = blocks[playerX + 1][playerY];
        if(playerYOver){
          blockB = blocks[playerX + 1][playerY + 1];
        }
      } else if(bY == -1){
        blockA = blocks[playerX][playerY];
        if(playerXOver){
          blockB = blocks[playerX + 1][playerY];
        }
      } else if(bY == 1){
        blockA = blocks[playerX][playerY + 1];
        if(playerXOver){
          blockB = blocks[playerX + 1][playerY + 1];
        }
      } else {
        println("ERROR: moveCheck FAILED - UNEXPECTED VALUES OF bX AND bY");
        return false;
      }
    }
    catch(ArrayIndexOutOfBoundsException e){
      println("ERROR: NO BLOCKS EXIST HERE");
      return true;
    }
    int mineSpeed = player.mineSpeed;
    if(blockB == null){
      if(blockA.destroyed){
        return true;
      } else {
        if(! blockA.destroyed){
          blockA.mine(mineSpeed);
        }
        return false;
      }
    } else {
      if(blockA.destroyed && blockB.destroyed){
        return true;
      } else {
        if(blockA.destroyed == false && blockB.destroyed == true){
          blockA.mine(mineSpeed * 0.7);
          blockB.mine(mineSpeed * 0.7);
        } else if(! blockA.destroyed){
          blockA.mine(mineSpeed);
        } else if(! blockB.destroyed){
          blockB.mine(mineSpeed);
        }
        return false;
      }
    }
  }
  public void move(int x, int y){
    posX -= x;
    posY -= y;
    posBX = floor(posX / blockSize);
    posBY = floor(posY / blockSize);
    player.movePlayer(x, y, blockSize);
  }
}
