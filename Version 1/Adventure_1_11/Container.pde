public class Container{
  Container(int x, int y, String name, color colour){
    bX = x;
    bY = y;
    this.name = name;
    contents = new List(width / 2, 50, width - (width / 2) + 50, height - 100);
    this.colour = colour;
    isInProximity = false;
    isOpen = false;
  }
  List contents;
  color colour;
  String name;
  int bX, bY;
  boolean isInProximity, isOpen;
  void addItems(ArrayList<Item> contents){
    this.contents.addItems(contents);
  }
  void check(int pX, int pY){
    if(pX == bX && pY == bY){
      ui.setKeyNotification("Press X to open");
      isInProximity = true;
    } else if(isInProximity){
      ui.deleteKeyNotification();
    }
    if(isInProximity && keyPressed && key == 'X'){
      isGamePaused = true;
      isOpen = true;
      contents.drawList();
    } // FINISH THIS!
  }
}
