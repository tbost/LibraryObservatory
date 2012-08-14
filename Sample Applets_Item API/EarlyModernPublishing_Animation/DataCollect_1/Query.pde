String[] responseList;
int total;
void queryAPI(int yr) {
  responseList = new String[0];
  int pageNum = 1;
  start = "0";
  total = 0;

  try {
    //Compile Query Request
    String search = baseURL + "&filter=" + "dpla.date:" + str(yr) + "&limit=" + limit1 + "&start=" + start;

    //Request Search from API
    response = join(loadStrings(search), "");

    //Find out how many items total are found
    JSONObject Data1 = new JSONObject(response);
    total = Data1.getInt("num_found");
  } 
  catch(NullPointerException e) {
    response = "";
  }

  print(yr + " : ");
  println(total);

  //Add this first response to the list of responses
  responseList = append(responseList, response);

  try {
    //Retrieve all the full pages of records
    if (total > int(limit1)) {
      for (int i = 0; i < ceil(int(total)/int(limit1)); i++) {
        start = str(int(limit1)*pageNum);
        String search = baseURL + "&filter=" + "dpla.date:" + str(yr) + "&limit=" + limit1 + "&start=" + start;
        response = join(loadStrings(search), "");
        responseList = append(responseList, response);

        pageNum++;
      }

      String search = baseURL + "&filter=" + "dpla.date:" + str(yr) + "&limit=" + str(total - (pageNum - 1)*int(limit1)) + "&start=" + start;
    }
  }
  catch(NullPointerException e) {
  }

  println("Total Pages = " + responseList.length);

  if (total > 0) JSONparser();
}

