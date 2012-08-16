/*
BASE URI
http://api.dp.la/v0.03/item/

BASIC QUERY
?filter=

BASE FIELDS
dpla.keyword 	Almost all of a record's fields get copied to this field
dpla.title 	The title and/or subtitle of the item. Exact matching.
dpla.title_keyword 	The title and/or subtitle of the item. Keyword matching.
dpla.creator 	The creator(s), contributor(s), editor(s), etc. of the item. Exact matching
dpla.creator_keyword 	The creator(s), contributor(s), editor(s), etc. of the item. Keyword matching
dpla.date 	The item's date of publication.
dpla.description 	The item's description. This often includes the item's Table of Contents. Exact matching.
dpla.description_keyword 	The item's description. This often includes the item's Table of Contents. Keyword matching.
dpla.subject 	A catchall for subject information. LCSH, Dewey, and other tag related fields are copied to this field. Exact matching.
dpla.subject_keyword 	A catchall for subject information. LCSH, Dewey, and other tag related fields are copied to this field. Keyword matching.
dpla.publisher 	The name of the publisher. Exact matching.
dpla.language 	The primary language of the item. Exact matching.
dpla.isbn 	The item's ISBN. Exact matching.
dpla.oclc 	The item's OCLC identifier. Exact matching.
dpla.lccn 	The item's LCCN. Exact matching.
dpla.call_num 	The item's call number. Exact matching.
dpla.content_link 	A link to the item's content. Exact matching.
dpla.contributor 	The contributing partner. Exact matching.
dpla.resource_type 	The resource's type. Common values include item and collection. Exact matching.

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
http://api.dp.la/v0.03/item/?filter=dpla.keyword:internet&facet=dpla.subject&filter=dpla.contributor:harvard_edu

http://api.dp.la/v0.03/item/?filter=dpla.keyword:internet&limit=10&start=30
*/
