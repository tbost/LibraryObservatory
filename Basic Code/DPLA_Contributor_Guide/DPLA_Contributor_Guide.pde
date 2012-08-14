/*
BASE URI
 http://api.dp.la/v0.03/contributor/
 
 BASIC QUERY
 ?filter=
 
 BASE FIELDS
 dpla.keyword	Almost all of a record's fields get copied to this field
 dpla.name	The name of contributor
 dpla.url	The web address of the contributor
 dpla.type	The type of contributor (public library, university library)
 dpla.dataset_id	A unique identifier associated with the data load
 dpla.location.address.street	Contributor's street address
 dpla.location.address.city	Contributor's city
 dpla.location.address.state	Contributor's state
 dpla.location.address.zip	Contributor's postal code
 dpla.location.geocoords.lat	 Geographic latitude of the contributor
 dpla.location.geocoords.lon	Geographic longitude of the contributor
 
 DPLA RECORD FIELDS
 dpla.id 	Each item in DPLA is given a unique identifier.
 dpla.contributor 	The unique name of the partner that supplied the record. These field values usually take the form of the partner's domain name. e.g. example_edu, library_example_org
 dpla.dataset_id 	Each record loaded into DPLA is loaded in a batch. This field is a unique identifier common to all records loaded in the batch.
 
 FACETING & FILTERING
 facet 	The field you want to facet on
 facet_limit_fieldname 	The default facet return set size is 100. You can limit that on a per field basis by using this parameter. (Substitute fieldname for the name of your field)
 filter 	You can narrow queries by using filters. Syntax looks like this: fieldname:filter (example: language:English)
 
 CONTROLS
 limit 	Number of records to return
 start 	The starting point in the result set
 
 EXAMPLES
 http://dev.dp.la/v0.03/contributor/?filter=dpla.keyword:juneau&facet=dpla.type&filter=dpla.location.address.state:AK
 http://api.dp.la/v0.03/contributor/?filter=dpla.keyword:juneau&limit=2&start=5
 */
