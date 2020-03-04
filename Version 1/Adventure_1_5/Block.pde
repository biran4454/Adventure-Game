public class Block{
  Block(int bX, int bY, int size){
    this.gX = bX * size;
    this.gY = bY * size;
    x = 0;
    y = 0;
    this.size = size;
    destroyed = false;
    hp = 50;
    type = "";
  }
  private int gX, gY, x, y, size, hp;
  public boolean destroyed;
  public String type;
  public int  mine;
  
  public void setAtt(String type, int mine, int hp){
    this.type = type;
    this.mine = mine;
    this.hp = hp;
  }
  public void setAtt(int mine, int hp){
    this.mine = mine;
    this.hp = hp;
  }
  public void moveBlock(int posX, int posY){
    x = posX + gX;
    y = posY + gY;
  }
  public void drawBlock(){
    stroke(200, 200, 0);
    if(type == "Iron Ore"){
      fill(160);
    } else if(type == "Coal"){
      fill(60);
    }
    else {
      fill(200, 100, 70);
    }
    rect(stpX(x), stpY(y), size, size);
  }
  public void mine(float amount){
    hp -= amount;
    if(hp <= 0){
      hp = 0;
      destroyed = true;
      if(type == "Iron Ore"){
        world.player.addItem("Iron Ore", 2);
      } else if(type == "Coal"){
        world.player.addItem("Coal", 1);
      }
    }
  }
  
  private int stpX(int x){
    return(x + width / 2);
  }
  private int stpY(int y){
    return(y + height / 2);
  }
}
