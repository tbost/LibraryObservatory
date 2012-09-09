DESCRIPTION
A small part of the contents of the DPLA records at present are 9299 records contributed from NPR.org.  As can be seen in the 'dpla.description' field, these records generally refer to news stories from NPR News and not to any of their special topic shows.  Consequently many of them reference global politics and globally-relevant news stories.  The stories cover a period from the last months of 2001 to 2011.  This visualization attempts to map the emergent geographies of an American perspective of globally-relevant news stories during this period.  Each country is tallied as it appears in the given news stories, however if multiple countries are mentioned in a single news story a link is drawn between the two (or more).

PROCESS
First all records from contributor 'npr_org' were downloaded from the API.  The viz then runs locally from that downloaded data.  A list of countries organized by region was downloaded from a UN website and used to organize and track the country mentions.  Using simple text matching, the records counts were plotted by matching each record against each name on the list.


TO DO / ISSUES