ALTER TABLE  customer COLUMN;

ALTER TABLE  part COLUMN;

ALTER TABLE  supplier COLUMN;

ALTER TABLE  dim_date COLUMN;

ALTER TABLE lineorder COLUMN;

/*
DROP TABLE  lineorder;

CREATE COLUMN TABLE  lineorder
(
    LO_OrderKey bigint not null,
    LO_LineNumber tinyint not null,
    LO_CustKey int not null,
    LO_PartKey int not null,
    LO_SuppKey int not null,
    LO_OrderDateKey int not null,
    LO_OrderPriority varchar(15),
    LO_ShipPriority char(1),
    LO_Quantity tinyint,
    LO_ExtendedPrice decimal,
    LO_OrdTotalPrice decimal,
    LO_Discount decimal,
    LO_Revenue decimal,
    LO_SupplyCost decimal,
    LO_Tax tinyint,
    LO_CommitDateKey integer not null,
    LO_ShipMode varchar(10)
);

IMPORT FROM CSV FILE '/usr/sap/HXE/HDB90/work/lineorder.tbl' INTO "SYSTEM"."LINEORDER" 
WITH

record delimited by '\n' 
field delimited by '|';
*/
