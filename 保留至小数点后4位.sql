--需求：仅数字，保留至小数点后4位，否则为空


with x as (
select 'dfgd@#$@' num 	union all
select ''  				union all
select 'sadfasdf'  		union all
select null  			union all
select '123456' 		union all
select '123456.0' 		union all
select '123456.1'		union all
select '123456.11' 		union all
select '123456.111' 	union all
select '123456.1111' 	union all
select '123456.11111' 	union all
select '123456.111111')
select 
	case
		when regexp_replace(num,'[^0-9.]','') = '' or REGEXP_REPLACE(num,'[0-9.]','') <> '' or num is null  then null
		when num rlike '\\.' then rpad(substr(num,1,instr(num,'.')+4),instr(num,'.')+4,'0')
		when num not rlike '\\.' then concat(num,'.0000')
	end num
from x




with x as (
select 'dfgd@#$@' rear_right_brake_pad 	union all
select ''  				union all
select 'sadfasdf'  		union all
select null  			union all
select '123456' 		union all
select '123456.0' 		union all
select '123456.1'		union all
select '123456.11' 		union all
select '123456.111' 	union all
select '123456.1111' 	union all
select '123456.11111' 	union all
select '123456.111111')
case when length(regexp_extract(rear_right_brake_pad,'^([0-9]{1,}[.][0-9]*)$'))>0 then regexp_extract(rear_right_brake_pad||'0000','([0-9]*.[0-9][0-9][0-9][0-9])',1)
  when length(regexp_extract(rear_right_brake_pad,'(^[0-9]+$)'))>0 then regexp_extract(rear_right_brake_pad||'.0000','([0-9]*.[0-9][0-9][0-9][0-9])',1)
  else null end as rear_right_brake_pad
from x



to_char(wip_create_date,'||concat('''','YYYYMMDD','''')||')||'||concat('''','S','''')||'||wipno
