CREATE INDEX idx_c_nation ON customer(C_Nation);

CREATE INDEX idx_s_region ON supplier(S_Region);
CREATE INDEX idx_s_nation ON supplier(S_Nation);

CREATE INDEX idx_d_year ON dim_date(D_Year);
CREATE INDEX idx_d_yearmonthnum ON dim_date(D_YearMonthNum);
CREATE INDEX idx_d_weeknuminyear_d_year ON dim_date(D_WeekNumInYear,D_Year);

CREATE INDEX idx_lo_revenue ON lineorder(LO_Revenue);
CREATE INDEX idx_lo_discount_lo_quantity ON lineorder(lo_discount, lo_quantity);
CREATE INDEX idx_lo_discount_lo_extendedprice ON lineorder(lo_extendedprice,lo_discount);

