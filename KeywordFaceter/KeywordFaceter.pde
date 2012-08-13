//GUI VARIABLES
import controlP5.*;
ControlP5 controlP5;
String textValue = "";
Textfield myTextfield;
controlP5.Button myButton;
FacetToggle[] toggles = new FacetToggle[5];
int faceter = -1;

PFont font, font1, font2;
color[] colorList = {
  color(255, 0, 255), color(0, 255, 255), color(255, 255, 0), color(0, 255, 0)
};

//JSON VARIABLES
import org.json.*;
String response;
String[] facetNames = {
  "subject", "format", "language", "creator", "publisher"
};
ArrayList subjectFacets = new ArrayList();
ArrayList formatFacets = new ArrayList();
ArrayList langFacets = new ArrayList();
ArrayList creatorFacets = new ArrayList();
ArrayList pubFacets = new ArrayList();

//QUERY VARIABLES
String baseURL = "http://api.dp.la/v0.03/item/";
String filterKeyword = "";
String facetLimit = "100";
int total;


void setup() {
  setupInterface();

  smooth();
}

void draw() {
  drawData();

  drawStaticInfo();

  strokeWeight(1);
  checkCursor();
}

void drawData() {
  background(255);

  ArrayList facetDisplay = new ArrayList();
  if (faceter == 0) facetDisplay = subjectFacets;
  else if (faceter == 1) facetDisplay = formatFacets;
  else if (faceter == 2) facetDisplay = langFacets;
  else if (faceter == 3) facetDisplay = creatorFacets;
  else if (faceter == 4) facetDisplay = pubFacets;
  else {
    textAlign(CENTER, CENTER);
    textFont(font2);
    text("Enter a subject\nkeyword search to find\nout more about what\nHarvard has on the topic", width/2, height/2);
  }

  for (int i = 0; i < facetDisplay.size(); i++) {
    Facet facet = (Facet) facetDisplay.get(i);
    facet.draw();
  }
}

void drawStaticInfo() {
  //Replace any spaces in the search query with %20
  if (match(filterKeyword, "%20") != null) {
    String[] keySplit = split(filterKeyword, "%20");
    filterKeyword = join(keySplit, "  ");
  }

  //Display Search Term in Bottom Left Corner
  fill(0);
  textAlign(LEFT);
  textFont(font);
  text("\"" + filterKeyword + "\"", 5, height - 10);
}

void setupInterface() {
  size(800, 600);
  font = loadFont("Bebas-24.vlw");
  font1 = loadFont("ArialMT-12.vlw");
  font2 = loadFont("Aharoni-Bold-36.vlw");
  //font3 = loadFont();
  smooth();

  controlP5 = new ControlP5(this);
  myTextfield = controlP5.addTextfield("subject", width - 250, 10, 190, 20);
  myTextfield.setFocus(true);
  myTextfield.keepFocus(true);
  myTextfield.setColorBackground(color(0, 150));
  myTextfield.setColorActive(color(255, 255, 255, 200));
  myTextfield.setColorForeground(color(255, 0, 0, 200));
  myTextfield.setColorValue(color(255, 255, 255));
  myButton = controlP5.addButton("submit>>", 100, width-55, 10, 45, 20);
  myButton.setColorBackground(color(0, 200));
  myButton.setColorActive(color(0, 255));
  myButton.setColorForeground(color(80, 200));

  toggles[0] = new FacetToggle(10, 10, "Subject", 0);
  toggles[1] = new FacetToggle(10, 40, "Format", 1);
  toggles[2] = new FacetToggle(10, 70, "Language", 2);
  toggles[3] = new FacetToggle(10, 100, "Creator", 3);
  toggles[4] = new FacetToggle(10, 130, "Publisher", 4);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.controller().name()=="submit>>") {
    filterKeyword = myTextfield.getText();

    //Make the user wait
    cursor(WAIT);

    queryAPI();
    myTextfield.setText("");
  }
}

void keyPressed() {
  //Submit Search Query
  if (key == ENTER) {
    String[] textReceived = myTextfield.getTextList();
    filterKeyword = textReceived[constrain(textReceived.length - 1, 0, textReceived.length)];

    //Make the user wait while search
    cursor(WAIT);

    //Make the search to the api and reset textbox
    queryAPI();
    myTextfield.setText("");
  }

  //Export Timeline Image
  if (key == '1') save("faceter.jpg");
}

void mouseClicked() {
  for (int i = 0; i < toggles.length; i++) {
    toggles[i].clicked();
  }
}

