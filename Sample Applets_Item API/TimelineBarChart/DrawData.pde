float maxValue = 0;
String maxUnits = "";

void drawData() {  
  //CALCULATE TOTALS
  int[] itemCount = new int[timeEnd - timeBegin];
  int[] pageCount = new int[timeEnd - timeBegin];
  float[][] spineCount = new float[timeEnd - timeBegin][2];
  for (int i = 0; i < records.size(); i++) {
    Record record = (Record) records.get(i);

    //Limit to records from time covered by timeline
    if (record.date > timeBegin && record.date < timeEnd) {
      //Tally Total Items for Each Year
      itemCount[record.date - timeBegin]++;

      //Tally Total Page Counts for Each Year
      pageCount[record.date - timeBegin] = pageCount[record.date - timeBegin] + record.pages;

      //Tally Average Spine Height for Each Year
      spineCount[record.date - timeBegin][0]++;
      spineCount[record.date - timeBegin][1] = spineCount[record.date - timeBegin][1] + record.spine;
    }
  }

  //Make List of Spine Averages from Totals and Counts
  float[] spineAvgs = new float[spineCount.length];
  for (int i = 0; i < spineAvgs.length ; i++) {
    float avg = spineCount[i][1]/spineCount[i][0];
    if (avg > 0) spineAvgs[i] = avg;
  }

  //DRAW LINES
  for (int i = 0; i < itemCount.length; i++) {
    //Locate Year on Timeline
    float timeLinePos = map(i, 0, timeEnd - timeBegin, width/2 - 200*zoomLevel, width/2 + 200*zoomLevel);
    timeLinePos = constrain(timeLinePos, width/2 - 200*zoomLevel, width/2 + 200*zoomLevel);

    //Sort by Items
    if (sortBy == "items") {
      //Find Max Count of Items in a Given Year
      int[] maxCount = sort(itemCount);
      maxCount = reverse(maxCount);
      maxValue = maxCount[0];
      maxUnits = " items";

      //Scale Vertical Lines in Comparison to Maximum Count
      float lineHeight = map(itemCount[i], 0, maxCount[0], 0, height);
      lineHeight = (height - lineHeight)/2;

      //Draw Lines
      stroke(255, 0, 255, 150);
      strokeWeight(3);
      if (itemCount[i] != 0) line(timeLinePos, lineHeight, timeLinePos, height - lineHeight);
    } 
    //Sort by Pages
    else if (sortBy == "pages") {
      //Find Max Count of Items in a Given Year
      int[] maxCount = sort(pageCount);
      maxCount = reverse(maxCount);
      maxValue = maxCount[0];
      maxUnits = " pages";

      //Scale Vertical Lines in Comparison to Maximum Count
      float lineHeight = map(pageCount[i], 0, maxCount[0], 0, height);
      lineHeight = (height - lineHeight)/2;

      //Draw Lines
      stroke(0, 255, 255, 150);
      strokeWeight(3);
      if (pageCount[i] != 0) line(timeLinePos, lineHeight, timeLinePos, height - lineHeight);
    } 
    //Sort by Spine Height
    else if (sortBy == "size") { 
      //Find Max Count of Items in a Given Year
      float[] maxCount = sort(spineAvgs);
      maxCount = reverse(maxCount);
      maxValue = maxCount[0];
      maxUnits = " cm.";

      //Scale Vertical Lines in Comparison to Maximum Count
      float lineHeight = map(spineAvgs[i], 0, maxCount[0], 0, height);
      lineHeight = (height - lineHeight)/2;

      //Draw Lines
      stroke(0, 255, 0, 150);
      strokeWeight(3);
      if (spineAvgs[i] != 0) line(timeLinePos, lineHeight, timeLinePos, height - lineHeight);
    }
  }
}

void drawStaticInfo() {
  translate(-moveT, mY);

  //Replace any spaces in the search query with %20
  if (match(filter1, "%20") != null) {
    String[] keySplit = split(filter1, "%20");
    filter1 = join(keySplit, "  ");
  }
  //Display Search Term in Bottom Left Corner
  textAlign(LEFT);
  textFont(font);
  text("\"" + filter1 + "\"", 5, height - 10);

  //Draw Scale
  for (float k = 10; k > 0; k--) {
    stroke(100);
    strokeWeight(.25);
    line(0, height/2 - (k/10.0)*height/2, width, height/2 - (k/10.0)*height/2);
    fill(100);
    textFont(font2);
    text(nfc(maxValue - (k/10.0)*maxValue, 1) + maxUnits, 5, (k/10.0)*height/2);
  }
}

