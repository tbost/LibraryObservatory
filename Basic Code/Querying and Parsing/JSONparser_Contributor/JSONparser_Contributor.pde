/*********************************************
 This function parses the JSON responses from the
 Contributor API.  The responses are fed to the 
 function as Strings and an array lists is created,
 holding all of the data fields for each IMLS library
 This array list and the fields of each library
 can then be easily called when needed else where
 in a sketch.
 *********************************************/

import org.json.*;
ArrayList libraries = new ArrayList();

void JSONparser(String response) {
  try {
    JSONObject Data1 = new JSONObject(response);
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
  catch(JSONException e) {
    println("There was a problem parsing the JSONObject.");
  }
}


class Library {
  //BASIC INFO
  String name, url, street, city;
  int zip, phone, localeCode, geoCode;
  float lat, lon;
  float[][] metaData = new float[10][0];

  Library(String n, String u, String st, String c, int z, int ph, int lC, int gC, float la, float lo, int pC, int pLSA, float sT, float sM, float sL, float sO, int iL, int iS, int iFe, int iO, int iT, int eSS, int eSB, int eST, int eP, int eE, int eO, int eT, int caL, int caS, int caF, int caO, int caT, int caE, int vP, int vDi, int vA, int vV, int vDa, int vSP, int vSE, int h, int v, int b, int ciR, int ciT, int ciK, int ciLT, int ciLF, int pT, int pAA, int pAK, int iC, int iU) {
    name = n;
    url = u;
    street = st;
    city = c;
    zip = z;
    phone = ph;
    localeCode = lC;
    geoCode = gC;
    lat = la;
    lon = lo;
    float[] pop = {
      float(pC), float(pLSA)
    };
    float[] staff = {
      sT, sM, sL, sO
    };
    float[] income = {
      float(iT), float(iFe), float(iS), float(iL), float(iO)
    };
    float[] expense = {
      float(eST), float(eSS), float(eSB), float(eT), float(eP), float(eE), float(eO)
    };
    float[] capital = {
      float(caT), float(caF), float(caS), float(caL), float(caO), float(caE)
    };
    float[] collections = {
      float(vP), float(vDi), float(vA), float(vV), float(vDa), float(vSP), float(vSE)
    };
    float[] operations = {
      float(h), float(v), float(b)
    };
    float[] circulation = {
      float(ciT), float(ciR), float(ciK), float(ciLT), float(ciLF)
    };
    float[] programs = {
      float(pT), float(pAA), float(pAK)
    };
    float[] internet = {
      float(iC), float(iU)
    };

    //metaData = {pop, staff, income, expense, capital, collections, operations, circulation, programs, internet};
    metaData[0] = pop;
    metaData[1] = staff;
    metaData[2] = income;
    metaData[3] = expense;
    metaData[4] = capital;
    metaData[5] = collections;
    metaData[6] = operations;
    metaData[7] = circulation;
    metaData[8] = programs;
    metaData[9] = internet;
  }
}
