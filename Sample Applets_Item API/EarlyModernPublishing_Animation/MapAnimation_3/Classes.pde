class City {
  String name;
  float lat, lon;
  int count;
  int flash = 0;
  int[] langCount = new int[langCounter.length];

  City(String n, float la, float lo) {
    name = n;
    lat = la;
    lon = lo;
  }

  void display() {
    Location locTemp = new Location(lat, lon);
    Point2f pointTemp = map.locationPoint(locTemp);
    int pointX = int(pointTemp.x);
    int pointY = int(pointTemp.y);

    fill(green);
    noStroke();
    float rad = sqrt((78.5 + count*10)/PI);
    if(rad > 5) {
      //Add Quick Flash When New Book Is Printed
      if(flash >= 0){
        ellipse(pointX, pointY, flash, flash);
        flash = flash - 8;
      }
      
      //Large Circle Scaled to Total Items + Small Circle to Locate 
      ellipse(pointX, pointY, rad, rad);
      fill(red(green), green(green), blue(green), 255);
      ellipse(pointX, pointY, 5, 5);
      
      textFont(font2);
      fill(255, 200);
      text(name, pointX + 3, pointY - 3);
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

