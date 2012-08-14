import org.json.*;
PrintWriter output;
int cumTotal = 0;

void setup(){
  output = createWriter("AccessionsTotal.txt");
}

//Acquisition Data is available between: 20020609 - 20120330 | Total: 3,582 Days; 4,265,104 Records
int dayCounter = 1;
int monthCounter = 7;
int yearCounter = 2002;

void draw() {
  String response = join(loadStrings("http://api.dp.la/v0.03/item/?filter=dpla.contributor:harvard_edu&filter=988a:" + str(yearCounter) + nf(monthCounter, 2) + nf(dayCounter, 2)), "");

  JSONObject Data1 = new JSONObject(response);
  int total = Data1.getInt("num_found");
  output.println(str(yearCounter) + nf(monthCounter, 2) + nf(dayCounter,2) + "\t" + total);
  println(str(yearCounter) + nf(monthCounter, 2) + nf(dayCounter,2) + "\t" + total);
  cumTotal = cumTotal + total;

  dayCounter++;
  if (dayCounter > 31) {
    dayCounter = 1;
    monthCounter++;
  }
  else if (dayCounter > 30 && (monthCounter == 4 || monthCounter == 6 || monthCounter == 9 || monthCounter == 11)) {
    dayCounter = 1;
    monthCounter++;
  }
  else if (dayCounter > 28 && monthCounter == 2) {
    dayCounter = 1;
    monthCounter++;
  }

  if (monthCounter > 12) {
    monthCounter = 1;
    yearCounter++;
  }

  if (dayCounter > 30 && monthCounter == 3 && yearCounter == 2012) {
    output.println("Cumulative Total : " + cumTotal);
    println("Cumulative Total : " + cumTotal);
    output.flush();
    output.close();
    exit();
  }
}

