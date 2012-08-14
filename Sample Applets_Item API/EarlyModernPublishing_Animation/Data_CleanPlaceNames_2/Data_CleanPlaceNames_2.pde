PrintWriter output;
String[] pubLocList, changeList;

/*
This script simply regulates all the places names of the records
that are in multiple languages are use multiple spellings to
facilitate their matching and geolocation in the final animation
*/

void setup() {
  output = createWriter("Records_1440_1700_Cleaned.txt");
  pubLocList = loadStrings("Records_1440_1700.txt");
  changeList = loadStrings("City Name Changes.csv");

  for (int i = 0; i < pubLocList.length; i++) {
    String[] pubLine = split(pubLocList[i], '*');
    println(pubLocList[i]);

    for (int k = 0; k < changeList.length; k++) {
      String[] changeLine = split(changeList[k], ',');
      if (match(pubLine[4], changeLine[0]) != null) {
        pubLine[4] = changeLine[1];
        break;
      }
    }

    output.println(pubLine[0] + "\t" + pubLine[1] + "\t" + pubLine[2] + "\t" + pubLine[3] + "\t" + pubLine[4]);
  }

  output.flush();
  output.close();
  println("DONE!!!");
  exit();
}

