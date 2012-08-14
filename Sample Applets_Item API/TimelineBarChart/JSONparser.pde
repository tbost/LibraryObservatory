ArrayList records = new ArrayList();
//ArrayList marcRecords = new ArrayList();

void JSONparser() {
  records.clear();
  try {
    for (int j = 0; j < responseList.length; j++) {
      JSONObject Data1 = new JSONObject(responseList[j]);
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

        //Retrieve Page Count
        String page = entry.getString("300a");
        //Isolate only the number value, cut off notation for pages, and change to int
        //This may also be reworked for 'leaves' or 'images' or whatever metric is used for leaf count
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

        records.add(new Record(title, publisher, language, format, date, pages, spineHeight, location));
      }
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
