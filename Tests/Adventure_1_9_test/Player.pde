public class Player{
  Player(int x, int y, int blockSize){
    this.x = x;
    this.y = y;
    bX = floor(this.x / blockSize);
    bY = floor(this.y / blockSize);
    size = 70;
    mineSpeed = 1;
    moveSpeed = 1;
    name = "---";
    inventory = new ArrayList<Item>();
  }
  public int x, y, bX, bY, size;
  public String name;
  public int mineSpeed, moveSpeed;
  public ArrayList<Item> inventory;
  
  public void setAtt(String n, int mineSpeed, int moveSpeed){
    name = n;
    this.mineSpeed = mineSpeed;
    this.moveSpeed = moveSpeed;
  }
  public void addItem(String itemName){
    inventory.add(new Item(itemName));
    ui.addItemNotification(itemName);
  }
  public void drawPlayer(){
    fill(0, 30, 255);
    rectMode(CENTER);
    rect(width / 2, height / 2, size, size);
    //rectMode(CORNER);
  }
  public void movePlayer(int x, int y, int blockSize){
    this.x += x;
    this.y += y;
    bX = floor(this.x / blockSize);
    bY = floor(this.y / blockSize);
  }
}
