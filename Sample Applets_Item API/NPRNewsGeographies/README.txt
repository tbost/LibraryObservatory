DESCRIPTION
A small part of the contents of the DPLA records at present are 9299 records contributed from NPR.org.  As can be seen in the 'dpla.description' field, these records generally refer to news stories from NPR News and not to any of their special topic shows.  Consequently many of them reference global politics and globally-relevant news stories.  The stories cover a period from the last months of 2001 to 2011.  This visualization attempts to map the emergent geographies of an American perspective of globally-relevant news stories during this period.  Each country is tallied as it appears in the given news stories, however if multiple countries are mentioned in a single news story a link is drawn between the two (or more).

PROCESS
First all records from contributor 'npr_org' were downloaded from the API.  The viz then runs locally from that downloaded data.  A list of countries organized by region was downloaded from a UN website and used to organize and track the country mentions.  Using simple text matching, the records counts were plotted by matching each record against each name on the list.


TO DO / ISSUES
It would be interesting if these countries could be reorganized both automatically (the classic circle network diagram, etc.) and manually by the user.

It would also be useful to represent the countries by an icon, their flag or outline for example.

Try to create a version that can be annotated by users to try to explain the origin of certain connections between countries, e.g. does New Zealand - Poland correlate with Kim Dotcom?

In general time should be addressed on the connections and tallies, at the very least with a time stamp or perhaps correlate with a timeline.

Create a link to something on the web that will attempt to show you the content being referenced by a tally/connection?