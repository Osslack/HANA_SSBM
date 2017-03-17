DROP TABLE row_customer;

CREATE ROW TABLE row_customer (
	C_CUSTOMERKEY INTEGER,
	C_Name varchar(25),
	C_Address varchar(25),
	C_City varchar(10),
	C_Nation varchar(15),
	C_Region varchar(12),
	C_Phone varchar(15),
	C_MktSegment varchar(10),
	PRIMARY KEY ("C_CUSTOMERKEY")
);

DROP TABLE row_part;

CREATE ROW TABLE row_part
(
	P_PartKey integer,
	P_Name varchar(25),
	P_MFGR varchar(10),
	P_Category varchar(10),
	P_Brand varchar(15),
	P_Colour varchar(15),
	P_Type varchar(25),
	P_Size tinyint,
	P_Container char(10),
	PRIMARY KEY (P_PartKey)
);

DROP TABLE row_supplier;

CREATE ROW TABLE row_supplier (
	S_SuppKey integer,
	S_Name char(25),
	S_Address varchar(25),
	S_City char(10),
	S_Nation char(15),
	S_Region char(12),
	S_Phone char(15),
	PRIMARY KEY(S_SuppKey)
);

DROP TABLE row_dim_date;

CREATE ROW TABLE row_dim_date
(
	D_DateKey integer,
	D_Date char(18),
	D_DayOfWeek char(9),
	D_Month char(9),
	D_Year smallint,
	D_YearMonthNum integer,
	D_YearMonth char(7),
	D_DayNumInWeek tinyint,
	D_DayNumInMonth tinyint,
	D_DayNumInYear smallint,
	D_MonthNumInYear tinyint,
	D_WeekNumInYear tinyint,
	D_SellingSeason char(12),
	D_LastDayInWeekFl tinyint,
	D_LastDayInMonthFl tinyint,
	D_HolidayFl tinyint,
	D_WeekDayFl tinyint,
	PRIMARY KEY(D_DateKey)
);
DROP TABLE row_lineorder;

CREATE ROW TABLE row_lineorder
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


DROP TABLE col_customer;

CREATE COLUMN TABLE col_customer (
	C_CUSTOMERKEY INTEGER,
	C_Name varchar(25),
	C_Address varchar(25),
	C_City varchar(10),
	C_Nation varchar(15),
	C_Region varchar(12),
	C_Phone varchar(15),
	C_MktSegment varchar(10),
	PRIMARY KEY ("C_CUSTOMERKEY")
);

DROP TABLE col_part;

CREATE COLUMN TABLE col_part
(
	P_PartKey integer,
	P_Name varchar(25),
	P_MFGR varchar(10),
	P_Category varchar(10),
	P_Brand varchar(15),
	P_Colour varchar(15),
	P_Type varchar(25),
	P_Size tinyint,
	P_Container char(10),
	PRIMARY KEY (P_PartKey)
);

DROP TABLE col_supplier;

CREATE COLUMN TABLE col_supplier (
	S_SuppKey integer,
	S_Name char(25),
	S_Address varchar(25),
	S_City char(10),
	S_Nation char(15),
	S_Region char(12),
	S_Phone char(15),
	PRIMARY KEY(S_SuppKey)
);

DROP TABLE col_dim_date;

CREATE COLUMN TABLE col_dim_date
(
	D_DateKey integer,
	D_Date char(18),
	D_DayOfWeek char(9),
	D_Month char(9),
	D_Year smallint,
	D_YearMonthNum integer,
	D_YearMonth char(7),
	D_DayNumInWeek tinyint,
	D_DayNumInMonth tinyint,
	D_DayNumInYear smallint,
	D_MonthNumInYear tinyint,
	D_WeekNumInYear tinyint,
	D_SellingSeason char(12),
	D_LastDayInWeekFl tinyint,
	D_LastDayInMonthFl tinyint,
	D_HolidayFl tinyint,
	D_WeekDayFl tinyint,
	PRIMARY KEY(D_DateKey)
);
DROP TABLE col_lineorder;

CREATE COLUMN TABLE col_lineorder
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
