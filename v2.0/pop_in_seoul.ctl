load data
infile 'pop_in_seoul_wo_comma.csv'
into table POP_IN_SEOUL2
fields terminated by "," optionally enclosed by '"'
(��ġ��, �ѱ��γ���, �ѱ��ο���, �ܱ��γ���, �ܱ��ο���, ����� terminated by whitespace)