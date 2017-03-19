CREATE INDEX idx_d_year ON  dim_date(d_Year);
CREATE INDEX idx_d_yearmonthnum ON  dim_date(d_YearMonthNum);
CREATE INDEX idx_d_yearmonth ON  dim_date(d_YearMonth);
CREATE INDEX idx_d_year_d_weeknuminyear ON dim_date(D_Year, D_WeekNumInYear);

CREATE INDEX idx_s_nation ON supplier(S_Nation);
CREATE INDEX idx_s_region ON supplier(S_Region);

CREATE INDEX idx_c_nation ON customer(C_Nation);

