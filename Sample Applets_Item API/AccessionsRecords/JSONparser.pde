Record[] records = new Record[0];
int[] dateFacet;
String[] facetList;
String faceter = "";

void JSONparser() {
  records = new Record[0];
  dateFacet = new int[0];
  facetList = new String[0];

  try {
    try {
      //Get Top 5 Facets
      if (faceter != "") {
        JSONObject DataF = new JSONObject(responseList[0]);
        JSONObject facetResults = DataF.getJSONObject("facets");
        JSONObject facetArray = facetResults.getJSONObject(faceter);
        String[] arrayNames = facetArray.getNames(facetArray);
        for (int i = 0; i < min(arrayNames.length, 6); i++) {
          //Join Name of Facet Field (e.g. "language material -- collection") with Its Count Total to Faciliate Later Sorting, Then Split Them
          String facetNameCountJoin = str(facetArray.getInt(arrayNames[i])) + "**" + arrayNames[i];
          facetList = append(facetList, facetNameCountJoin);
        }
        //Put Facet List in Order by Large to Smallest
        facetList = sort(facetList);
        facetList = reverse(facetList);
      }

      //Cycle Through All Pages of Responses
      for (int j = 0; j < responseList.length; j++) {
        JSONObject Data1 = new JSONObject(responseList[j]);
        JSONArray results = Data1.getJSONArray("docs");

        //Analyse All Records on this Page
        for (int i = 0; i < results.length(); i++) {
          JSONObject entry = results.getJSONObject(i);

          //Retrieve Item Publisher
          JSONArray publisherArray = entry.getJSONArray("dpla.publisher");
          String[] publisher = new String[0];
          if (publisherArray != null) {
            publisher = new String[publisherArray.length()];
            for (int k = 0; k < publisherArray.length(); k++) {
              publisher[k] = publisherArray.getString(k);
            }
          }

          //Retrieve Item Lanaguage
          String language = entry.getString("dpla.language");

          //Retrieve Item Format
          String format = entry.getString("dpla.format");

          //Retrieve List of Subject Categories
          JSONArray subjectArray = entry.getJSONArray("dpla.subject");
          String[] subject = new String[0];
          if (subjectArray != null) {
            subject = new String[subjectArray.length()];
            for (int k = 0; k < subjectArray.length(); k++) {
              subject[k] = subjectArray.getString(k);
            }
          }

          //Retrieve Publication Date
          int date = entry.getInt("dpla.date");

          records = (Record[]) append(records, new Record(date, join(publisher, ' '), language, format, join(subject, ' ')));
        }
      }
    }
    catch(JSONException e) {
      println("There was an error parsing the JSONObject.");
    }
  }
  catch(NullPointerException e) {
    println("There was a NullPointerExcepiton parsing the JSONObject.");
  }
  println("Records : " + records.length);

  println(facetList);
  plotAccessions();
}

class Record {
  int date;
  String publisher, language, format, subject;

  Record(int d, String p, String l, String f, String sbj) {
    date = d;
    publisher = p;
    language = l;
    format = f;
    subject = sbj;
  }
}

