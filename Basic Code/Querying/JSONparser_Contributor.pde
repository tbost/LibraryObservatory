import org.json.*;

void JSONparser() {
  try {
    for (int j = 0; j < data.length; j++) {
      JSONObject Data1 = new JSONObject(data[j]);
      JSONArray results = Data1.getJSONArray("docs");

      for (int i = 0; i < results.length(); i++) {
        JSONObject entry = results.getJSONObject(i);

        //BASIC INFO
        String name = entry.getString("dpla.name");
        JSONArray webAdd = entry.getJSONArray("dpla.url");
        String url = webAdd.getString(0);
        String street = entry.getString("dpla.location.address.street");
        String city = entry.getString("dpla.location.address.city");
        int zip = entry.getInt("dpla.location.address.zip");
        int phone = int(entry.getString("PHONE"));
        int localeCode = entry.getInt("LOCALE");
        int geoCode = int(entry.getString("GEOCODE"));    
        float lat = float(entry.getString("dpla.location.geocoords.lat"));
        float lon = float(entry.getString("dpla.location.geocoords.lon"));

        //POPULATION SERVED
        int popCounty = entry.getInt("CNTYPOP");
        int popLSA = entry.getInt("POPU_LSA");

        //STAFF
        float staffTotal = float(entry.getString("TOTSTAFF"));
        float staffMaster = float(entry.getString("MASTER"));
        float staffLibs = float(entry.getString("LIBRARIA"));
        float staffOther = float(entry.getString("OTHPAID"));

        //OPERATING INCOME
        int incomeLocal = entry.getInt("LOCGVT");
        int incomeState = entry.getInt("STGVT");
        int incomeFed = entry.getInt("FEDGVT");
        int incomeOther = entry.getInt("OTHINCM");
        int incomeTotal = entry.getInt("TOTINCM");

        //STAFF EXPENSES
        int expenseStaffSalaries = entry.getInt("SALARIES");
        int expenseStaffBenefits = entry.getInt("BENEFIT");
        int expenseStaffTotal = entry.getInt("STAFFEXP");

        //MATERIAL EXPENSES
        int expensePrint = entry.getInt("PRMATEXP");
        int expenseElectro = entry.getInt("ELMATEXP");
        int expenseOther = entry.getInt("OTHMATEX");
        int expenseTotal = entry.getInt("TOTEXPCO");

        //CAPITAL INCOME/EXPENSES
        int capitalLocal = entry.getInt("LCAP_REV");
        int capitalState = entry.getInt("SCAP_REV");
        int capitalFed = entry.getInt("FCAP_REV");
        int capitalOther = entry.getInt("OCAP_REV");
        int capitalTotal = entry.getInt("CAP_REV");
        int capitalExpend = entry.getInt("CAPITAL");

        //COLLECTIONS
        int volPrint = entry.getInt("BKVOL");
        int volDigital = entry.getInt("EBOOK");
        int volAudio = entry.getInt("AUDIO");
        int volVideo = entry.getInt("VIDEO");
        int volDatabase = entry.getInt("DATABASE");
        int volSubscribePrint = entry.getInt("SUBSCRIP");
        int volSubscribeElectro = entry.getInt("ESUBSCRP");

        //OPERATIONS
        int hours = entry.getInt("HRS_OPEN");
        int visits = entry.getInt("VISITS");
        int borrowers = entry.getInt("REGBOR");

        //CIRCULATION
        int circRef = entry.getInt("REFERENC");
        int circTotal = entry.getInt("TOTCIR");
        int circKids = entry.getInt("KIDCIRCL");
        int circLoanTo = entry.getInt("LOANTO");
        int circLoanFrom = entry.getInt("LOANFM");

        //PROGRAMS
        int progTotal = entry.getInt("TOTPRO");
        int progAttendAdults = entry.getInt("TOTATTEN");
        int progAttendKids = entry.getInt("KIDATTEN");

        //INTERNET
        int intComp = entry.getInt("GPTERMS");
        int intUsers = entry.getInt("PITUSR");

        libraries.add(new Library(name, url, street, city, zip, phone, localeCode, geoCode, lat, lon, popCounty, popLSA, staffTotal, staffMaster, staffLibs, staffOther, incomeLocal, incomeState, incomeFed, incomeOther, incomeTotal, expenseStaffSalaries, expenseStaffBenefits, expenseStaffTotal, expensePrint, expenseElectro, expenseOther, expenseTotal, capitalLocal, capitalState, capitalFed, capitalOther, capitalTotal, capitalExpend, volPrint, volDigital, volAudio, volVideo, volDatabase, volSubscribePrint, volSubscribeElectro, hours, visits, borrowers, circRef, circTotal, circKids, circLoanTo, circLoanFrom, progTotal, progAttendAdults, progAttendKids, intComp, intUsers));
      }
    }
  } 
  catch(JSONException e) {
    println("There was a problem parsing the JSONObject.");
  }
}

