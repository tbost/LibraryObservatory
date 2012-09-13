DESCRIPTION
From a subject keyword query, this simple sketch makes visual the proportional quantities of faceting the results of that query in four different modes: subject, format, language, and publisher.  The sketch currently limits to the top 100 facets, by total quantity.  Each vertical bar is scale to the proportion of items with that attribute versus total items returned and color filled randomly.  Mouse over to see name, total records, and percentage represented.

PROCESS
This sketch makes use of the ControlP5 library for its text field GUI components.  All facets are requested on API query but then only one is displayed at a time based on the button toggles at left.

TO DO
Possibly create slider to adjust number of facets to allow