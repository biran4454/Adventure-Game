class Item{
  Item(String type){
    this.type = type;
    price = -1;
    for(TableRow row : itemData.rows()){
      if(row.getString("NAME") == type){
        data = row;
        price = 0;
        break;
      }
    }
    if(price == -1){
      error("Failed to retrieve item data", "The requested data was not found in file \"itemData.csv\"", true, 1);
    } else {
      price = data.getInt("PRICE");
      weight = data.getInt("WEIGHT");
    }
  }
  
  public String type;
  public int price, weight;
  public PImage icon;
  private TableRow data;
}
