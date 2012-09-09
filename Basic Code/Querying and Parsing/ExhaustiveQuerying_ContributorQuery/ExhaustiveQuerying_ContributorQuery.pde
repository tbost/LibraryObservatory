/*********************************************
This sketch is a work-around for the API-imposed
record return limit.  By making multiple queries to
the API, all or a specified maximum number of results
can be retrieved.  The unparsed JSON results are
then output as a text file.
*********************************************/

//Load JSON4processing Library
import org.json.*;

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

PrintWriter output;
int pageNum = 1;
String start = "0";
String[] responseList = new String[0];

void setup() {
  //Printer Object to Output Text File
  output = createWriter("contributor_output.txt");

  //Compile Query Request
  String search = baseURL + "?filter=" + filter + query + "&limit=" + limit + "&start=" + start + "&facet=" + facet;

  //Request Search from API
  String response = join(loadStrings(search), "");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  int total = Data1.getInt("num_found");
  println("Total Items Found = " + total);

  //Add this first response to the list of responses
  responseList = append(responseList, response);

  //Retrieve all the full pages of records
  for (int i = 0; i < ceil(total/int(limit)); i++) {
    start = str(int(limit)*pageNum);
    search = baseURL + "?filter=" + filter + query + "&limit=" + limit + "&start=" + start;
    println("Page: " + (pageNum + 1));
    response = join(loadStrings(search), "");
    responseList = append(responseList, response);

    pageNum++;
  }

  //Retrieve the remainder of records
  if (total > ceil(total/int(limit))*int(limit)) {
    start = str(int(start) + int(limit)*pageNum);
    search = baseURL + "?filter=" + filter + query + "&start=" + start;
    response = join(loadStrings(search), "");
    responseList = append(responseList, response);
  }

  println("Total Pages = " + responseList.length);

  for (int i = 0; i < responseList.length; i++) {
    output.println(responseList[i]);
  }
  output.flush();
  output.close();
  exit();
}

