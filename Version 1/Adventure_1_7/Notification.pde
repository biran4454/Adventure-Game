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
