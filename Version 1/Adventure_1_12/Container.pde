public class Container{
  Container(int x, int y, String name, color colour){
    bX = x;
    bY = y;
    this.name = name;
    contents = new List(width / 2, 50, width - (width / 2) + 50, height - 100);
    this.colour = colour;
    isInProximity = false;
    isOpen = false;
    isKeyStillPressed = false;
    this.x = 0;
    this.y = 0;
  }
  List contents;
  color colour;
  String name;
  int bX, bY, x, y;
  boolean isInProximity, isOpen, isKeyStillPressed;
  void addItems(ArrayList<Item> contents){
    this.contents.addItems(contents);
  }
  void move(int posX, int posY){
    x = (bX * blockSize) + posX;
    y = (bY * blockSize) + posY;
  }
  void check(int pX, int pY){
    fill(colour);
    rect(stpX(x), stpY(y), blockSize, blockSize);
    if(pX == bX && pY == bY && !isOpen && !isKeyStillPressed){
      ui.setKeyNotification("Press X to open");
      isInProximity = true;
    } else if(isInProximity){
      ui.deleteKeyNotification();
    }
    if(isInProximity && keyPressed && key == 'x'){
      println("Container open");
      isGamePaused = true;
      isKeyStillPressed = true;
      isOpen = true;
    }
    if(isOpen){
      contents.drawList();
    }
    if(isKeyStillPressed && !(keyPressed && key == 'x')){
      println("Key unpressed");
      isKeyStillPressed = false;
    }
    if(isOpen && !isKeyStillPressed && keyPressed && key == 'x'){
      println("Container closed");
      isOpen = false;
      isGamePaused = false;
      stroke(1);
    }
  }
  private int stpX(int x){
    return(x + width / 2);
  }
  private int stpY(int y){
    return(y + height / 2);
  }
}
