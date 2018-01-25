/*
TableVoltageA mod from LP Ex 18-03
template for a Table to store voltage dc readings: time,volt,curr in local txt
or csv file;
Uses: Table functions, loadTable,new Table,set contents,print contents
*/

Table table;

void setup() 
{   size(200,100);
  //  table = new Table();
  //    // this makes header row (col names = keys) for the row vals
  //  table.addColumn("min");  // elapsed time
  //  table.addColumn("mV"); // V reading in mV
  //  table.addColumn("mA"); // curr reading in mA
  //  
  //    // makes new row entry and fills key:val slots (col slot, value to put there)
  //  TableRow newRow = table.addRow();
  //  newRow.setInt("min", table.lastRowIndex()); // what's the row # now in play
  //  newRow.setString("mV", "Vstring");
  //  newRow.setString("mA", "currStr");

  //saveTable(table, "data/new.csv");
  table = loadTable("data/new.csv", "header");  // file has header
}

// above code saves to a file called "new.csv" in sketchFolder/data/:
// min,mV,mA  with this as header (keys)
// 0,Vstring,currStr  and these vals in data row 0  

void draw()
{  background(21);
//  println(table.getRow(0).getInt(0)); // 1st data row, int in col 0, or
//  println(table.getString(1,2)); // get str at row 1, col 2
  String resultStr = "";
  for (TableRow row : table.rows()) 
  {  // 1st col is actually int but this works anyway, auto-unboxing ?
    String str = row.getString("min")+": "+row.getString("mV") + ": "+row.getString("mA");
    println(str); // each row gets one line printout
    resultStr += str + "\n"; // concat them for window printout
  }  // end for
  fill(255);
  if(resultStr != null) text(resultStr, 10, 20); // -- what,x,y location
  noLoop();  // just do it once
} // end draw

