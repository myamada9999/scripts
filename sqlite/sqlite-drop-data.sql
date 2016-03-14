create table tmptable(id, value);
.separator :
.import input.txt newtable
.output output.txt
select id, max(value) from tmptable group by id/3;
