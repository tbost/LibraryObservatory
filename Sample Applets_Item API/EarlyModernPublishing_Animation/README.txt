DESCRIPTION
An animation is created that displays chronologically, the early modern
collection of the Harvard Library in Europe.  It is therefore implied
that there is a close correlation between this collection and the development
of early movable type.  However it is equally important to notice the
geographic preferences of the library in this period, and the large quantity
of non-Western items also being collected by the library from this
period that are not mapped.


PROCESS
First an script is run that collects all records from the Item API
from the year 1400 thru the year 1699.  An exhaustive query is used
such that all records for the given year are returned even if they
number beyond the 500 record return limit.  These then parsed with
the JSONparser script with the field for Year, Title, Publisher,
Language, Location, Page Count, and Spine Height exported to a column-separated
text file. 

The file is problematic as the names for place of publication
are found in several languages (often Latin, English, and whatever language
the item is printed in) and there is often issue with non-standard
English letters such that they are replaced by a string of symbols.
These problems were corrected repeatedly as they arose by a Find/Replace All
function in the text file until the vast majority of places had all
been converted to English.

To locate them a list of major European cities was collected from
Wikipedia, then batch geo-located using the Google Geolocater API.
This list was also added to as place came up in the main dataset that
were not included on the Wikipedia list.

Finally, a separate processing sketch was written to the faceting by
year of the dataset in order to regulate the delay in the final sketch
so that years with only 3 records would display over the same time period
as years with over 1000 records, so that an accurate sense of time is portrayed.


TO DO
- Plot Asian countries on static element at bottom right, floating on top of map
- Make Cities into clickable objects to reveal publication count
- Differentiate production by language on toggled layers
