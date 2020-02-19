public class Player{
  Player(int x, int y, int blockSize){
    posX = x;
    posY = y;
    this.x = x + (60 / 2);
    this.y = y + (60 / 2);
    bX = floor(this.x / blockSize);
    bY = floor(this.y / blockSize);
  }
  public int posX, posY, x, y, bX, bY;
  
  public void drawPlayer(){
    fill(0, 30, 255);
    rect(width / 2, height / 2, 60, 60);
  }
  public void movePlayer(int x, int y, int blockSize){
    this.x += x;
    this.y += y;
    bX = floor(this.x / blockSize);
    bY = floor(this.y / blockSize);
    println("Player x: " + bX + "\nPlayer y: " + bY);
  }
}
