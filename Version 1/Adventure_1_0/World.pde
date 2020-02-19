public class World{
  World(){
    blocks = new ArrayList<Block>();
    posX = 0;
    posY = 0;
  }
  public ArrayList<Block> blocks;
  public int posX, posY;
  private Player player;
  
  public void createPlayer(){
    player = new Player();
  }
  public void addBlock(int x, int y){
    blocks.add(new Block(x, y));
  }
  public void drawBlocks(int size){
    for(Block block : blocks){
      block.updateValues(posX, posY);
      block.drawBlock(size);
    }
  }
  public void drawPlayer(){
    player.drawPlayer();
  }
  public void move(int x, int y){
    posX -= x;
    posY -= y;
  }
}
