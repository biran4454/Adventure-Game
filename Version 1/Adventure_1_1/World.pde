public class World{
  World(int xSize, int ySize){
    this.xSize = xSize;
    this.ySize = ySize;
    blocks = new Block[xSize][ySize];
    posX = 75;
    posY = 0;
    posBX = 0;
    posBY = 0;
  }
  public Block[][] blocks;
  public int posX, posY, xSize, ySize, posBX, posBY;
  private Player player;
  
  public void createPlayer(){
    player = new Player(-75, 0, blockSize);
  }
  public void populateBlocks(){
    for(int x = 0; x < xSize; x++){
      for(int y = 0; y < ySize; y++){
        blocks[x][y] = new Block(x, y, blockSize);
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
  public boolean moveCheck(int bX, int bY){
    int playerX, playerY;
    playerX = player.bX;
    playerY = player.bY;
    Block block;
    try{
      block = blocks[playerX + bX][playerY + bY];
    }
    catch(ArrayIndexOutOfBoundsException e){
      println("ERROR: NO BLOCKS EXIST HERE");
      return true;
    }
    
    if(block.destroyed){
      return true;
    } else {
      block.mine(0.05);
      return false;
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
