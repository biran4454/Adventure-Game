public class UI{
  UI(){
    newItemNotifs = new ArrayList<NewItem>();
  }
  
  ArrayList<NewItem> newItemNotifs;
  List inventory;
  
  public void addItemNotification(String text){
    newItemNotifs.add(new NewItem(text));
  }
  public void drawNotifications(){
    for(int i = newItemNotifs.size() - 1; i > -1; i--){
      NewItem notification = newItemNotifs.get(i);
      notification.drawNotification();
      if(notification.done){
        newItemNotifs.remove(i);
      }
    }
  }
  public void checkKeys(){
    if(keyPressed && key == 'c'){
      isGamePaused = true;
      inventory = new List(50, 50, width - 100, height - 100);
      inventory.addItems(world.player.inventory);
      inventory.drawList();
    }
  }
}
public class NewItem{
  NewItem(String text){
    x = width / 2 + 20;
    y = height / 2 - 20;
    time = 0;
    this.text = text;
    done = false;
  }
  
  private String text;
  private int x, y, time;
  public boolean done;
  
  public void drawNotification(){
    if(time >= 100){
      done = true;
    }
    time += 3;
    y = ((height / 2) - 20) - time / 3;
    textSize(30);
    fill(170, 170, 0);
    text(text, x, y);
  }
}
public class List{
  List(int x, int y, int xSize, int ySize){
    this.x = x;
    this.y = y;
    this.xSize = xSize;
    this.ySize = ySize;
    source = new ArrayList<Item>();
  }
  private int x, y, xSize, ySize;
  private ArrayList<Item> source;
  
  public void addItems(ArrayList<Item> items){
    source = items;
  }
  public void drawList(){
    fill(200, 200, 50);
    stroke(0);
    strokeWeight(15);
    rect(x, y, xSize, ySize);
    for(int i = 0; i < source.size(); i++){
      Item item = source.get(i);
      fill(0);
      textSize(40);
      text(item.type, x + 30, y + 50 + i * 50);
    }
  }
}
