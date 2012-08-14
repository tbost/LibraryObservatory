color[] facetColors = {
  color(255, 0, 255, 200), color(255, 255, 0, 200), color(0, 255, 255, 200), color(0, 0, 255, 200), color(0, 255, 0, 200), color(70, 70, 70, 200)
};

void plotAccessions() { 
  if (faceter != "" && match(faceter, "clear") == null) {
    //Facet Coloration by Faceter Field && Do NOT Aggregate Strokeweights by Date

    //Isolate Only Facet Names from Facet List
    String[] facetNames = new String[facetList.length];
    for (int i = 0; i < facetList.length; i++) {
      String[] facetNameCounts = split(facetList[i], "**");
      if(i == facetList.length - 1) facetNames[i] = "Other";
      else facetNames[i] = facetNameCounts[1];
    }

    //Draw the All Curves with the Same Strokweight but Colored
    bgImage.beginDraw();
    bgImage.smooth();
    for (int i = 0; i < records.length; i++) {
      float xPubYear = map(records[i].date, yearStart, yearEnd, 0, width);
      xPubYear = constrain(xPubYear, 0, width);

      //Assign Color By Its Facet
      for (int k = 0; k < facetNames.length; k++) {
        if (match(records[i].publisher, facetNames[k]) != null || match(records[i].subject, facetNames[k]) != null || match(records[i].format, facetNames[k]) != null || match(records[i].language, facetNames[k]) != null) {
          bgImage.stroke(red(facetColors[k]), green(facetColors[k]), red(facetColors[k]), 150);
          break;
        }
        else bgImage.stroke(red(facetColors[facetColors.length - 1]), green(facetColors[facetColors.length - 1]), red(facetColors[facetColors.length - 1]), 5);
      }

      bgImage.noFill();
      bgImage.strokeWeight(.75);
      bgImage.bezier(xSample, height - 35, xSample, height/2, xPubYear, height/2, xPubYear, 35);
    }

    //Draw Facet Legend
    for (int i = 0; i < facetNames. length; i++) {
      //DOES NOT AGGREGATE THE 'OTHER' CATEGORY
      bgImage.fill(facetColors[i]);
      bgImage.rect(width - 160, height/2 - 60 + 20*i + 70, 150, 15);
      bgImage.fill(0);
      bgImage.textAlign(CENTER);
      bgImage.textLeading(4);
      bgImage.textFont(font0);
      bgImage.textSize(10);
      bgImage.text(facetNames[i], width - 160, height/2 - 58 + 20*i + 70, 150, 15);
    }
    bgImage.endDraw();

    accDrawn = true;
  }
  else {
    //Scale Lineweight to Counts (Best to do this once at JSONparsing, not every time)
    int[] dateFacet = new int[yearEnd - yearStart];
    for (int i = 0; i < records.length; i++) {
      int d = records[i].date - yearStart - 1;
      if (d >= 0 && d < yearEnd - yearStart) dateFacet[d]++;
    }

    //Draw the Curves With Lineweights Scaled to Aggregated Counts of Records for Each Publication Year
    bgImage.beginDraw();
    bgImage.smooth();
    for (int i = 0; i < dateFacet.length; i++) {
      float xPubYear = map(i + yearStart, yearStart, yearEnd, 0, width);
      xPubYear = constrain(xPubYear, 0, width);

      bgImage.noFill();
      float strWeight = map(dateFacet[i], 0, 60, .5, 20);
      strWeight = constrain(strWeight, .5, 20);
      bgImage.strokeWeight(strWeight);
      bgImage.stroke(255, 0, 255, 100);
      if (dateFacet[i] > 0) bgImage.bezier(xSample, height - 35, xSample, height/2, xPubYear, height/2, xPubYear, 35);
    }
    bgImage.endDraw();

    accDrawn = true;
  }
}

