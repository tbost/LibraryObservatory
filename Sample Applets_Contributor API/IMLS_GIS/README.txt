DESCRIPTION
This map is design an overview of the Contributor API dataset from which can be
built more sophisticated trajectories of investigation from the trends that begin
to appear on this map.  The interface is a simple GIS-like map with a bar of buttons
on the bottom with 'drop-up' menus for each of the possible fields associated with
the 9,300 public libraries.  The data of a single field can be displayed by itself
or as normalized by another field.

It is necessary to specify which field to draw a map from by select it in the 'drop-up'
menus.  By default the 'subject' toggle is selected meaning whichever menu button
you select will be the subject of the map; however, by clicking on 'normalize by'
and then selecting another field, the map will draw the subject's values normalized
by the second field.  'Subject' and 'Normalize By' can be toggled between to draw
new maps.  At the top right there is a slider that allows adjustment of the deviation
of values from their arithmetic mean.  This is used to adjust how finely the data
is being presented on the color range, and to control of outlyers in the fields.
Smaller values here will show more fine grain differences, larger ones will show
the sever high and low nodes.


PROCESS
All datafields for all of the 9,300 libraries was batch downloaded from a separate
script and is provided for this applet in its original JSON format.  This allows for
a rather nimble applet during interaction, but a fairly slow initial load time.
First all JSON data is parsed and stored into 'library' objects, their fields being
easily called at will.  Using the 'lat' and 'lon' fields, each library is plotted
on the map using the 'Modest Maps' library and Microsoft Aerial Provider.  Each time
the field toggles are changed, the applet calculates only once the minimum, maximum,
and mean of the data being loaded, with the color mapping being providing while
drawing each point.  This allows the deviation slider to work nimbly.  Currently
all mapping is simple linear gradient mapping, modulated by the deviation slider;
however in the future it may be useful to implement Jenks optimized equal breakdowns
in the color gradient if the aim is towards interface simplification and elimination
of the slider.


REQUIRED RESOURCES
ControlP5 Library
JSON4processing Library
Modest Maps .jar


TO DO
- Button to Remove All Normalizing

- Fix Subject / Normalizing so text does not overlap '/'

- Export PDF/JPEG Button