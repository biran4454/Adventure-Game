class Item{
  Item(int id){
    price = -1;
    for(TableRow row : itemData.rows()){
      int test = row.getInt("ID");
      if(test == id){
        data = row;
        price = 0;
        break;
      }
    }
    if(price == -1){
      error("Failed to retrieve item data", "The requested data was not found in file \"itemData.csv\"", true, 1);
    } else {
      type = data.getString("NAME");
      price = data.getInt("PRICE");
      weight = data.getInt("WEIGHT");
    }
  }
  
  public String type;
  public int price, weight;
  public PImage icon;
  private TableRow data;
}
