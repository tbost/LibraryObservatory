DESCRIPTION
These sketches analyze the patterns emergent in Harvard's collecting patterns as evidenced by the information embedded in its catalog accessions data.  In the current system, data is available only for the last ten years (1 July 2002 - 30 March 2012).  The data is analyzed in one of two ways:

1) AccessionsDynamic
An interactive applet is created in which the user can explore the patterns of accessions on a given day by faceting different attributes, distinguished by color

2) AccessionsStatic
A single image is produced that overlays those same patterns by publishing format or language for every day of the ten year period, a total of over 4.5 million records.

In both versions, the format is the same.  Two timelines runs parallel at top and bottom; the bottom, from 1 July 2002 to 30 March 2012 represents individual dates on which items where accessed, the total being expressed in the vertical blue line, and the top represents years of publications dates of those items.  Bezier curves are drawn between the two linking the date an item was accessed into the system and the year in which it was published.  This curve is then shaded to correspond with the field being visualized, format, language, subject etc.


PROCESS
First, for each version of the sketch, a script must be run that counts all the items for a given year, since the API does not currently allow for date faceting.  This will be helpful later for selecting the correct records.  The output of this sketch must be put into the data folder of both the dynamic and static sketches.

The dynamic sketch can be run from there, but the static sketch requires first that all of the data (~4.5 million records) be collected for use locally.  This is ideally performed with the MARC dataset locally, but may also be performed via the API.  This data will serve as the basis for the static sketch.  Secondly, the static sketch requires that it be run on smaller interval of the full dataset - preferrably year by year - the image output of each of these year analyses can then be overlaid to create the final accessions map.

Note: Records published during the last ten years (the same years for which accession date is provided) have been intentionally excluded as they dominate the dataset and overwhelm much of the historical informaiton.


TO DO
- Add explanation text on initial loading
- Allow toggling between different faceting after having download data for the given date
- Make Facet Legend somehow representative of total items in each facet
- Allow pan-able timeline