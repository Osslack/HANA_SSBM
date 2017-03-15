IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/date.csv' INTO "SYSTEM"."ROW_DIM_DATE" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/date.csv' INTO "SYSTEM"."COL_DIM_DATE" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/customer.csv' INTO "SYSTEM"."COL_CUSTOMER" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/customer.csv' INTO "SYSTEM"."ROW_CUSTOMER" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/lineorder.csv' INTO "SYSTEM"."ROW_LINEORDER" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/lineorder.csv' INTO "SYSTEM"."COL_LINEORDER" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/part.csv' INTO "SYSTEM"."COL_PART" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/part.csv' INTO "SYSTEM"."ROW_PART" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/supplier.csv' INTO "SYSTEM"."ROW_SUPPLIER" 
WITH

record delimited by '\n' 
field delimited by ':';

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/supplier.csv' INTO "SYSTEM"."COL_SUPPLIER" 
WITH

record delimited by '\n' 
field delimited by ':';


