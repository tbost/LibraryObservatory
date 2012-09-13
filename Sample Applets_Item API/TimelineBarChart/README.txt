DESCRIPTION
Using the simple timeline example found in the Basic Code folder, this applet makes subject key searches to the Item API and charts the cumulative materiality of Harvard's collections on the subject.  Using the toggles, the results can be viewed by a) cumulative number of items in the given year, b) cumulative pages in the given year, and c) average spine height of items in the given year.


PROCESS
The textbox receives strings and parses them for spaces, replacing them with '%20' for functioning with the web.  Exhaustive querying (in the Basic Code folder) is used to retrieve the specified number of entries.  Rather than storing each of the records retrieved, only the specified fields of item count, page count, and spine height are cumulatively tallied for later display.  Calls to the API are made only once upon hitting 'submit' or pressing enter, not when hitting the toggles at bottom right.


TO DO / ISSUES
As in the basic timeline example code, the timeline does not recenter on zoom.

In order to allow the applet to be more light weight and dynamice, the quantity of items retrieved from the API is limited in the code.  This is necessary because at present the API does not support faceting by date, but it does support faceting by nearly any other feature.  This is a huge issue for the usefulness of this timeline.  Ideally this issue will be corrected in the future and this timeline will be much more useful.

By default, all items returned from the API are sorted by recent checkout date.  Although there is a feature to alter this in the API, it is not currently functioning.  Consequently, the results of almost any search are likely greatly skewed toward the recent past.  This is further inhibited by the API's inability to yet deal with date range searches that might limit the records returned to 1300 through 1400 A.D., for example.

Physical features of items, like page counts and spine heights, can be extremely useful when applied to highly specified subject areas, genres, or time periods, however this type of subject keyword search to define the data is not at all helpful in this way.  It is however useful for demonstrative purposes toward more focused research.