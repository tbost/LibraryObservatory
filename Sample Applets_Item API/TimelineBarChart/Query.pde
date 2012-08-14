void queryAPI() {
  responseList = new String[0];
  int pageNum = 1;
  start = "0";
  //String limitTotal;

  //Replace any spaces in the search query with %20
  if (match(filter1, " ") != null) {
    String[] keySplit = split(filter1, ' ');
    filter1 = join(keySplit, "%20");
  }

  //Compile Query Request
  String search = baseURL + "&filter=" + "dpla.subject_keyword:" + filter1 + "&limit=" + limit1 + "&start=" + start;

  //Request Search from API
  response = join(loadStrings(search), "");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  int total = Data1.getInt("num_found");
  println("Total Items Found = " + total);
  println("Items Retrieved = " + limitTotal);

  //Add this first response to the list of responses
  responseList = append(responseList, response);

  //Retrieve all the full pages of records
  for (int i = 0; i < ceil(int(limitTotal)/int(limit1)); i++) {
    start = str(int(limit1)*pageNum);
    search = baseURL + "&filter=" + "dpla.subject_keyword:" + filter1 + "&limit=" + limit1 + "&start=" + start;
    response = join(loadStrings(search), "");
    responseList = append(responseList, response);

    pageNum++;
  }

  //Retrieve the remainder of records
  start = str(int(start) + int(limit1)*pageNum);
  search = baseURL + "?start=" + start;
  response = join(loadStrings(search), "");
  responseList = append(responseList, response);

  println("Total Pages = " + responseList.length);
  
  JSONparser();
}

