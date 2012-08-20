/*********************************************
This sketch simply makes a keyword search to the
DPLA Contributor API for libraries in the IMLS
that are located in Texas, then prints the JSON
results, unparsed to the window.
*********************************************/

//URL of Contributor API
String baseURL = "http://api.dp.la/v0.03/contributor/";

//Search Filter (see DPLA Contributor API Guide for Other Search Fields)
String filter = "dpla.location.address.state:";

//Filter Term
String query = "TX";

//Limit the Number of Records to Return (Maximum: 150; Default: 100)
String limit = "100";

//Field by Which to Facet Results
String facet = "dpla.location.address.city";

void setup() {
  //Compile Query Request
  String search = baseURL + "?filter=" + filter + query + "&limit=" + limit + "&facet=" + facet;

  //Request Search from API
  String response = join(loadStrings(search), "");

  //Print the JSON Result
  println(response);
}

