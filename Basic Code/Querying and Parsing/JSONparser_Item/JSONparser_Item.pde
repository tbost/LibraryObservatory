/*********************************************
 This function parses the JSON responses from the
 Item API.  The responses are fed to the function
 as Strings and two array lists are created, one
 the holds the basic DPLA fields for the records,
 and the other holds MARC specific field info.
 These array lists and the fields of each record
 can then be easily called when needed else where
 in a sketch.
 *********************************************/

import org.json.*;
ArrayList records = new ArrayList();
ArrayList marcRecords = new ArrayList();

void JSONparser(String response) {
  try {
    JSONObject Data1 = new JSONObject(response);
    JSONArray results = Data1.getJSONArray("docs");

    for (int i = 0; i < results.length(); i++) {
      JSONObject entry = results.getJSONObject(i);

      //Retrieve Item Title
      String title = entry.getString("dpla.title");

      //Retrieve Item Publisher
      String publisher = entry.getString("dpla.publisher");

      //Retrieve Item Lanaguage
      String language = entry.getString("dpla.language");

      //Retrieve Item Format
      JSONArray formatArray = entry.getJSONArray("dpla.format");
      String[] format = new String[0];
      if (formatArray != null) {
        format = new String[formatArray.length()];
        for (int k = 0; k < formatArray.length(); k++) {
          format[k] = formatArray.getString(k);
        }
      }

      //Retrieve Publication Date
      int date = entry.getInt("dpla.date");

      //Retrieve Page Count (may also be reworked for 'leaves', 'volumes', or 'images'
      String page = entry.getString("300a");
      int p = page.indexOf("p.");
      int pages;
      if (p != -1) {
        int b = constrain(p - 4, 0, p);
        pages = int(trim(page.substring(b, p)));
      }
      else {
        pages = 0;
      }

      //Retrieve Spine Height
      String spine = entry.getString("300c");
      int s = spine.indexOf("cm");
      float spineHeight;
      if (s != -1) spineHeight = float(trim(spine.substring(0, s)));
      else spineHeight = 0;

      //Retrieve Location of Publication
      String location = entry.getString("260a");

      //Make a new Record Object Containing All of This Information
      records.add(new Record(title, publisher, language, format, date, pages, spineHeight, location));

      //LOOK FOR MARC SPECIFIC FIELDS------------------------------------------------------------------

      //Retrieve Governing Source
      String marc9060 = entry.getString("9060");

      //Retrieve Associated Date Range
      String marc600d = entry.getString("600d");

      //Retrieve Geographic Subject Name
      String marc651a = entry.getString("651a");

      //Retrieve General Subject Subdivision
      String marc651x = entry.getString("651x");

      //Retrieve Accession Date
      String marc988a = entry.getString("988a");

      //Retrieve List of Agencies That Have Modified This Record
      String[] marc040d = entry.getString("040d");

      marcRecords.add(new MARCRecord(marc9060, marc600d, marc651a, marc651x, marc988a, marc040d));
    }
  }
  catch(JSONException e) {
    println("There was an error parsing the JSONObject.");
  }
  println("Records : " + records.size());
}

class Record {
  String title, publisher, language;
  String[] format;
  int date;
  //MARC primary fields
  int pages;
  float spine;
  String location;

  Record(String t, String p, String l, String[] f, int d, int pgs, float spn, String loc) {
    title = t;
    publisher = p;
    language = l;
    format = f;
    date = d;
    pages = pgs;
    spine = spn;
    location = loc;
  }
}


//Class collecting primitive MARC21 fields of interest beyond the DPLA fields
//See Item API Documentation or MARC21 Guide for more information on these fields
class MARCRecord {
  //General Info Code, Governing Source, Associated Date Range, Geographic Subject Name, General Subject Subdivision, Accession Date Code
  String marc9060, marc600d, marc651a, marc651x, marc988a;
  //List of Agencies That Have Modified This Record
  String[] marc040d;

  MARCRecord(String m9060, String 600d, String m651a, String m651x, int m988a, String[] m040d) {
    marc9060 = m9060;
    marc600d = m600d;
    marc651a = m651a;
    marc651x = m651x;
    marc988a = m988a;
    marc040d = m040d;
  }
}

