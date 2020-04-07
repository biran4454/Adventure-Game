public class World{
  World(int xSize, int ySize){
    this.xSize = xSize;
    this.ySize = ySize;
    blocks = new Block[xSize][ySize];
    secretContainers = new ArrayList<Container>();
    posX = 0;
    posY = 75;
    posBX = 0;
    posBY = 0;
  }
  public Block[][] blocks;
  public ArrayList<Container> secretContainers;
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
        int sumRare = 0;
        if(random >= 990){
          secretContainers.add(new Container(x, y, "Secret Container", color(255, 161, 0)));
        } else {
          for(TableRow row : itemData.rows()){
            if(random < (row.getInt("RARITY") + sumRare) && y >= row.getInt("MIN DEPTH")){
              blocks[x][y].setAtt(row.getString("NAME"), 1, row.getInt("HPINIT"));
              break;
            }
            sumRare += row.getInt("RARITY");
          }
        }
      }
    }
  }
  public void drawBlocks(){
    for(int x = 0; x < xSize; x++){
      for(int y = 0; y < ySize; y++){
        if(blocks[x][y] != null){
          Block block = blocks[x][y];
          block.moveBlock(posX, posY);
          block.drawBlock();
        }
      }
    }
    if(secretContainers.size() > 0){
      for(Container container : secretContainers){
        container.move(posX, posY);
        container.check(player.bX, player.bY);
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
    
    try{
      if(bX == -1){
        if(player.x % 70 == 0){
          boolean values[] = snap(bX, bY);
          playerYOver = values[1];
          blockA = blocks[playerX - 1][playerY];
        } else {
          return true;
        }
        if(playerYOver){
          blockB = blocks[playerX - 1][playerY + 1];
        }
      } else if(bX == 1){
        if(player.x % 70 == 0){
          boolean values[] = snap(bX, bY);
          playerYOver = values[1];
          blockA = blocks[playerX + 1][playerY];
        } else {
          return true;
        }
        if(playerYOver){
          blockB = blocks[playerX + 1][playerY + 1];
        }
      } else if(bY == -1){
        if(player.y % 70 == 0){
          boolean values[] = snap(bX, bY);
          playerXOver = values[0];
          blockA = blocks[playerX][playerY - 1];
        } else {
          return true;
        }
        if(playerXOver){
          blockB = blocks[playerX + 1][playerY - 1];
        }
      } else if(bY == 1){
        if(player.y % 70 == 0){
          boolean values[] = snap(bX, bY);
          playerXOver = values[0];
          blockA = blocks[playerX][playerY + 1];
        } else {
          return true;
        }
        if(playerXOver){
          blockB = blocks[playerX + 1][playerY + 1];
        }
      } else {
        error("moveCheck failed", "moveCheck FAILED - UNEXPECTED VALUES OF bX AND bY", false, 2);
        return false;
      }
    }
    catch(ArrayIndexOutOfBoundsException e){
      //error("No blocks exist here", "No blocks exist for the specified x- and y-coordinates", false, 3);
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
        if(!(blockA.destroyed || blockB.destroyed)){
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
  public boolean[] snap(int bX, int bY){
    int xOverAmount, yOverAmount;
    boolean playerXOver, playerYOver;
    if(abs(bX) == 1){
      yOverAmount = 0 - (((player.bY + 1) * blockSize) - (player.y + player.size)); //SORT SNAPPING
      if(yOverAmount > 0 && yOverAmount <= 20){
        move(0, 0 - yOverAmount);
      }
      if(yOverAmount >= (blockSize - 20) && yOverAmount < blockSize){
        move(0, blockSize - yOverAmount);
      }
    }
    if(abs(bY) == 1){
      xOverAmount = 0 - (((player.bX + 1) * blockSize) - (player.x + player.size)); //SORT SNAPPING
      if(xOverAmount > 0 && xOverAmount <= 20){
        move(0 - xOverAmount, 0);
      }
      if(xOverAmount >= (blockSize - 20) && xOverAmount < blockSize){
        move(blockSize - xOverAmount, 0);
      }
    }
    
    playerXOver = player.x + player.size > ((player.bX + 1) * blockSize);
    playerYOver = player.y + player.size > ((player.bY + 1) * blockSize);
    return(new boolean[] {playerXOver, playerYOver});
  }
  public void move(int x, int y){
    posX -= x;
    posY -= y;
    posBX = floor(posX / blockSize);
    posBY = floor(posY / blockSize);
    player.movePlayer(x, y, blockSize);
  }
}
