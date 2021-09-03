--email 清洗规则
1. 邮箱包括两个及以上@,只保留1个@.
2. 邮箱包括两个连续..,去掉一个.
3. 邮箱中如果@之前是.,去掉.
4. 邮箱@之后是.,去掉.
5. 邮箱以.开始,去掉.
6. 邮箱以.结尾,去掉结尾的.
7. 邮箱包括异常字符：$,%,^，空格，？，中文字符等,去掉异常字符
8. 邮箱以.comcn结尾,将.comcn替换为.com.cn
9. 执行以上步骤之后，如果邮箱不包括1个@和至少1个.,置为空
10. 执行以上步骤之后，如果邮箱@之后不包括至少1个.,置为空
11. 执行以上步骤之后，如果邮箱最后一个.之后字母数小于2,置为空

--思路
--前8个规则可以理解为是平行规则，需要同时满足，后3个是前8个规则清洗后再进行判断
--我这边嵌套了2个SQL子查询（用于平行清洗），最外层的SQL用于判断后面3个规则（其实也可以只套一个子查询，但是太痛苦了）

--主要用到的函数
--正则判断
--regexp_replace
--substr
--instr
--length


--脚本
select
	email,
	case 
		when length(REGEXP_REPLACE(email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(email_address,instr(email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(email_address),1,instr(reverse(email_address),'.')-1))<2 then null
		when email_address rlike '\\.comcn$' then REGEXP_REPLACE(email_address,'\\.comcn$','.com.cn') 
		else email_address
	end email_address
from (
select 
	email,
	case
        when email_address rlike '^\\..*\\.$' then regexp_replace(substr(email_address,2,length(email_address)-2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '^\\.' then regexp_replace(substr(email_address,2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '\\.$' then regexp_replace(substr(email_address,1,length(email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(email_address,'[^A-Za-z0-9-.@_]','') 
    end email_address 
from (
select 
	email,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(email,1,instr(email,'@')),REGEXP_REPLACE(substr(email,instr(email,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') email_address
    --以上这个脚本主要集合以下3个条件，直接复合起来，否则如果同时满足这些异常情况的话会比较麻烦
	--when email rlike '@.*@' then concat(substr(email,1,instr(email,'@')),REGEXP_REPLACE(substr(email,instr(email,'@')+1),'@',''))
	--when email rlike '[.]{2,}' then REGEXP_REPLACE(email,'[.]{2,}','.')
	--when email rlike '[@.]|[.@]' then REGEXP_REPLACE(email,"(@\\.)|(\\.@)",'@')
from 
	(select '2402944486@qq@.com.' email union all
	select '.stevejoey@163..com' union all
	select 'stevejoey.@163..com' union all
	select '.stevejoey@.163..com' union all
	select 'stevejoey@163..com.' union all
	select '.stev%#@$@#$&e_joey@163..com' union all
	select '.stevejoey@163.comcn' union all
	select '.stev@ejoey.@@.163..comcn.' union all
	select '94834194$448%^%6@.com' union all
	select '94831394%!#$4486.@qq.c'
	)x
)y
)z;