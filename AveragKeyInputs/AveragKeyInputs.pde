/* Averaging iJava--> Proc needed many adaptations, difficult input, can't use
* Scanner ?
*/
int count = 0;       // number of input values
double sum = 0.0;    // sum of input values
String str = "";
String temp= "";

PFont f;

void setup()
{  
  size(400, 200); 
  f = createFont("Georgia", 24);
  textFont(f);
  frameRate = 15;
  println("type some numbers to average, commas between:");
}

void draw()  // want to repeat after each averaging
{
  if (str != "")
    {
      // if there's an input str, parse it, and average
  
      String next = str;  // the full line
      count = 0;       // clear these guys
      sum = 0.0;
  
      println("got a line " + next);
      String[] fields = next.split(",");  // split at commas, put pcs in array    
      double[] vals = new double[fields.length]; // array of doubles same size
      for (int i = 0; i < fields.length; i++)
        {    // parse the pcs and fill the array
          vals[i] = Double.parseDouble(fields[i]);
          // add each value to sum
          sum += vals[i];
          count++;
        }  // end for
  
      // compute the average
      double average = (sum / count);
  
      // print results, printf by itself fails for flt or dubl
      System.out.printf("Average is %5.3f\n", average);
      str = ""; 
      System.out.println("type some numbers to average, commas between:\n");
  
      }  // end if some input
  } // end draw

  void keyTyped() // each key adds to temp string, ENTER transfers temp
  {      // to str and clears it

    if (key==ENTER) 
    {
      str=temp;
      temp ="";
    }
    else 
    {
      temp += key;
      // println(msg);
    }
  } // end keytype