void checkCursor() {
  boolean hand = false;
  stroke(0);

  for (int i = 0; i < toggles.length; i++) {
    toggles[i].draw();
    hand = hand || toggles[i].mouseOver();
  }

  ArrayList facetDisplay = new ArrayList();
  if (faceter == 0) facetDisplay = subjectFacets;
  else if (faceter == 1) facetDisplay = formatFacets;
  else if (faceter == 2) facetDisplay = langFacets;
  else if (faceter == 3) facetDisplay = creatorFacets;
  else if (faceter == 4) facetDisplay = pubFacets;
  for (int i = 0; i < facetDisplay.size(); i++) {
    Facet facet = (Facet) facetDisplay.get(i);
    if (facet.mouseOver()) facet.label();
  }

  //Check if over buttons
  hand = hand ||(mouseX > width-55 && mouseX < width-10 && mouseY > 10 && mouseY < 30);
  cursor(hand ? HAND : ARROW);
}

void queryAPI() {
  //Replace any spaces in the search query with %20
  if (match(filterKeyword, " ") != null) {
    String[] keySplit = split(filterKeyword, ' ');
    filterKeyword = join(keySplit, "%20");
  }

  //Compile Query Request
  String search = baseURL + "?filter=" + "dpla.subject_keyword:" + filterKeyword;
search = search + "&facet=dpla.subject&facet=dpla.format&facet=dpla.language&facet=dpla.creator&facet=dpla.publisher";
  println(search);

  //Request Search from API
  response = join(loadStrings(search), "");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  total = Data1.getInt("num_found");
  println("Total Items Found = " + total);

  JSONparser();
}

void JSONparser() {
  subjectFacets.clear();
  formatFacets.clear();
  langFacets.clear();
  creatorFacets.clear();
  pubFacets.clear();

  try {
    JSONObject Data1 = new JSONObject(response);
    JSONArray results = Data1.getJSONArray("facets");
    JSONObject facetResults = Data1.getJSONObject("facets");

    for (int j = 0; j < facetNames.length; j++) {
      JSONObject facetArray = facetResults.getJSONObject("dpla." + facetNames[j]);

      String[] arrayNames = facetArray.getNames(facetArray);

      //Calculate Total of Records Being Faceted
      int qtyTotal = 0;
      for (int i = 0; i < arrayNames.length; i++) {
        int quantity = facetArray.getInt(arrayNames[i]);
        qtyTotal = qtyTotal + quantity;
      }

      //Calculate X-Position and Create Facet Object
      float xPosAdd = 0;
      for (int i = 0; i < arrayNames.length; i++) {
        int quantity = facetArray.getInt(arrayNames[i]);
        float xWide = (float(quantity)/float(qtyTotal))*width;
        color base = colorList[int(random(0, 4))];
        Facet newAdd = new Facet(arrayNames[i], xPosAdd, xWide, quantity, color(red(base), green(base), blue(base), int(random(50, 255))));

        if (j == 0) subjectFacets.add(newAdd);
        else if (j == 1) formatFacets.add(newAdd);
        else if (j == 2) langFacets.add(newAdd);
        else if (j == 3) creatorFacets.add(newAdd);
        else pubFacets.add(newAdd);
        xPosAdd = xPosAdd + xWide;
      }
    }
  }
  catch(NullPointerException f) {
    println("There was an error parsing the JSONObject.");
  }
  println("Facets : " + subjectFacets.size());
}

class Facet {
  String name;
  float x, xWide;
  int quantity;
  color colorFill;
  int flip = 0;

  Facet(String n, float xPos, float xW, int qty, color cF) {
    name = n;
    x = xPos;
    xWide = xW;
    quantity = qty;
    colorFill = cF;
  }

  void draw() {
    fill(colorFill);
    stroke(0);
    if (mouseOver()) strokeWeight(3);
    else noStroke();
    rect(x, 0, xWide, height);
  }

  boolean mouseOver() {
    return mouseX > x && mouseX < x + xWide;
  }

  void label() {
    fill(0);
    textAlign(CENTER);

    if (mouseX > width - 150) flip = -1;
    else flip = 0;

    //rect(mouseX + 150*flip, mouseY - 85, 150, 85);
    //fill(255);
    fill(0);
    textFont(font2);
    text(name, mouseX + 150*flip, mouseY - 75);
    text(quantity + " items", mouseX + 150*flip, mouseY - 20);
    String percent = nfc((float(quantity)/float(total))*100, 1) + "%";
    text(percent, mouseX + 150*flip, mouseY);
  }
}

class FacetToggle {
  int x, y, facetIndex;
  String name;

  FacetToggle(int xPos, int yPos, String n, int fI) {
    x = xPos;
    y = yPos;
    name = n;
    facetIndex = fI;
  }

  void draw() {
    if (mouseOver()) fill(80, 180);
    else fill(0, 180);
    if (faceter == facetIndex) fill(150, 180);
    rect(x, y, 80, 20);
    fill(255);
    textFont(font1);
    textAlign(CENTER);
    text(name, x + 40, y + 15);
  }

  boolean mouseOver() {
    return mouseX > x && mouseX < x + 150 && mouseY > y && mouseY < y + 20;
  }

  void clicked() {
    if (mouseOver()) {
      faceter = facetIndex;
    }
  }
}


