import org.json.*;

String baseURL = "http://api.dp.la/v0.03/item/";
String filter1 = "dpla.keyword:"
String query = "ancient egypt";
String limit1 = "450";
String response;

void setup() {
  setupInterface();

  //Compile Query Request
  String search = baseURL + "?filter=" + filter1 + "&limit=" + limit1;

  //Request Search from API
  response = join(loadStrings(search), "");
  //println(response);

  smooth();
}

void draw() {
  strokeWeight(20);
  stroke(100);
  line(0, height/2, width, height/2);
}

