CREATE INDEX idx_lo_quantity_lo_discount ON lineorder(LO_Quantity, LO_Discount);
CREATE INDEX idx_lo_quantity ON lineorder(LO_Quantity);

CREATE INDEX idx_d_yearmonthnum ON  dim_date(d_YearMonthNum);
CREATE INDEX idx_d_yearmonth ON  dim_date(d_YearMonth);
CREATE INDEX idx_d_year_d_weeknuminyear ON dim_date(D_Year, D_WeekNumInYear);

CREATE INDEX idx_s_nation ON supplier(S_Nation);

CREATE INDEX idx_c_nation ON customer(C_Nation);