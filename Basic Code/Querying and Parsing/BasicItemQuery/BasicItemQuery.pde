/*********************************************
 This sketch simply makes a keyword search to the
 DPLA Item API for records on 'ancient egypt', then
 prints the JSON results, unparsed to the window.
 *********************************************/

//URL of Item API
String baseURL = "http://api.dp.la/v0.03/item/";

//Search Filter (see DPLA Item API Guide for Other Search Fields)
String filter = "dpla.keyword:";

//Filter Term
String query = "ancient egypt";

//Limit the Number of Records to Return (Maximum: 500; Default: 100)
String limit = "450";

//Field by Which to Facet Results
String facet = "dpla.creator";

void setup() {
  //Replace Any Spaces in the Search Query with '%20'
  if (match(query, " ") != null) {
    String[] keySplit = split(query, " ");
    query = join(keySplit, "%20");
  }

  //Compile Query Request
  String search = baseURL + "?filter=" + filter + query + "&limit=" + limit + "&facet=" + facet;
  println(search);
  println();

  //Request Search from API
  String response = join(loadStrings(search), "");

  //Print the JSON Result
  println(response);
}

