/*********************************************
This sketch is a work-around for the API-imposed
record return limit.  By making multiple queries to
the API, all or a specified maximum number of results
can be retrieved.  The unparsed JSON results are
then output as a text file.
*********************************************/

//Load JSON4processing Library
import org.json.*;

//URL of Item API
String baseURL = "http://api.dp.la/v0.03/item/";

//Search Filter (see DPLA Item API Guide for Other Search Fields)
String filter = "dpla.keyword:";

//Filter Term
String query = "ancient egypt";

//Limit the Number of Records to Return (Maximum: 400; Default: 100)
String limit = "400";
String start = "0";

//Field by Which to Facet Results
String facet = "dpla.creator";

//Maximum Number of Records to Return from All Pages
int maxLimit = 5000;

PrintWriter output;

void setup() {
  //Printer Object to Output Text File
  output = createWriter("item_output.txt");

  //Replace Any Spaces in the Search Query with '%20'
  if (match(query, " ") != null) {
    String[] keySplit = split(query, " ");
    query = join(keySplit, "%20");
  }

  //Compile Query Request
  String search = baseURL + "?filter=" + filter + query + "&limit=" + limit + "&start=" + start + "&facet=" + facet;

  //Request Search from API
  String response = join(loadStrings(search), "");
  String[] responseList = new String[0];
  println("Page: 1");

  //Find out how many items total are found
  JSONObject Data1 = new JSONObject(response);
  int total = Data1.getInt("num_found");

  //Add this first response to the list of responses
  responseList = append(responseList, response);

  //Retrieve all the full pages of records
  int pageNum = 1;
  for (int i = 0; i < ceil(total/int(limit)); i++) {
    start = str(int(limit)*pageNum);
    search = baseURL + "?filter=" + filter + query + "&limit=" + limit + "&start=" + start;
    println("Page: " + (pageNum + 1));
    response = join(loadStrings(search), "");
    responseList = append(responseList, response);

    pageNum++;
    if ((pageNum + 1)*int(limit) > maxLimit) break;
  }

  //Retrieve the remainder of records
  boolean remainder = total > ceil(total/int(limit))*int(limit);
  boolean underMax = (pageNum + 1)*int(limit) < maxLimit;
  if (remainder && underMax) {
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

