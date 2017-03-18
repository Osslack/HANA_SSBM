IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/date.tbl' INTO "SYSTEM"."DIM_DATE" 
WITH

record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/customer.tbl' INTO "SYSTEM"."CUSTOMER" 
WITH

record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/lineorder.tbl' INTO "SYSTEM"."LINEORDER" 
WITH

batch 10000
record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/part.tbl' INTO "SYSTEM"."PART" 
WITH

record delimited by '\n' 
field delimited by '|';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/supplier.tbl' INTO "SYSTEM"."SUPPLIER" 
WITH

record delimited by '\n' 
field delimited by '|';


