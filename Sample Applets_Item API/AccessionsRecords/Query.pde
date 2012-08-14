import org.json.*;
String baseURL = "http://api.dp.la/v0.03/item/?filter=dpla.contributor:harvard_edu&facet=dpla.publisher&facet=dpla.subject&facet=dpla.format&facet=dpla.language&";
String[] responseList;
String start;
String limit1 = "400";
String response;

void queryAPI() {
  responseList = new String[0];
  int pageNum = 1;
  start = "0";

  //Compile Query Request
  String search = baseURL + "filter=" + "988a:" + dateCode + "&limit=" + limit1 + "&start=" + start;

  //Request Search from API
  response = join(loadStrings(search), "");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  int total = Data1.getInt("num_found");
  println("Total Items Found = " + total);

  if (total > 0) {
    //Add this first response to the list of responses
    responseList = append(responseList, response);

    if (total/int(limit1) > 0) {
      //Retrieve all the full pages of records
      for (int i = 0; i < ceil(total/int(limit1)) + 1; i++) {
        start = str(int(limit1)*pageNum);
        search = baseURL + "filter=" + "988a:" + dateCode + "&limit=" + limit1 + "&start=" + start;
        try {
          response = join(loadStrings(search), "");
          responseList = append(responseList, response);
        }
        catch(NullPointerException e) {
          print("Woops! Fucked up again!");
          break;
        }
        pageNum++;
      }

      //Retrieve the remainder of records
      start = str(int(start) + int(limit1)*pageNum);
      search = baseURL + "filter=" + "988a" + dateCode + "start=" + start;
      response = join(loadStrings(search), "");
      responseList = append(responseList, response);
    }  

    JSONparser();
  }
}

