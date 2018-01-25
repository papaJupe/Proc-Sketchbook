/* Averaging Java--> Proc w/ Scanner fails, not enabled in Proc 2.x anyway
 no input from many different trials
 */
//import processing.serial.*; tried using Scanner as serial, it's not
// keyboard doesn't seem readable as Serial either using System.in
import java.util.Scanner;

int count = 0;       // number of input values
double sum = 0.0;    // sum of input values
String str = "";
String temp= "";
Scanner inScan;  // global needed

void setup()
{  
  size(400, 200); 
  frameRate = 10;
  println("type some numbers to average, commas between:");
  // inScan.bufferUntil(','); // is Scan. obj even a Serial object? no
}

void draw()  // want to repeat after each averaging
{     
  inScan = new Scanner(System.in);
  // String str = inScan.nextLine();  // the full line, get nothing
  double dub = inScan.nextDouble(); // nor here
  println(dub);
  //      // if there's an input str, parse it, and average
  //  if (str != null)
  //    {  println(str);
  //      String next = str;  // the full line
  //      count = 0;       // clear these guys
  //      sum = 0.0;
  //  
  //      println("got a line " + next);
  //      String[] fields = next.split(",");  // split at commas, put pcs in array    
  //      double[] vals = new double[fields.length]; // array of doubles same size
  //      for (int i = 0; i < fields.length; i++)
  //        {    // parse the pcs and fill the array
  //          vals[i] = Double.parseDouble(fields[i]);
  //          // add each value to sum
  //          sum += vals[i];
  //          count++;
  //        }  // end for
  //  
  //      // compute the average
  //      double average = (sum / count);
  //  
  //      // print results, printf by itself fails for flt or dubl
  //      System.out.printf("Average is %5.3f\n", average);
  //      str = ""; 
  //      System.out.println("type some numbers to average, commas between:\n");
  //  
  //      }  // end if some input
} // end draw

//void serialEvent(Serial inpt) 
//{  str = ""; // clear old str
//  // read the serial buffer
//  String inputStr = inpt.readStringUntil('\n');
//
//  // trim space, return, linefeed from the input string
//  inputStr = trim(inputStr);
//    str = inputStr;  // draw picks up and processes
//
//  // split the input string at the commas
//  // and put the tokens into integer array sensors[]:
//  // double[] = int(split(inputString, ','));
//}  // end SerEvent


