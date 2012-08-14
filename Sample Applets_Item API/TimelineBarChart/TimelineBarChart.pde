import org.json.*;

String baseURL = "http://api.dp.la/v0.03/item/?filter=dpla.contributor:harvard_edu";
String filter1 = "egypt";
String limit1 = "450";
String limitTotal = "10000";
String start = "0";
String response;

void setup() {
  setupInterface();

  queryAPI();

  smooth();
}

void draw() {
  drawTimeline();

  drawData();
  
  drawStaticInfo();

  strokeWeight(1);
  checkCursor();
}



