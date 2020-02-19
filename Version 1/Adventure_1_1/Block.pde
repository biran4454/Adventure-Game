public class Block{
  Block(int bX, int bY, int size){
    this.gX = bX * size;
    this.gY = bY * size;
    x = 0;
    y = 0;
    this.size = size;
    destroyed = false;
    hp = 10;
  }
  private int gX, gY, x, y, bX, bY, size, hp;
  public boolean destroyed;
  
  public void moveBlock(int posX, int posY){
    x = posX + gX;
    y = posY + gY;
  }
  public void drawBlock(){
    fill(200, 100, 70);
    rect(stpX(x), stpY(y), size, size);
  }
  public void mine(float amount){
    hp -= amount;
    if(hp <= 0){
      hp = 0;
      destroyed = true;
    }
  }
  
  private int stpX(int x){
    return(x + width / 2);
  }
  private int stpY(int y){
    return(y + height / 2);
  }
}
