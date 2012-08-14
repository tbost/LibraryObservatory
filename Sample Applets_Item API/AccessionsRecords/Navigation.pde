void drawCursor() {  
  if (mouseY > height - 60) {
    //Draw Cursor on Accession Timeline
    stroke(0, 255, 255, 220);
    strokeWeight(5);
    int totalRecords = dayTotals[int((float(mouseX)/float(width))*dateList.length)];
    float recordHeight = map(totalRecords, 0, 2000, 0, height - 120);
    recordHeight = constrain(recordHeight, 0, height - 120);
    line(mouseX, height - 60 - recordHeight, mouseX, height);

    //Label Sample Date Represented by Cursor
    fill(0);
    textAlign(CENTER);
    textFont(font1);
    String cursorDate = mouseDateCalculate(mouseX);
    String yearNum = cursorDate.substring(0, 4);
    String monthNameIndex = cursorDate.substring(4, 6);
    String dayNum = cursorDate.substring(6, 8);
    text(int(dayNum) + " / " + int(monthNameIndex) + " / " + yearNum, mouseX, height - 65);
  }

  boolean hand = false;
  stroke(0);

  //Check If Over Buttons
  publisher.draw();
  hand = hand || publisher.mouseOver();
  subject.draw();
  hand = hand || subject.mouseOver();
  format.draw();
  hand = hand || format.mouseOver();
  language.draw();
  hand = hand || language.mouseOver();
  clear.draw();
  hand = hand || clear.mouseOver();

  cursor(hand ? HAND : ARROW);
}

void mouseClicked() {
  if (mouseY > height - 60) {
    cursor(WAIT);
    xSample = mouseX;

    //Determine Date to Send to API
    dateCode = mouseDateCalculate(mouseX);
    println("dateCode : " + dateCode);

    queryAPI();
  }

  publisher.clicked();
  subject.clicked();
  format.clicked();
  language.clicked();
  clear.clicked();
}

//Calculate Date to Sample from Mouse Position
String mouseDateCalculate(int xPos) {
  String dateString = dateList[int((float(xPos)/float(width))*dateList.length)];
  //println(dateString);
  String[] dateArray = split(dateString, "/");
  return dateArray[2] + nf(int(dateArray[0]), 2) + nf(int(dateArray[1]), 2);
}

class Faceter {
  String name;
  int x, y;
  int w = 100;
  int h = 20;
  boolean clicked;

  Faceter(String n, int xPos, int yPos) {
    name = n;
    x = xPos;
    y = yPos;
  }

  void draw() {
    stroke(0, 200, 200);
    fill(mouseOver() ? color(0, 255, 255, 255) : color(0, 255, 255, 100));
    if (match(faceter, name) != null) fill(color(0, 255, 255, 255));
    strokeWeight(mouseOver() ? 1 : 0); 
    rect(x, y, w, h);
    fill(255);
    textFont(font1);
    textSize(14);
    textAlign(CENTER);
    text(name, x + w/2, y + 3*h/4);
  }

  boolean mouseOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }

  void clicked() {
    if (mouseOver()) {
      clicked = !clicked;
      faceter = "dpla." + name;
      if (name == "clear") {
        dateCode = "";
        bgImage.beginDraw();
        bgImage.background(255);
        bgImage.endDraw();
        accDrawn = false;
      }
    }
  }
}

