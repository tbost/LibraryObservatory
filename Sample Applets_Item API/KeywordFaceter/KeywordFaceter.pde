color[] colorList = {
  color(255, 0, 255), color(0, 255, 255), color(255, 255, 0), color(0, 255, 0)
};

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

