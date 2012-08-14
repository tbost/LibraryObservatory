import org.json.*;
PrintWriter output;
String baseURL = "http://api.dp.la/v0.03/item/?filter=dpla.contributor:npr_org";
int pageNum = 1;
String limit1 = "500";//Max 500
String start = "0";
String response;
String[] responseList = new String[0];

void setup() {
  output = createWriter("NPR_output.txt");

  //Compile Query Request
  String search = baseURL + "&limit=" + limit1 + "&start=" + start + "&facet=dpla.creator";
  println(search);

  //Request Search from API
  response = join(loadStrings(search), "");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  int total = Data1.getInt("num_found");
  println("Total Items Found = " + total);

  //Add this first response to the list of responses
  responseList = append(responseList, response);

  //Retrieve all the full pages of records
  for (int i = 0; i < ceil(total/int(limit1)); i++) {
    start = str(int(limit1)*pageNum);
    search = baseURL + "&limit=" + limit1 + "&start=" + start;
    println(search);
    response = join(loadStrings(search), "");
    responseList = append(responseList, response);

    pageNum++;
  }

  //Retrieve the remainder of records
  start = str(int(start) + int(limit1)*pageNum);
  search = baseURL + "&start=" + start;
  println(search);
  response = join(loadStrings(search), "");
  responseList = append(responseList, response);

  println("Total Pages = " + responseList.length);

  for (int i = 0; i < responseList.length; i++) {
    output.println(responseList[i]);
  }
  output.flush();
  output.close();
  println("DONE!");
  exit();
}
