void Legend() {
  fill(255);  
  pushMatrix();
  rotate(HALF_PI);
  for (int i = 0; i < countries.length; i++) {    
    text(countries[i], 3*height/4, -(i*(width - 100)/(countries.length - 1) + 50));
  }
  popMatrix();
}

void drawCounts() {
  fill(255);
  noStroke();
  for (int i = 0; i < countryCount.length; i++) {
    for (int k = 0; k < countryCount[i]; k++) {
      rectMode(CENTER);
      rect(i*(width - 100)/(countries.length - 1) + 50, 3*height/4 - 10 - k*3, 10, 2);
    }
  }
}

void drawConnections() {
  for (int i = 0; i < cxnList.length; i++) {
    int[] cxnPts = int(split(cxnList[i], '-'));

    for (int k = 0; k < cxnPts.length - 1; k++) {
      noFill();
      stroke(0, 255, 255, 50);
      strokeWeight(1);
      float begin = cxnPts[k]*(width - 100)/(countries.length - 1) + 50;
      float end = cxnPts[k + 1]*(width - 100)/(countries.length - 1) + 50;
      float high = abs(begin - end);
      high = map(high, 0, width/2, 0, height);// 3*height/4 + 100);
      high = 3*height/4 - 10 - high;
      bezier(begin, 3*height/4 - 10, begin, high, end, high, end, 3*height/4 - 10);
    }
  }
}
