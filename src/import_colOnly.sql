IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/date.csv' INTO "SYSTEM"."DIM_DATE" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/customer.csv' INTO "SYSTEM"."CUSTOMER" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/lineorder.csv' INTO "SYSTEM"."LINEORDER" 
WITH

batch 10000
record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/part.csv' INTO "SYSTEM"."PART" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/supplier.csv' INTO "SYSTEM"."SUPPLIER" 
WITH

record delimited by '\n' 
field delimited by ':';


