ArrayList cities = new ArrayList();
long lastClicked = 0;

void setupInterface() {
  size(screen.width, screen.height);

  smooth();
  font1 = loadFont("Arial-Black-15.vlw");
  font2 = loadFont("ArialNarrow-12.vlw");

  //Setup Cities
  for (int i = 0; i < citiesList.length; i++) {
    String[] dataLine = split(citiesList[i], '\t');
    cities.add(new City(dataLine[0], float(dataLine[1]), float(dataLine[2])));
  }
}

// see if we're over any buttons, otherwise tell the map to drag
void mouseDragged() {
  boolean hand = false;
  for (int i = 0; i < buttons.length; i++) {
    hand = hand || buttons[i].mouseOver();
    if (hand) break;
  }
  if (!hand) {
    map.mouseDragged();
  }
}

void mouseClicked() {
  if (in.mouseOver()) {
    map.zoomIn();
  }
  else if (out.mouseOver()) {
    map.zoomOut();
  }
  else if (up.mouseOver()) {
    map.panUp();
  }
  else if (down.mouseOver()) {
    map.panDown();
  }
  else if (left.mouseOver()) {
    map.panLeft();
  }
  else if (right.mouseOver()) {
    map.panRight();
  }
  else if(millis() - lastClicked < 100){
    map.zoomIn();
  }
  lastClicked = millis();
}

void checkCursor() {
  boolean hand = false;
  stroke(0);

  //NAVIGATION BUTTONS
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].draw();
    hand = hand || buttons[i].mouseOver();
  }

  hand = hand || (mouseX > width - 55 && mouseX < width - 10 && mouseY > 10 && mouseY < 30);
  cursor(hand ? HAND : CROSS);
}

