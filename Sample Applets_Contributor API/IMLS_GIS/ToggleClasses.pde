ArrayList toggles = new ArrayList();
SubNormToggle subjectTog;
SubNormToggle normalTog;
float deviation = 100;

String[] toggleNames = {
  "Population", "Staff", "Operations Income", "Operations Expenses", "Capital", "Collections", "Operations", "Circulation", "Programs", "Internet"
};

String[] populationSub = {
  "County Population", "Service Area Population"
};
String[] staffSub = {
  "Total Staff", "Master's Degrees", "Librarians", "Others"
};
String[] incomeSub = {
  "Total Income", "Federal Income", "State Income", "Local Income", "Other Income"
};
String[] expenseSub = {
  "Total Staff Expense", "Salaries", "Benefits", "Total Materials", "Print Materials", "Electronic Materials", "Other Materials"
};
String[] capitalSub = {
  "Total Capital", "Federal Capital", "State Capital", "Local Capital", "Other Capital", "Total Expenditures"
};
String[] collectionSub = {
  "Print", "Digital", "Audio", "Video", "Database", "Print Subscriptions", "Electronic Subscriptions"
};
String[] operationSub = {
  "Hours Open", "Visits", "Borrowers"
};
String[] circulationSub = {
  "Total", "Reference", "Children's", "Loans To", "Loans From"
};
String[] programSub = {
  "Total Programs", "Adult Attendance", "Children's Attendance"
};
String[] internetSub = {
  "Computers", "Users"
};

String[][] subNames = {
  populationSub, staffSub, incomeSub, expenseSub, capitalSub, collectionSub, operationSub, circulationSub, programSub, internetSub
};

//*************************************************************************************************************

void setupToggles() {
  //FIELD TOGGLES
  for (int i = 0; i < toggleNames.length; i++) {
    int x = width/2 - (width - 100)/2 + ((width - 100)/toggleNames.length)*i;
    int y = height - 75;
    String name = toggleNames[i];
    String[] subList = subNames[i];
    toggles.add(new Toggle(x, y, -1, name, subList));
  }

  //SUBJECT / NORMALIZE TOGGLES
  subjectTog = new SubNormToggle(width/2 - 100, height - 20, "Feature", true);
  normalTog = new SubNormToggle(width/2 + 100, height - 20, "Normalize", false);

  //SLIDER TOGGLE
  float sliderMin = 0;
  float sliderMax = 1;
  float sliderValue = 1;
  int sliderX = width - 200;
  int sliderY = 10;
  int sliderWidth = 150;
  int sliderHeight = 15;
  controlP5 = new ControlP5(this);
  controlP5.addSlider("deviation", sliderMin, sliderMax, sliderValue, sliderX, sliderY, sliderWidth, sliderHeight);
  Slider s1 = (Slider)controlP5.controller("Mean Deviation");
}

//*************************************************************************************************************

class SubNormToggle {
  int x, y;
  String name;
  boolean clicked;

  SubNormToggle(int xPos, int yPos, String n, boolean cl) {
    x = xPos;
    y = yPos;
    name = n;
    clicked = cl;
  }

  void draw() {
    fill(clicked ? color(255, 255, 255) : color(30, 170));
    textSize(24);
    text(name, x, y);
  }

  boolean mouseOver() {
    return mouseX > x - 60 && mouseX < x + 60 && mouseY < y && mouseY > y - 30;
  }

  void clicked() {
    clicked = !clicked;
  }
}

class Toggle {
  int x, y;
  int h = 20;
  int dropDir;
  String name;
  boolean clicked = false;
  SubToggle[] subs;

  Toggle(int xPos, int yPos, int dir, String n, String[] subList) {
    x = xPos;
    y = yPos;
    dropDir = dir;
    name = n;
    subs = new SubToggle[subList.length];
    for (int i = 0; i < subList.length; i++) {
      SubToggle sT = new SubToggle(x, y + h*(i+1)*dropDir, h, subList[i]);
      subs[i] = sT;
    }
  }

