void drawTimelines() {
  //Year Timeline
  stroke(0);
  strokeWeight(10);
  textFont(font0);
  line(0, 35, width, 35);
  for (int i = 0; i < yearEnd - yearStart + 1; i++) {
    float xPos = map(i, 0, yearEnd - yearStart, 0, width);
    if (i%10 == 0) {
      fill(0);
      textAlign(LEFT);
      pushMatrix();
      rotate(HALF_PI);
      text(yearStart + i, 65, -xPos);
      popMatrix();
      strokeWeight(2.5);
    }
    else strokeWeight(.25);
    line(xPos, 10, xPos, 60);
  }


  //Day Timeline
  strokeWeight(10);
  line(0, height - 35, width, height - 35);
  for (int i = 0; i < monthsTotal; i++) {
    float xPos = map(i, 0, monthsTotal, 0, width);
    if ((i + 6)%12 == 0) {
      fill(0);
      textAlign(RIGHT);
      pushMatrix();
      rotate(HALF_PI);
      textFont(font0);
      text(2003 + i/12, height - 65, -xPos);
      strokeWeight(2);
      popMatrix();
    }
    else strokeWeight(.5);
    line(xPos, height - 60, xPos, height - 10);
  }

  //Legend
  if (dateCode != null && dateCode != "") {
    String yearNum = dateCode.substring(0, 4);
    String monthNameIndex = dateCode.substring(4, 6);
    String dayNum = dateCode.substring(6, 8);
    fill(0);
    textAlign(RIGHT);
    textFont(font1);
    text(int(dayNum) + " / " + int(monthNameIndex) + " / " + yearNum, width - 5, height - 140);
    textFont(font0);
    text(nfc(records.length, 0) + " Records", width - 5, height - 120);
  }
}

