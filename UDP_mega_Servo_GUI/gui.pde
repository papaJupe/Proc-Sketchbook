/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void tilt_change(GSlider source, GEvent event) { //_CODE_:tilt:490131:
  //println("tilt - GSlider >> GEvent." + event + " @ " + millis());
  // println("int value tilt: " + tilt.getValueI() );
  tiltLabel.setText("tilt: " + tilt.getValueI() );
} //_CODE_:tilt:490131:



// Create all the GUI controls. 
// autogenerated do not edit unless you want something to change
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("remote servo control");
  tilt = new GSlider(this, -66, 100, 200, 23, 7.0);
  //tilt.setShowValue(false); // val not showing either t/f
  //tilt.setTextOrientation(G4P.ORIENT_TRACK); // no effect
  tilt.setRotation(PI*3/2, GControlMode.CENTER);
  // invert vals because 180 is full down, 0 full up on Ardu
  tilt.setLimits(90, 180, 0); // default, min, max
  tilt.setNbrTicks(5);
  tilt.setShowTicks(true);
  //tilt.setNumberFormat(G4P.DECIMAL, 2);
  tilt.setNumberFormat(G4P.INTEGER);
  tilt.setOpaque(false);
  tilt.addEventHandler(this, "tilt_change");
  tiltLabel = new GLabel(this, 52, 100, 100, 20);
  tiltLabel.setText("tilt angle");
  tiltLabel.setFont(f);  // custom set in sketch
  //tiltLabel.setTextBold();
  tiltLabel.setOpaque(true);
}

// Variable declarations 
// autogenerated do not edit
GSlider tilt; 
GLabel tiltLabel; 

