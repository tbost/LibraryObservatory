InteractiveMap map;
ZoomButton out = new ZoomButton(5, 5, 14, 14, false);
ZoomButton in = new ZoomButton(22, 5, 14, 14, true);
PanButton up = new PanButton(14, 25, 14, 14, UP);
PanButton down = new PanButton(14, 57, 14, 14, DOWN);
PanButton left = new PanButton(5, 41, 14, 14, LEFT);
PanButton right = new PanButton(22, 41, 14, 14, RIGHT);
Button[] buttons = { 
  in, out, up, down, left, right
};

void mouseDragged() {
  boolean hand = false;
  for (int i = 0; i < buttons.length; i++) {
    hand = hand || buttons[i].mouseOver();
    if (hand) break;
  }

  //CHECK FIELD TOGGLES
  for (int i = 0; i < toggles.size(); i++) {
    Toggle toggle = (Toggle) toggles.get(i);
    hand = hand || toggle.mouseOver();
    hand = hand || toggle.subMouseOver();
    if (hand) break;
  }

  //CHECK NORMALIZE TOGGLE
  hand = hand || subjectTog.mouseOver();
  hand = hand || normalTog.mouseOver();

  //CHECK SLIDER
  hand = hand || mouseX > width - 200 && mouseY > 10 && mouseY < 25;

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
  else if (subjectTog.mouseOver() || normalTog.mouseOver()) {
    subjectTog.clicked();
    normalTog.clicked();
  }
  else {
    for (int i = 0; i < toggles.size(); i++) {
      Toggle toggle = (Toggle) toggles.get(i);
      toggle.clicked(i);
    }
  }
}

class Button {  
  float x, y, w, h;
  Button(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }  
  boolean mouseOver() {
    return (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h);
  }  
  void draw() {
    stroke(255);
    strokeWeight(1);
    fill(mouseOver() ? 150 : 50);
    rect(x, y, w, h);
  }
}

class ZoomButton extends Button {  
  boolean in = false;  
  ZoomButton(float x, float y, float w, float h, boolean in) {
    super(x, y, w, h);
    this.in = in;
  }  
  void draw() {
    super.draw();
    stroke(255);
    strokeWeight(1);
    line(x+3, y+h/2, x+w-3, y+h/2);
    if (in) {
      line(x+w/2, y+3, x+w/2, y+h-3);
    }
  }
}

class PanButton extends Button {  
  int dir = UP;  
  PanButton(float x, float y, float w, float h, int dir) {
    super(x, y, w, h);
    this.dir = dir;
  }  
  void draw() {
    super.draw();
    stroke(255);
    strokeWeight(1);
    switch(dir) {
    case UP:
      line(x+w/2, y+3, x+w/2, y+h-3);
      line(x-3+w/2, y+6, x+w/2, y+3);
      line(x+3+w/2, y+6, x+w/2, y+3);
      break;
    case DOWN:
      line(x+w/2, y+3, x+w/2, y+h-3);
      line(x-3+w/2, y+h-6, x+w/2, y+h-3);
      line(x+3+w/2, y+h-6, x+w/2, y+h-3);
      break;
    case LEFT:
      line(x+3, y+h/2, x+w-3, y+h/2);
      line(x+3, y+h/2, x+6, y-3+h/2);
      line(x+3, y+h/2, x+6, y+3+h/2);
      break;
    case RIGHT:
      line(x+3, y+h/2, x+w-3, y+h/2);
      line(x+w-3, y+h/2, x+w-6, y-3+h/2);
      line(x+w-3, y+h/2, x+w-6, y+3+h/2);
      break;
    }
  }
}

void checkCursor() {
  boolean hand = false;
  stroke(0);

  //CHECK MAP ZOOM/PAN BUTTONS
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].draw();
    hand = hand || buttons[i].mouseOver();
  }

  //CHECK BOTTOM TOGGLES
  for (int i = 0; i < toggles.size(); i++) {
    Toggle toggle = (Toggle) toggles.get(i);
    toggle.draw();
    hand = hand || toggle.mouseOver();
    hand = hand || toggle.subMouseOver();
  }

  //CHECK NORMALIZE TOGGLE
  subjectTog.draw();
  normalTog.draw();
  hand = hand || subjectTog.mouseOver();
  hand = hand || normalTog.mouseOver();

  //CHECK SLIDER
  hand = hand || mouseX > width - 200 && mouseY > 10 && mouseY < 25;

  cursor(hand ? HAND : CROSS);

  fill(255);
  textSize(24);
  text("/", width/2, height - 20);
}

