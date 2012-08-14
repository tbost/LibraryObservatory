import controlP5.*;
ControlP5 controlP5;
Slider mySlider;
int[] mapSubject;
int[] mapNormalizer;
float rangeMin = 0;
float rangeMax = 0;
float rangeMean = 0;

void plotData() {
  for (int i = 0; i < libraries.size(); i++) {
    Library library = (Library) libraries.get(i);

    colorMode(HSB, 360, 255, 255, 100);
    float mapValue, mapNormal, rad;
    color fillColor;
    if (mapSubject != null) {
      //CHECK WHICH LIBRARY METADATA TO DISPLAY
      mapValue = library.metaData[mapSubject[0]][mapSubject[1]];
      if (mapNormalizer == null) mapNormal = 1;
      else mapNormal = library.metaData[mapNormalizer[0]][mapNormalizer[1]];

      //REGULATE FILL COLOR
      if (mapValue != -1 && mapValue != -3 && mapNormal != -1 && mapNormal != -3) {
        float hueValue = map(mapValue/mapNormal, rangeMean - (rangeMean - rangeMin)*deviation, rangeMean + (rangeMax - rangeMean)*deviation, 240, 0);
        hueValue = constrain(hueValue, 0, 240);
        fillColor = color(hueValue, 255, 255, 60);

        //REGULATE SIZE
        rad = map(mapValue/mapNormal, rangeMean - (rangeMean - rangeMin)*deviation, rangeMean + (rangeMax - rangeMean)*deviation, 4, 15);
        rad = constrain(rad, 4, 15);
      }
      else {
        fillColor = color(59, 0, 100, 85);
        rad = 4;
      }
    }
    else {
      fillColor = color(59, 0, 100, 85);
      rad = 4;
    }

    library.draw(fillColor, rad);
  }


  //DRAW LEGEND
  for (int i = 0; i < 7; i++) {
    fill((float(6 - i)/float(6))*240, 255, 255, 200);
    float r = map(i, 0, 7, 4, 15);
    ellipse(width - 190 + i*20, 45, r, r);
  }
  fill(0, 0, 255);
  textSize(10);
  textAlign(CENTER);
  text(nfc(rangeMean - (rangeMean - rangeMin)*deviation, 2) + "\n" + subjectTog.name + " per " + normalTog.name, width - 190, 65);
  text(nfc(rangeMean + (rangeMax - rangeMean)*deviation, 2) + "\n" + subjectTog.name + " per " + normalTog.name, width - 60, 65);
}

