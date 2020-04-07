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
  boolean isInventoryShown;
  public void checkKeys(){
    if(keyPressed && key == 'c'){
      isGamePaused = true;
      isInventoryShown = true;
      inventory = new List(50, 50, width - 100, height - 100);
      inventory.addItems(world.player.inventory);
      inventory.drawList();
    }
    if(isGamePaused && isInventoryShown && (!keyPressed || key != 'c')){
      strokeWeight(1);
      isInventoryShown = false;
      isGamePaused = false;
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
  
  private String[][] sortItems(ArrayList<Item> items){
    ArrayList<Integer> result = new ArrayList<Integer>();
    ArrayList<String> resultNames = new ArrayList<String>();
    
    for(Item item : items){
      boolean isDetected = false;
      for(int i = 0; i < resultNames.size(); i++){
        if(item.type == resultNames.get(i)){
          result.set(i, result.get(i) + 1);
          isDetected = true;
          break;
        }
      }
      if(!isDetected){
        resultNames.add(item.type);
        result.add(1);
      }
    }
    String[][] finish = new String[resultNames.size()][3];
    for(int i = 0; i < result.size(); i++){
      finish[i][0] = resultNames.get(i);
      finish[i][1] = str(result.get(i));
    }
    finish[0][2] = str(resultNames.size());
    return(finish);
  }
  public void addItems(ArrayList<Item> items){
    source = items;
  }
  public void drawList(){
    fill(200, 200, 50);
    stroke(0);
    strokeWeight(15);
    rect(x, y, xSize, ySize);
    String[][] sorted = sortItems(source);
    for(int i = 0; i < int(sorted[0][2]); i++){
      String name = sorted[i][0];
      int amount = int(sorted[i][1]);
      fill(0);
      textSize(40);
      text(name, x + 30, y + 50 + i * 50);
      text(amount, x + 400, y + 50 + i * 50);
    }
  }
}
