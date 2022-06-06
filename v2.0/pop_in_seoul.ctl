load data
infile 'pop_in_seoul_wo_comma.csv'
into table POP_IN_SEOUL2
fields terminated by "," optionally enclosed by '"'
(자치구, 한국인남성, 한국인여성, 외국인남성, 외국인여성, 고령자 terminated by whitespace)