Table data = loadTable("ItemData.csv", "header");
for(TableRow row : data.rows()){
  println("Mined mineral.");
  String test = row.getString("DESCRIPTION");
  println(test);
  println(test == "Mined mineral.");
  println();
}