  void draw() {
    fill(mouseOver() ? color(180, 170) : color(30, 170));
    rect(x, y, (width - 100)/toggleNames.length, h);
    fill(mouseOver() ? color(30, 170) : color(180, 170));
    textAlign(CENTER);
    textSize(10);
    text(name, x + ((width - 100)/toggleNames.length)/2, y + h - 5);

    if (clicked) {
      for (int i = 0; i < subs.length; i++) {
        subs[i].draw();
      }
    }
  }

  boolean mouseOver() {
    return mouseX > x && mouseX < x + (width - 100)/toggleNames.length && mouseY > y && mouseY < y + h;
  }

  boolean subMouseOver() {
    boolean m0 = false;
    if (clicked) {
      for (int i = 0; i < subs.length; i++) {
        if (subs[i].mouseOver()) m0 = true;
      }
    }
    return m0;
  }

  void clicked(int toggleIndex) {
    if (mouseOver()) clicked = !clicked;
    else clicked = false;

    for (int i = 0; i < subs.length; i++) {
      subs[i].clicked(toggleIndex, i);
    }
  }

  void normalClicked() {
    if (mouseOver()) clicked = !clicked;
    else clicked = false;

    for (int i = 0; i < subs.length; i++) {
      //subs[i].clicked();
    }
  }
}


class SubToggle {
  int x, y, h;
  String name;
  boolean isOver = false;

  SubToggle(int xPos, int yPos, int high, String n) {
    x = xPos;
    y = yPos;
    h = high;
    name = n;
  }

  void draw() {
    fill(mouseOver() ? color(100, 170) : color(20, 170));
    rect(x, y, (width - 100)/toggleNames.length, h);
    fill(mouseOver() ? color(10, 170) : color(120, 170));
    text(name, x + ((width - 100)/toggleNames.length)/2, y + h - 5);
  }

  boolean mouseOver() {
    return mouseX > x && mouseX < x + (width - 100)/toggleNames.length && mouseY > y && mouseY < y + h;
  }

  void clicked(int toggleIndex, int subToggleIndex) {
    int[] indexes = {
      toggleIndex, subToggleIndex
    };
    if (mouseOver()) {
      //Set the indexes of the metadata fields to map in the library objects
      if (subjectTog.clicked) {
        mapSubject = indexes;
        subjectTog.name = name;
      }
      else if (normalTog.clicked) {
        mapNormalizer = indexes;
        normalTog.name = name;
      }

      //Find Min/Max of Field
      //**********************************************REWRITE THIS TO ALLOW FOR JENKS NATURAL BREAKS
      float sampleNormal = 1;//In case no normal is specified
      float[] sampleMean = new float[libraries.size()];
      for (int i = 0; i < libraries.size(); i++) {
        Library library = (Library) libraries.get(i);
        float sampleVal = library.metaData[mapSubject[0]][mapSubject[1]];
        if (mapNormalizer != null) sampleNormal = library.metaData[mapNormalizer[0]][mapNormalizer[1]];

        if (sampleVal != -1 && sampleVal != -3 && sampleNormal != -1 && sampleNormal != -3) {
          sampleMean[i] = sampleVal/sampleNormal;
          if (i == 0) {
            rangeMin = sampleVal/sampleNormal;
            rangeMax = sampleVal/sampleNormal;
          }
          else if (sampleVal/sampleNormal < rangeMin) rangeMin = sampleVal/sampleNormal;
          else if (sampleVal/sampleNormal > rangeMax) rangeMax = sampleVal/sampleNormal;
        }
      }
      rangeMin = max(rangeMin, 0);
      
      //Calculat Mean
      float meanTotal = 0;
      for(int i = 0; i < sampleMean.length; i++){
        meanTotal = meanTotal + sampleMean[i];
      }
      rangeMean = meanTotal/sampleMean.length;
      println("Range Min : " + rangeMin);
      println("Range Max : " + rangeMax);
      println("Range Mean : " + rangeMean);
    }
  }
}

