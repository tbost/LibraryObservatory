String baseURL = "http://api.dp.la/v0.03/item/";
String filterKeyword = "";
String facetLimit = "100";
int total;

void queryAPI() {
  //Replace any spaces in the search query with %20
  if (match(filterKeyword, " ") != null) {
    String[] keySplit = split(filterKeyword, ' ');
    filterKeyword = join(keySplit, "%20");
  }

  //Compile Query Request
  String search = baseURL + "?filter=" + "dpla.subject_keyword:" + filterKeyword;
search = search + "&facet=dpla.subject&facet=dpla.format&facet=dpla.language&facet=dpla.creator&facet=dpla.publisher";
  println(search);

  //Request Search from API
  response = join(loadStrings(search), "");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  total = Data1.getInt("num_found");
  println("Total Items Found = " + total);

  JSONparser();
}

