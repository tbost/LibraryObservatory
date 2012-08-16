import java.awt.event.*;//Required library for mouse wheel
int timeBegin = 1300;//Year to begin timeline
int timeEnd = year() + 20;//Year to end timeline
float periodCenter = 1900;//Point in timeline on which to center view
int zoomLevel = 40;//150 = max, 3 = min
float centerX;

//Mouse Dragging
protected float   mX;
protected float mY;
protected float   mDifX = 0f;
//protected float   mDifY = 0f;

//Fake Data
int[] fakeYears = {
  1987, 1765, 1867, 1900, 1845, 1923, 1789, 1831, 1856, 1899, 1813, 1903, 1855, 1950, 1946, 1969, 1973, 1982
};

void setup() {
  size(800, 500);
  smooth();

  //Center on Specified Date
  //centerX = map(periodCenter, timeBegin, timeEnd, width/2 - 200*zoomLevel, 200*zoomLevel)*-1;
  //println(centerX);

  //Enable Mouse Wheel
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  );
}

void draw() {
  timeLine();

  drawData();
}

void timeLine() {
  //Draw Horizontal Timeline
  background(255);
  strokeWeight(20);
  stroke(100);
  line(0, height/2, width, height/2);

  //Move Timeline Based on Dragging
   //float periodCenter2 = map(mX + centerX, -width + 200*zoomLevel, width/2 - 200*zoomLevel, timeBegin, timeEnd);
   //println(periodCenter2);
  float centerX = map(periodCenter, timeBegin, timeEnd, width/2 - 200*zoomLevel, 200*zoomLevel)*-1;
  float moveT = constrain(mX + centerX, width/2 - 200*zoomLevel, -width/2 + 200*zoomLevel);
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
      textSize(24);
    }
    //DECADES
    else if (i%10 == 0 && (decades || centuries)) {
      strokeWeight(2);
      upTick = 70;
      textSize(18);
    }
    //5 YEARS
    else if (i%5 == 0 && (years5 || decades)) {
      strokeWeight(1);
      upTick = 60;
      textSize(14);
    }
    //1 YEAR
    else {
      strokeWeight(.5);
      upTick = 50;
      textSize(10);
    }

    //DRAW TICK MARKS
    line(yearTick, height/2 - upTick, yearTick, height/2 + upTick);

    //LABEL YEARS
    fill(100);
    textAlign(LEFT);
    pushMatrix();
    rotate(HALF_PI);
    if (upTick > 50) text(i, height/2 + 15, -yearTick - 1);
    popMatrix();
    strokeWeight(1);
  }
}

void drawData() {
  //Draw Info on Timeline
  stroke(255, 0, 255);
  strokeWeight(3);
  for (int i = 0; i < fakeYears.length; i++) {
    float fakeX = map(fakeYears[i], timeBegin, timeEnd, width/2 - 200*zoomLevel, width/2 + 200*zoomLevel);
    line(fakeX, height/4, fakeX, height - height/4);
  }
}

void mouseWheel(int delta) {
  zoomLevel = zoomLevel + delta;
  zoomLevel = constrain(zoomLevel, 3, 150);
  //println(zoomLevel);
}

void mousePressed() {
  mDifX = mouseX - mX;
  //mDifY = mouseY - mY;
  cursor(HAND);
}

void mouseReleased() {
  cursor(ARROW);
}

void mouseDragged() {
  mX = mouseX - mDifX;
  //mY = mouseY - mDifY;
}

