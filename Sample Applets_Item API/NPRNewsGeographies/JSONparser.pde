import org.json.*;

void JSONparser() {
  try {
    for (int j = 0; j < data.length; j++) {//Cycle through all pages
      JSONObject Data1 = new JSONObject(data[j]);
      JSONArray results = Data1.getJSONArray("docs");

      for (int i = 0; i < results.length(); i++) {//Cycle through all entries
        JSONObject entry = results.getJSONObject(i);

        JSONArray creatorArray = entry.getJSONArray("dpla.description");
        if (creatorArray != null) {
          String desc = creatorArray.getString(0);

          String[] countriesMentioned = new String[0];
          for (int k = 0; k < countries.length; k++) {
            if (match(desc, countries[k]) != null && countries[k].length() > 2) {
              //println((i+1)*j + i);
              //println(countries[k]);

              //Add to the total number of stories for the given countries in the list of countries
              countryCount[k]++;

              //Add to the list of countries mentioned in this story
              countriesMentioned = append(countriesMentioned, str(k));
            }
          }

          if (countriesMentioned.length > 1) {              
            //Create a text string of the codes(index in the array) of the countries to be connected
            String connection = join(countriesMentioned, '-');
            println(connection);

            //Add that string to the list of connections to draw later
            cxnList = append(cxnList, connection);
          }
        }
      }
    }
  } 
  catch(JSONException e) {
    println("There was a problem parsing the JSONObject.");
  }
}

