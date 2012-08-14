String[] data;

void setup() {
  size(1000, 750);  
  data = loadStrings("contributor_output.txt");
  JSONparser();
  setupToggles();
  smooth();

  map = new InteractiveMap(this, new Microsoft.AerialProvider());
  map.setCenterZoom(new Location(40, -100), 4);//zoom 0 is the whole world, 19 is street level
}

void draw() {
  background(255);
  map.draw();
  mapVisuals();

  plotData();

  checkCursor();
}


void mapVisuals() {
  filter(GRAY);

  loadPixels();
  for (int i = 0; i < width*height - 1; i++) {
    if (brightness(pixels[i]) < 22 && brightness(pixels[i+1]) < 22) pixels[i] = color(0, 0, 255);
  }
  updatePixels();
}

