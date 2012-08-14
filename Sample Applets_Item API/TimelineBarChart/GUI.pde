import controlP5.*;
ControlP5 controlP5;
String textValue = "";
Textfield myTextfield;
controlP5.Button myButton;
String[] responseList;

import java.awt.event.*;
PFont font, font2;
int timeBegin = 1300;
int timeEnd = year() + 20;
float periodCenter = 1900;//Point in timeline on which to center view
int yearModulate = 10;
int zoomLevel = 20;

//Mouse Dragging
protected float   mX;
protected float mY;
protected float   mDifX = 0f;
float moveT;
boolean dragging = false;

Sorter totalItems, pageCounts, spineHeights;
String sortBy = "";

void setupInterface() {
  size(800, 600);
  font = loadFont("Bebas-24.vlw");
  font2 = loadFont("ArialMT-14.vlw");
  smooth();
  controlP5 = new ControlP5(this);
  myTextfield = controlP5.addTextfield("subject", width - 250, 10, 190, 20);
  myTextfield.setFocus(true);
  myTextfield.keepFocus(true);
  myTextfield.setColorBackground(color(50));
  myTextfield.setColorActive(color(150));
  myTextfield.setColorForeground(color(150));
  myTextfield.setColorValue(color(150));
  myButton = controlP5.addButton("submit>>", 100, width-55, 10, 45, 20);
  myButton.setColorBackground(color(50));
  myButton.setColorActive(color(200));
  myButton.setColorForeground(color(150));

  totalItems = new Sorter("items", width - 100, height - 120);
  pageCounts = new Sorter("pages", width - 100, height - 85);
  spineHeights = new Sorter("size", width - 100, height - 50);

  //Center on Specified Date
  float centerX = map(periodCenter, timeBegin, timeEnd, width/2 - 200*zoomLevel, 200*zoomLevel)*-1;

  //Enable Mouse Wheel
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.controller().name()=="submit>>") {
    filter1 = myTextfield.getText();

    //Make the user wait
    cursor(WAIT);

    queryAPI();
    myTextfield.setText("");
  }
}

void drawTimeline() {
  //Draw Horizontal Timeline
  textFont(font);
  background(255);
  strokeWeight(20);
  stroke(100);
  line(0, height/2, width, height/2);

  //Move Timeline Based on Dragging
  float centerX = map(periodCenter, timeBegin, timeEnd, width/2 - 200*zoomLevel, 200*zoomLevel)*-1;
  moveT = constrain(mX + centerX, width/2 - 200*zoomLevel, -width/2 + 200*zoomLevel);
  translate(moveT, mY);

  //Draw Timeline Year Marks
  for (int i = timeBegin; i < timeEnd; i++) {
    float yearTick = map(i, timeBegin, timeEnd, width/2 - 200*zoomLevel, width/2 + 200*zoomLevel);

    int upTick;
    boolean centuries = false;
    boolean decades = false;
    boolean years5 = false;
    if (zoomLevel < 15) centuries = true;
    else if (zoomLevel < 50) decades = true;
    else if (zoomLevel < 120) years5 = true;

    //Mark every ____ year
    if (i%100 == 0 && centuries) {
      strokeWeight(5);
      upTick = 100;
      textSize(36);
    }
    //DECADES
    else if (i%10 == 0 && (decades || centuries)) {
      strokeWeight(2);
      upTick = 70;
      textSize(24);
    }
    //5 YEARS
    else if (i%5 == 0 && (years5 || decades || centuries)) {
      strokeWeight(1);
      upTick = 60;
      textSize(16);
    }
    else {
      strokeWeight(.5);
      upTick = 50;
      textSize(12);
    }

    //DRAW TICK MARKS
    line(yearTick, height/2 - upTick, yearTick, height/2 + upTick);

    //LABEL YEARS
    fill(100);
    textAlign(RIGHT);
    pushMatrix();
    rotate(HALF_PI);
    if (upTick > 50) text(i, height/2 + 60, -yearTick);
    popMatrix();
    strokeWeight(1);
  }
}

void mouseWheel(int delta) {
  zoomLevel = zoomLevel + delta;
  zoomLevel = constrain(zoomLevel, 3, 150);
  println(zoomLevel);
}

void mousePressed() {
  mDifX = mouseX - mX;
  //mDifY = mouseY - mY;
  dragging = true;
}

void mouseReleased() {
  dragging = false;
}

void mouseDragged() {
  mX = mouseX - mDifX;
  //mY = mouseY - mDifY;
}

void mouseClicked(){
  totalItems.clicked();
  pageCounts.clicked();
  spineHeights.clicked();
}

void keyPressed() {
  //Submit Search Query
  if (key == ENTER) {
    String[] textReceived = myTextfield.getTextList();
    filter1 = textReceived[constrain(textReceived.length - 1, 0, textReceived.length)];

    //Make the user wait while search
    cursor(WAIT);

    //Make the search to the api and reset textbox
    queryAPI();
    myTextfield.setText("");
  }

  //Export Timeline Image
  if (key == '1') save("timeline.jpg");
}

class Sorter{
  int x, y;
  int w = 80;
  int h = 25;
  String name;
  
  Sorter(String n, int xPos, int yPos){
    x = xPos;
    y = yPos;
    name = n;
  }
 
 void draw(){
   fill(mouseOver() ? 150 : 50);
   if(match(sortBy, name) != null) fill(255, 0, 255, 150);
   rect(x, y, w, h);
   fill(255);
   textAlign(CENTER);
   textFont(font);
   text(name, x + w/2, y + h - 2);
 } 
 
 boolean mouseOver(){
   return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
 }
 
 void clicked(){
   if(mouseOver()) sortBy = name;
 }
}

void checkCursor() {
  boolean hand = false;
  stroke(0);

  //Check if over buttons
  hand = hand ||(mouseX > width-55 && mouseX < width-10 && mouseY > 10 && mouseY < 30);
  totalItems.draw();
  hand = hand || totalItems.mouseOver();
  pageCounts.draw();
  hand = hand || pageCounts.mouseOver();
  spineHeights.draw();
  hand = hand || spineHeights.mouseOver();
  if (dragging == false) cursor(hand ? HAND : ARROW);
  else cursor(HAND);
}

