import org.json.*;
PrintWriter output;
String baseURL = "http://api.dp.la/v0.03/item/?filter=dpla.contributor:harvard_edu";
String filter1;
String limit1 = "450";
String start = "0";
String response;
int timeBegin = 1440; //Year of the invention of the Gutenberg Press (moveable type)
int timeEnd = 1700;

void setup() {
  output = createWriter("Records_1440_1700.txt");
  for (int i = 0; i < timeEnd - timeBegin; i++) {
    queryAPI(i + timeBegin);

    for (int j = 0; j < records.size(); j++) {
      Record record = (Record) records.get(j);
      //Only retrieve those items labeled as mongraphs or monograph parts, in order to try to avoid hand-written manuscripts
      //However this is does not completely eliminate such records from the data set
      if (match(record.format, "language material -- monograph / item") != null || match(record.format, "language material -- monographic component part") != null) output.println(record.date + "*" + record.title + "*" + record.publisher + "*" + record.language + "*" + record.location);
    }
  }

  output.flush();
  output.close();
  println("DONE!!!");
  exit();
}

