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
  public int mineSpeed, moveSpeed, capacity;
  public ArrayList<Item> inventory;
  
  public void setAtt(String n, int mineSpeed, int moveSpeed, int capacity){
    name = n;
    this.mineSpeed = mineSpeed;
    this.moveSpeed = moveSpeed;
    this.capacity = capacity;
  }
  public boolean addItem(String itemName){
    Item add = new Item(itemName);
    if(calculateInventoryWeight() + add.weight > capacity){
      ui.addItemNotification("Inventory Full");
      return false;
    }
    inventory.add(add);
    ui.addItemNotification(itemName);
    return true;
  }
  public void drawPlayer(){
    fill(0, 30, 255);
    rect(width / 2, height / 2, size, size);
  }
  public void movePlayer(int x, int y, int blockSize){
    this.x += x;
    this.y += y;
    bX = floor(this.x / blockSize);
    bY = floor(this.y / blockSize);
  }
  public int calculateInventoryWeight(){
    Float[][] calculate = sortWeight(inventory);
    float total = 0;
    for(int i = 0; i < calculate[0][2]; i++){
      total += calculate[i][0] * calculate[i][1];
    }
    return int(total);
  }
  private Float[][] sortWeight(ArrayList<Item> items){
    ArrayList<Integer> result = new ArrayList<Integer>();
    ArrayList<Float> resultWeight = new ArrayList<Float>();
    
    for(Item item : items){
      boolean isDetected = false;
      for(int i = 0; i < resultWeight.size(); i++){
        if(item.weight == resultWeight.get(i)){
          result.set(i, result.get(i) + 1);
          isDetected = true;
          break;
        }
      }
      if(!isDetected){
        resultWeight.add(item.weight);
        result.add(1);
      }
    }
    Float[][] finish = new Float[resultWeight.size() + 1][3];
    for(int i = 0; i < result.size(); i++){
      finish[i][0] = resultWeight.get(i);
      finish[i][1] = float(result.get(i));
    }
    finish[0][2] = float(resultWeight.size());
    return(finish);
  }
}
