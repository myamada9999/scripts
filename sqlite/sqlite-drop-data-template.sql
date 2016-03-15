create table tmptable(id, value);
.separator :
.import INPUT tmptable
.output OUTPUT
select id, AGGREGATE_FUNCTION(value) from tmptable group by id/COUNT;
