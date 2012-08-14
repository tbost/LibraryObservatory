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

