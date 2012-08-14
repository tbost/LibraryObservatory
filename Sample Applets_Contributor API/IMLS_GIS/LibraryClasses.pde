ArrayList libraries = new ArrayList();

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

  void draw(int fillColor, float rad) {
    Location locTemp = new Location(lat, lon);
    Point2f pointTemp = map.locationPoint(locTemp);
    int pointX = int(pointTemp.x);
    int pointY = int(pointTemp.y);

    fill(fillColor);
    noStroke();
    ellipse(pointX, pointY, rad, rad);
  }
}

