String[] data;
String[] producers;
String[] countries;
int[] countryCount;
String[] cxnList = new String[0];

void setup() {
  size(2*screen.width, 3*screen.height/4);
  data = loadStrings("NPR_output.txt");
  countries = loadStrings("Countries_ByRegion.txt");
  countryCount = new int[countries.length];

  JSONparser();

  smooth();

  println("CXN : " + cxnList.length);
}

void draw() {
  background(0);

  Legend();

  drawConnections();

  drawCounts();

  save("image.jpg");

  println("DONE!!!");
  noLoop();
}

