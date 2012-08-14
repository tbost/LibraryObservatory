ArrayList records = new ArrayList();

void JSONparser() {
  records.clear();
  println("Record List Total : " + responseList.length);
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
        String format = entry.getString("dpla.format");

        //Retrieve Item Author/Creator List
        JSONArray creatorArray = entry.getJSONArray("dpla.creator");
        String[] creators =  new String[0];
        if (creatorArray != null) {
          creators = new String[creatorArray.length()];
          for (int k = 0; k < creatorArray.length(); k++) {
            creators[k] = creatorArray.getString(k);
          }
        }

        //Retrieve Item Description
        JSONArray descArray = entry.getJSONArray("dpla.description");
        String[] description = new String[0];
        if (descArray != null) {
          description = new String[descArray.length()];
          for (int k = 0; k < descArray.length(); k++) {
            description[k] = descArray.getString(k);
          }
        }

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
        
        //Retrieve Location of Publication
        String location = entry.getString("260a");

        records.add(new Record(title, publisher, language, format, creators, description, subject, date, location));
      }
    }
  }
  catch(JSONException e) {
    println("There was an error parsing the JSONObject.");
  }
  println("Records : " + records.size());
  if(records.size() < total) exit();
}

class Record {
  String title, publisher, language, format;
  String[] creators, description, subject;
  int date;
  //MARC primary fields
  String location;

  Record(String t, String p, String l, String f, String[] crs, String[] desc, String[] sbj, int d, String loc) {
    title = t;
    publisher = p;
    language = l;
    format = f;
    creators = crs;
    description = desc;
    subject = sbj;
    date = d;
    location = loc;
  }
}
