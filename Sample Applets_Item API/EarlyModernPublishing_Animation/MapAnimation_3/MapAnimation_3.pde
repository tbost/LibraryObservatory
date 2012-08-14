String[] pubLocations, citiesList, faceting;
color green = color(224, 224, 11, 100);
int counter = 0;
PImage backImage;
String[] yrLocPrev = {
  "", "", "", "", "", "", "", "", "", ""
};
String[] languages = {
  "English", "Spanish", "German", "Dutch", "French", "Italian", "Hebrew", "Arabic", "Chinese", "Korean", "Japanese", "Swedish", "Danish", "Greek", "Unknown", "Other"
};
int[] langCounter = new int[languages.length];
int currentYear = 1440;

void setup() {
  frameRate(80);
  pubLocations = loadStrings("Records_1440_1700_Cleaned.txt");
  citiesList = loadStrings("Cities_Europe.txt");
  cityCounter = new int[citiesList.length];

  setupInterface();

  // Map Mode Options would be "new Microsoft.HybridProvider()" or "new Microsoft.AerialProvider()" or "new Microsoft.RoadProvider()"
  map = new InteractiveMap(this, new Microsoft.AerialProvider()); 
  map.setCenterZoom(new Location(47, 5), 5);// zoom 0 is the whole world, 19 is street level
}


void keyPressed() {
  save("image.jpg");
}

void draw() {    
  background(0);    
  map.draw();
  mapVisuals();

  plotInformation01();

  checkCursor();

  delay(10);
  counter++;
  counter = constrain(counter, 0, pubLocations.length);
  startTime = millis();

  //Save Frames for Animation
  //if(counter%3 > 0) save(counter +".jpg");
}

void mapVisuals() {
  filter(GRAY);
}


