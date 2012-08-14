int yearStart = 1700;
int yearEnd = 2000;
int daysTotal = 3562;
int monthsTotal = 117;
String[] dateList;

int xSample;
String dateCode;

int[] dayTotals;
PGraphics bgImage;
PFont font0, font1;
boolean accDrawn = false;
Faceter publisher, subject, format, language, clear;

void setup() {
  size(800, 600);
  dateList = loadStrings("DateList.txt");
  dayTotals = int(loadStrings("AccessionsTotal.txt"));
  bgImage = createGraphics(width, height, JAVA2D);
  font0 = loadFont("ArialMT-12.vlw");
  font1 = loadFont("Arial-BoldMT-24.vlw");

  publisher = new Faceter("publisher", 10, height/2 - 30);
  subject = new Faceter("subject", 10, height/2 - 5);
  format = new Faceter("format", 10, height/2 + 20);
  language = new Faceter("language", 10, height/2 + 45);
  clear = new Faceter("clear", 10, height/2 + 95);

  smooth();
}

void draw() {
  drawCanvas();

  drawCursor();
}

void drawCanvas() {
  background(255);

  if (accDrawn) image(bgImage, 0, 0, width, height);

  drawTimelines();
}

