int langTotal = 0;
int[] cityCounter;
int cityTotal = 0;

void plotInformation01() {
  String[] dataLine = split(pubLocations[counter], '\t');

  //Calculate Languages
  boolean matched = false;
  for (int i = 0; i < languages.length; i++) {
    if (match(dataLine[3], languages[i]) != null) {
      langCounter[i]++;
      matched = true;
      //break;
      langTotal++;
    }
  }

  float barAdd = 0;
  float barWide = 0;
  colorMode(HSB, 360, 255, 255, 255);
  for (int i = 0; i < langCounter.length; i++) {
    color barColor = color(map(i, 0, languages.length - 1, 0, 360), 255, 255, 150);
    fill(barColor);
    barWide = (float(langCounter[i])/langTotal)*width;
    rect(barAdd, 0, barWide, 10);
    textFont(font2);
    if (float(langCounter[i])/langTotal > .03) text(languages[i], barAdd, 25);
    barAdd = barAdd + barWide;
  }
  colorMode(RGB);

  //Compare Place Name to List of Existing Cities
  //If there is a match add to the total count at that city and draw it on the map
  for (int j = 0; j < cities.size(); j++) {
    City city = (City) cities.get(j);
    if (match(trim(dataLine[4]), trim(city.name)) != null) {        
      city.count++;
      city.flash = 40;
    }

    city.display();
  }

  //Draw Color Bar of Top Producing Cities
  boolean cityMatched = false;
  for (int i = 0; i < cityCounter.length; i++) {
    String[] cityName = split(citiesList[i], '\t');
    if (match(dataLine[4], cityName[0]) != null) {
      cityCounter[i]++;
      cityMatched = true;
      cityTotal++;
    }
  }

  float cityBarAdd = 0;
  float cityBarWide = 0;
  colorMode(HSB, 360, 255, 255, 255);
  stroke(255, 200);
  for (int i = 0; i < cityCounter.length; i++) {
    color barColor = color(map(i, 0, citiesList.length - 1, 0, 360), 255, 255, 150);
    fill(barColor);
    cityBarWide = (float(cityCounter[i])/cityTotal)*width;
    rect(cityBarAdd, height - 10, cityBarWide, 10);
    textFont(font2);
    String[] cityN = split(citiesList[i], '\t');
    if (float(cityCounter[i])/cityTotal > .02) text(cityN[0], cityBarAdd, height - 15);
    cityBarAdd = cityBarAdd + cityBarWide;
  }
  colorMode(RGB);


  //Display the current list of records being sampled
  textAlign(LEFT);
  textFont(font1);
  fill(255);
  text(dataLine[0] + " : " + dataLine[4], 5, height - 30);

  for (int i = 1; i < yrLocPrev.length; i++) {
    fill(255, 255 - (255/yrLocPrev.length)*i);
    text(yrLocPrev[i], 5, height - 35 - i*20);
  }
  yrLocPrev[0] = dataLine[0] + " : " + dataLine[4];

  if (int(dataLine[0]) >= 1699) counter = 0;//exit();

  yrLocPrev[9] = yrLocPrev[8];
  yrLocPrev[8] = yrLocPrev[7];
  yrLocPrev[7] = yrLocPrev[6];
  yrLocPrev[6] = yrLocPrev[5];
  yrLocPrev[5] = yrLocPrev[4];
  yrLocPrev[4] = yrLocPrev[3];
  yrLocPrev[3] = yrLocPrev[2];
  yrLocPrev[2] = yrLocPrev[1];
  yrLocPrev[1] = yrLocPrev[0];
}
