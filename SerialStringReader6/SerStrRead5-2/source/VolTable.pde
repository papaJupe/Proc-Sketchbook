/*
class for Table objects to hold time,volt,curr values

*/

public class VolTable extends Table
 // do I need any instance vars? like date() to name it
 // so far seems to get all meths from super, without invoking it
 {
 // constructor puts things in header row
VolTable()  // could input params for customizing keys
    {
      //super(); // not sure what this gives me or if needed
      addColumn("min");  // elapsed time
      addColumn("mV"); // V reading in mV
      addColumn("mA"); // curr reading in mA
    
    }  // end constr
} // end class

  //  table = new Table();
  //  make header row (col names = keys) with the key vals
  //  table.addColumn("min");  // elapsed time
  //  table.addColumn("mV"); // V reading in mV
  //  table.addColumn("mA"); // curr reading in mA
  //  these meths inherited? usable
  //    // makes new row entry and fills key:val slots (col slot, value to put there)
  //  TableRow newRow = table.addRow();
  //  newRow.setInt("min", table.lastRowIndex()); // what's the row # now in play
  //  newRow.setString(1, "Vstring"); // can put col# or key value here
  //  newRow.setString("mA", "currStr");

  // saveTable(table, "data/new.csv");
  // above code saves to a file called "new.csv" in sketchFolder/data/:
  // min,mV,mA  with this as header (keys)
  // 0,Vstring,currStr  and these vals in data row 0
  //tab = loadTable("data/new.csv", "header");  // file has header
