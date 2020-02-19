public class Block{
  Block(int gX, int gY){
    this.gX = gX;
    this.gY = gY;
    x = 0;
    y = 0;
  }
  private int gX, gY, x, y;
  
  public void updateValues(int posX, int posY){
    x = posX + gX;
    y = posY + gY;
  }
  public void drawBlock(int size){
    fill(200, 100, 70);
    rect(stpX(x), stpY(y), size, size);
  }
  private int stpX(int x){
    return(x + width / 2);
  }
  private int stpY(int y){
    return(y + height / 2);
  }
}
