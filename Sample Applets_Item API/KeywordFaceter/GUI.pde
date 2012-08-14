import controlP5.*;
ControlP5 controlP5;
String textValue = "";
Textfield myTextfield;
controlP5.Button myButton;
FacetToggle[] toggles = new FacetToggle[5];
int faceter = -1;

PFont font, font1, font2;

void setupInterface() {
  size(800, 600);
  font = loadFont("Bebas-24.vlw");
  font1 = loadFont("ArialMT-12.vlw");
  font2 = loadFont("Aharoni-Bold-36.vlw");
  //font3 = loadFont();
  smooth();

  controlP5 = new ControlP5(this);
  myTextfield = controlP5.addTextfield("subject", width - 250, 10, 190, 20);
  myTextfield.setFocus(true);
  myTextfield.keepFocus(true);
  myTextfield.setColorBackground(color(0, 150));
  myTextfield.setColorActive(color(255, 255, 255, 200));
  myTextfield.setColorForeground(color(255, 0, 0, 200));
  myTextfield.setColorValue(color(255, 255, 255));
  myButton = controlP5.addButton("submit>>", 100, width-55, 10, 45, 20);
  myButton.setColorBackground(color(0, 200));
  myButton.setColorActive(color(0, 255));
  myButton.setColorForeground(color(80, 200));

  toggles[0] = new FacetToggle(10, 10, "Subject", 0);
  toggles[1] = new FacetToggle(10, 40, "Format", 1);
  toggles[2] = new FacetToggle(10, 70, "Language", 2);
  toggles[3] = new FacetToggle(10, 100, "Creator", 3);
  toggles[4] = new FacetToggle(10, 130, "Publisher", 4);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.controller().name()=="submit>>") {
    filterKeyword = myTextfield.getText();

    //Make the user wait
    cursor(WAIT);

    queryAPI();
    myTextfield.setText("");
  }
}

void keyPressed() {
  //Submit Search Query
  if (key == ENTER) {
    String[] textReceived = myTextfield.getTextList();
    filterKeyword = textReceived[constrain(textReceived.length - 1, 0, textReceived.length)];

    //Make the user wait while search
    cursor(WAIT);

    //Make the search to the api and reset textbox
    queryAPI();
    myTextfield.setText("");
  }

  //Export Timeline Image
  if (key == '1') save("faceter.jpg");
}

void mouseClicked() {
  for (int i = 0; i < toggles.length; i++) {
    toggles[i].clicked();
  }
}

void checkCursor() {
  boolean hand = false;
  stroke(0);

  for (int i = 0; i < toggles.length; i++) {
    toggles[i].draw();
    hand = hand || toggles[i].mouseOver();
  }

  ArrayList facetDisplay = new ArrayList();
  if (faceter == 0) facetDisplay = subjectFacets;
  else if (faceter == 1) facetDisplay = formatFacets;
  else if (faceter == 2) facetDisplay = langFacets;
  else if (faceter == 3) facetDisplay = creatorFacets;
  else if (faceter == 4) facetDisplay = pubFacets;
  for (int i = 0; i < facetDisplay.size(); i++) {
    Facet facet = (Facet) facetDisplay.get(i);
    if (facet.mouseOver()) facet.label();
  }

  //Check if over buttons
  hand = hand ||(mouseX > width-55 && mouseX < width-10 && mouseY > 10 && mouseY < 30);
  cursor(hand ? HAND : ARROW);
}

class FacetToggle {
  int x, y, facetIndex;
  String name;

  FacetToggle(int xPos, int yPos, String n, int fI) {
    x = xPos;
    y = yPos;
    name = n;
    facetIndex = fI;
  }

  void draw() {
    if (mouseOver()) fill(80, 180);
    else fill(0, 180);
    if (faceter == facetIndex) fill(150, 180);
    rect(x, y, 80, 20);
    fill(255);
    textFont(font1);
    textAlign(CENTER);
    text(name, x + 40, y + 15);
  }

  boolean mouseOver() {
    return mouseX > x && mouseX < x + 150 && mouseY > y && mouseY < y + 20;
  }

  void clicked() {
    if (mouseOver()) {
      faceter = facetIndex;
    }
  }
}

