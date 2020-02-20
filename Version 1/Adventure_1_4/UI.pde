public class UI{
  UI(){
    newItemNotifs = new ArrayList<NewItem>();
  }
  
  ArrayList<NewItem> newItemNotifs;
  
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
}
