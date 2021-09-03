--DWD Phase3 清洗

--dwc.dwc_dim_com_dmo2_t_company_t 清洗规则
select 
	dealership_id,
	dealer_group_id,
	dealer_id,
	spark_dealer_id,
	dealer_type,
	dealer_name,
	dealer_name_en,
	dealer_short_name,
	dealer_short_name_en,
	dealer_status,
	province_id,
	city_id,
	district_id,
	dealer_address,
	dealer_address_en,
	postcode,
	latitude,
	longitude,
	phone_number,
	fax_number,
	case 
		when length(REGEXP_REPLACE(new_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_email_address,instr(new_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_email_address),1,instr(reverse(new_email_address),'.')-1))<2 then null
		when new_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_email_address,'\\.comcn$','.com.cn') 
		else new_email_address
	end email_address,
	dealer_home_page,
	open_date,
	close_date,
	used_car,
	remark,
	former_dealer,
	transform_dealer,
	dealer_property,
	create_date,
	modify_date,
	modify_user_id,
	ckd_no,
	afs_phone_number,
	cic_company,
	cic_id,
	cic_key,
	enterprise_code,
	distribution_partner_number,
	bmw_outlet_number,
	dealer_kind,
	fday
from (
select 
	a.*,
	case
        when email_address rlike '^\\..*\\.$' then regexp_replace(substr(email_address,2,length(email_address)-2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '^\\.' then regexp_replace(substr(email_address,2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '\\.$' then regexp_replace(substr(email_address,1,length(email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(email_address,'[^A-Za-z0-9-.@_]','') 
    end new_email_address
from (
select 
	id	dealership_id,
	company_group_id	dealer_group_id,
	case when trim(company_code) rlike '^\\d{4,5}$' then trim(company_code) end dealer_id,
	dms_code	spark_dealer_id,
	company_type	dealer_type,
	company_name_zh	dealer_name,
	company_name_en	dealer_name_en,
	company_short_name_zh	dealer_short_name,
	company_short_name_en	dealer_short_name_en,
	company_status	dealer_status,
	province_id	province_id,
	city_id	city_id,
	county_id	district_id,
	company_address_zh	dealer_address,
	company_address_en	dealer_address_en,
	zip_code	postcode,
	case when trim(latitude) between 0 and 90 then trim(latitude) end latitude,
	case when trim(longitude) between 0 and 180 then trim(longitude) end longitude,
	case 
		when regexp_replace(phone,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phone,'[^-0-9]',''),instr(regexp_replace(phone,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(phone,'[^0-9]','')
		when regexp_replace(phone,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phone,'[^-0-9]',''),instr(regexp_replace(phone,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone,"[^+0-9]","")
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone,"[^+0-9]",""))
		when regexp_replace(phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone,"[^+0-9]",""),2))
		when regexp_replace(phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone,"[^+0-9]",""),2)
		when length(regexp_replace(phone,"[^0-9]",""))>20 or length(regexp_replace(phone,"[^0-9]",""))<7 then null
		else regexp_replace(phone,'[^0-9]','')
	end phone_number,
	case 
		when regexp_replace(fax,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(fax,'[^-0-9]',''),instr(regexp_replace(fax,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(fax,'[^0-9]','')
		when regexp_replace(fax,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(fax,'[^-0-9]',''),instr(regexp_replace(fax,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(fax,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(fax,"[^+0-9]",""),'+','')
		WHEN regexp_replace(fax,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(fax,"[^+0-9]","")
		WHEN regexp_replace(fax,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(fax,"[^+0-9]",""))
		when regexp_replace(fax,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(fax,"[^+0-9]",""),2))
		when regexp_replace(fax,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(fax,"[^+0-9]",""),2)
		when length(regexp_replace(fax,"[^0-9]",""))>20 or length(regexp_replace(fax,"[^0-9]",""))<7 then null
		else regexp_replace(fax,'[^0-9]','')
	end fax_number,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(email,1,instr(email,'@')),REGEXP_REPLACE(substr(email,instr(email,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') email_address,
	company_home_page	dealer_home_page,
	case when open_date>='1949-01-01' and open_Date<CURRENT_TIMESTAMP() then open_date end open_date,
	case when close_date>='1949-01-01' and close_date<CURRENT_TIMESTAMP() then close_date end close_date,
	case when trim(is_used_car) in ('0','1') then trim(is_used_car) end used_car,
	remark	remark,
	former_company	former_dealer,
	transform_company	transform_dealer,
	company_property	dealer_property,
	case when create_date>='1949-01-01' and create_date<CURRENT_TIMESTAMP() then create_date end create_date,
	case 
		when create_date is not null and modify_date>=create_date and modify_date>='1949-01-01' and modify_date<CURRENT_TIMESTAMP() then modify_date
		when create_date is null and modify_date>='1949-01-01' and modify_date<CURRENT_TIMESTAMP() then modify_date 
	end modify_date,
	modify_user_id	modify_user_id,
	ckd_no	ckd_no,
	case 
		when regexp_replace(afs_phone,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(afs_phone,'[^-0-9]',''),instr(regexp_replace(afs_phone,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(afs_phone,'[^0-9]','')
		when regexp_replace(afs_phone,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(afs_phone,'[^-0-9]',''),instr(regexp_replace(afs_phone,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(afs_phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(afs_phone,"[^+0-9]",""),'+','')
		WHEN regexp_replace(afs_phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(afs_phone,"[^+0-9]","")
		WHEN regexp_replace(afs_phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(afs_phone,"[^+0-9]",""))
		when regexp_replace(afs_phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(afs_phone,"[^+0-9]",""),2))
		when regexp_replace(afs_phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(afs_phone,"[^+0-9]",""),2)
		when length(regexp_replace(afs_phone,"[^0-9]",""))>20 or length(regexp_replace(afs_phone,"[^0-9]",""))<7 then null
		else regexp_replace(afs_phone,'[^0-9]','')
	end afs_phone_number,
	cic_company	cic_company,
	cic_id	cic_id,
	cic_key	cic_key,
	enterprise_code	enterprise_code,
	distribution_partner_number	distribution_partner_number,
	bmw_outlet_number	bmw_outlet_number,
	company_kind	dealer_kind,
	day	fday
from source_dmo_v2.dmo2__user__t_company)a)b;



--dwc.dwc_dim_cus_cop_address_t 清洗规则
select  count(*) from (
select 
	a.address_guid	address_guid,
	a.cid	cop_id,
	case 
		when upper(trim(a.country)) rlike	"AD|安道尔"	then "AD"
		when upper(trim(a.country)) rlike	"AE|阿联酋"	then "AE"
		when upper(trim(a.country)) rlike	"AF|阿富汗"	then "AF"
		when upper(trim(a.country)) rlike	"AG|安提瓜和巴布达"	then "AG"
		when upper(trim(a.country)) rlike	"AI|安圭拉"	then "AI"
		when upper(trim(a.country)) rlike	"AL|阿尔巴尼亚"	then "AL"
		when upper(trim(a.country)) rlike	"AM|亚美尼亚"	then "AM"
		when upper(trim(a.country)) rlike	"AN|荷属安的列斯群岛"	then "AN"
		when upper(trim(a.country)) rlike	"AO|安哥拉"	then "AO"
		when upper(trim(a.country)) rlike	"AQ|南极"	then "AQ"
		when upper(trim(a.country)) rlike	"AR|阿根廷"	then "AR"
		when upper(trim(a.country)) rlike	"AS|美属萨摩亚"	then "AS"
		when upper(trim(a.country)) rlike	"AT|奥地利"	then "AT"
		when upper(trim(a.country)) rlike	"AU|澳大利亚"	then "AU"
		when upper(trim(a.country)) rlike	"AW|阿鲁巴"	then "AW"
		when upper(trim(a.country)) rlike	"CL|智利"	then "CL"
		when upper(trim(a.country)) rlike	"CM|喀麦隆"	then "CM"
		when upper(trim(a.country)) rlike	"CN|中国"	then "CN"
		when upper(trim(a.country)) rlike	"CO|哥伦比亚"	then "CO"
		when upper(trim(a.country)) rlike	"CR|哥斯达黎加"	then "CR"
		when upper(trim(a.country)) rlike	"CS|塞尔维亚和黑山"	then "CS"
		when upper(trim(a.country)) rlike	"CU|古巴"	then "CU"
		when upper(trim(a.country)) rlike	"CV|库拉索"	then "CV"
		when upper(trim(a.country)) rlike	"CX|圣诞岛"	then "CX"
		when upper(trim(a.country)) rlike	"CY|塞浦路斯"	then "CY"
		when upper(trim(a.country)) rlike	"CZ|捷克"	then "CZ"
		when upper(trim(a.country)) rlike	"DE|德国"	then "DE"
		when upper(trim(a.country)) rlike	"DJ|吉布提"	then "DJ"
		when upper(trim(a.country)) rlike	"DK|丹麦"	then "DK"
		when upper(trim(a.country)) rlike	"DM|多米尼克"	then "DM"
		when upper(trim(a.country)) rlike	"DO|多米尼加"	then "DO"
		when upper(trim(a.country)) rlike	"DZ|阿尔及利亚"	then "DZ"
		when upper(trim(a.country)) rlike	"EC|厄瓜多尔"	then "EC"
		when upper(trim(a.country)) rlike	"EE|爱沙尼亚"	then "EE"
		when upper(trim(a.country)) rlike	"EG|埃及"	then "EG"
		when upper(trim(a.country)) rlike	"EH|阿拉伯撒哈拉民主共和国"	then "EH"
		when upper(trim(a.country)) rlike	"ER|厄立特里亚"	then "ER"
		when upper(trim(a.country)) rlike	"ES|西班牙"	then "ES"
		when upper(trim(a.country)) rlike	"ET|埃塞俄比亚"	then "ET"
		when upper(trim(a.country)) rlike	"EU|欧盟"	then "EU"
		when upper(trim(a.country)) rlike	"FI|芬兰"	then "FI"
		when upper(trim(a.country)) rlike	"FJ|斐济"	then "FJ"
		when upper(trim(a.country)) rlike	"FK|马尔维纳斯群岛"	then "FK"
		when upper(trim(a.country)) rlike	"FM|密克罗尼西亚联邦"	then "FM"
		when upper(trim(a.country)) rlike	"FO|法罗群岛"	then "FO"
		when upper(trim(a.country)) rlike	"FR|法国"	then "FR"
		when upper(trim(a.country)) rlike	"GA|加蓬"	then "GA"
		when upper(trim(a.country)) rlike	"GB|英国"	then "GB"
		when upper(trim(a.country)) rlike	"GD|格林纳达"	then "GD"
		when upper(trim(a.country)) rlike	"GE|格鲁吉亚"	then "GE"
		when upper(trim(a.country)) rlike	"GF|法属圭亚那"	then "GF"
		when upper(trim(a.country)) rlike	"GH|加纳"	then "GH"
		when upper(trim(a.country)) rlike	"GI|直布罗陀"	then "GI"
		when upper(trim(a.country)) rlike	"GL|格陵兰"	then "GL"
		when upper(trim(a.country)) rlike	"GM|冈比亚"	then "GM"
		when upper(trim(a.country)) rlike	"GN|几内亚"	then "GN"
		when upper(trim(a.country)) rlike	"GP|瓜德罗普"	then "GP"
		when upper(trim(a.country)) rlike	"GQ|赤道几内亚"	then "GQ"
		when upper(trim(a.country)) rlike	"GR|希腊"	then "GR"
		when upper(trim(a.country)) rlike	"GS|南乔治亚和南桑威奇群岛"	then "GS"
		when upper(trim(a.country)) rlike	"GT|危地马拉"	then "GT"
		when upper(trim(a.country)) rlike	"GU|Guam"	then "GU"
		when upper(trim(a.country)) rlike	"GW|几内亚比绍"	then "GW"
		when upper(trim(a.country)) rlike	"GY|圭亚那"	then "GY"
		when upper(trim(a.country)) rlike	"HK|香港"	then "HK"
		when upper(trim(a.country)) rlike	"HM|赫德岛和麦克唐纳群岛"	then "HM"
		when upper(trim(a.country)) rlike	"HN|洪都拉斯"	then "HN"
		when upper(trim(a.country)) rlike	"HR|克罗地亚"	then "HR"
		when upper(trim(a.country)) rlike	"HT|海地"	then "HT"
		when upper(trim(a.country)) rlike	"HU|匈牙利"	then "HU"
		when upper(trim(a.country)) rlike	"ID|印度尼西亚"	then "ID"
		when upper(trim(a.country)) rlike	"IE|爱尔兰"	then "IE"
		when upper(trim(a.country)) rlike	"IL|以色列"	then "IL"
		when upper(trim(a.country)) rlike	"IN|印度"	then "IN"
		when upper(trim(a.country)) rlike	"IO|英属印度洋领地"	then "IO"
		when upper(trim(a.country)) rlike	"IQ|伊拉克"	then "IQ"
		when upper(trim(a.country)) rlike	"IR|伊朗"	then "IR"
		when upper(trim(a.country)) rlike	"IS|冰岛"	then "IS"
		when upper(trim(a.country)) rlike	"IT|意大利"	then "IT"
		when upper(trim(a.country)) rlike	"JM|牙买加"	then "JM"
		when upper(trim(a.country)) rlike	"JO|约旦"	then "JO"
		when upper(trim(a.country)) rlike	"JP|日本"	then "JP"
		when upper(trim(a.country)) rlike	"KE|肯尼亚"	then "KE"
		when upper(trim(a.country)) rlike	"KG|吉尔吉斯斯坦"	then "KG"
		when upper(trim(a.country)) rlike	"KH|柬埔寨"	then "KH"
		when upper(trim(a.country)) rlike	"KI|基里巴斯"	then "KI"
		when upper(trim(a.country)) rlike	"KM|科摩罗"	then "KM"
		when upper(trim(a.country)) rlike	"KN|圣基茨和尼维斯"	then "KN"
		when upper(trim(a.country)) rlike	"KP|朝鲜"	then "KP"
		when upper(trim(a.country)) rlike	"KR|韩国"	then "KR"
		when upper(trim(a.country)) rlike	"KW|科威特"	then "KW"
		when upper(trim(a.country)) rlike	"KY|开曼群岛"	then "KY"
		when upper(trim(a.country)) rlike	"KZ|哈萨克斯坦"	then "KZ"
		when upper(trim(a.country)) rlike	"LA|老挝"	then "LA"
		when upper(trim(a.country)) rlike	"LB|黎巴嫩"	then "LB"
		when upper(trim(a.country)) rlike	"LC|St. Lucia"	then "LC"
		when upper(trim(a.country)) rlike	"LI|列支敦士登"	then "LI"
		when upper(trim(a.country)) rlike	"LK|斯里兰卡"	then "LK"
		when upper(trim(a.country)) rlike	"LR|利比里亚"	then "LR"
		when upper(trim(a.country)) rlike	"LS|莱索托"	then "LS"
		when upper(trim(a.country)) rlike	"LT|立陶宛"	then "LT"
		when upper(trim(a.country)) rlike	"LU|卢森堡"	then "LU"
		when upper(trim(a.country)) rlike	"LV|拉脱维亚"	then "LV"
		when upper(trim(a.country)) rlike	"LY|利比亚"	then "LY"
		when upper(trim(a.country)) rlike	"MA|摩洛哥"	then "MA"
		when upper(trim(a.country)) rlike	"MC|摩纳哥"	then "MC"
		when upper(trim(a.country)) rlike	"MD|摩尔多瓦"	then "MD"
		when upper(trim(a.country)) rlike	"ME|蒙特内哥罗"	then "ME"
		when upper(trim(a.country)) rlike	"MG|马达加斯加"	then "MG"
		when upper(trim(a.country)) rlike	"MH|马绍尔群岛"	then "MH"
		when upper(trim(a.country)) rlike	"MK|马其顿"	then "MK"
		when upper(trim(a.country)) rlike	"ML|马里"	then "ML"
		when upper(trim(a.country)) rlike	"MM|缅甸"	then "MM"
		when upper(trim(a.country)) rlike	"MN|蒙古国"	then "MN"
		when upper(trim(a.country)) rlike	"MO|澳门"	then "MO"
		when upper(trim(a.country)) rlike	"MP|北马里亚纳群岛"	then "MP"
		when upper(trim(a.country)) rlike	"MQ|马提尼克"	then "MQ"
		when upper(trim(a.country)) rlike	"MR|毛里塔尼亚"	then "MR"
		when upper(trim(a.country)) rlike	"MS|蒙特塞拉特"	then "MS"
		when upper(trim(a.country)) rlike	"MT|马耳他"	then "MT"
		when upper(trim(a.country)) rlike	"MU|毛里求斯"	then "MU"
		when upper(trim(a.country)) rlike	"MV|马尔代夫"	then "MV"
		when upper(trim(a.country)) rlike	"MW|Malawi"	then "MW"
		when upper(trim(a.country)) rlike	"MX|墨西哥"	then "MX"
		when upper(trim(a.country)) rlike	"MY|马来西亚"	then "MY"
		when upper(trim(a.country)) rlike	"MZ|莫桑比克"	then "MZ"
		when upper(trim(a.country)) rlike	"NA|纳米比亚"	then "NA"
		when upper(trim(a.country)) rlike	"NC|新喀里多尼亚"	then "NC"
		when upper(trim(a.country)) rlike	"NE|尼日尔"	then "NE"
		when upper(trim(a.country)) rlike	"NF|诺福克岛"	then "NF"
		when upper(trim(a.country)) rlike	"NG|尼日利亚"	then "NG"
		when upper(trim(a.country)) rlike	"NI|尼加拉瓜"	then "NI"
		when upper(trim(a.country)) rlike	"NL|荷兰"	then "NL"
		when upper(trim(a.country)) rlike	"NO|挪威"	then "NO"
		when upper(trim(a.country)) rlike	"NP|尼泊尔"	then "NP"
		when upper(trim(a.country)) rlike	"NR|瑙鲁"	then "NR"
		when upper(trim(a.country)) rlike	"NT|北约"	then "NT"
		when upper(trim(a.country)) rlike	"NU|纽埃"	then "NU"
		when upper(trim(a.country)) rlike	"NZ|新西兰"	then "NZ"
		when upper(trim(a.country)) rlike	"OM|阿曼"	then "OM"
		when upper(trim(a.country)) rlike	"OR|Orange"	then "OR"
		when upper(trim(a.country)) rlike	"PA|巴拿马"	then "PA"
		when upper(trim(a.country)) rlike	"PE|秘鲁"	then "PE"
		when upper(trim(a.country)) rlike	"PF|法属波利尼西亚"	then "PF"
		when upper(trim(a.country)) rlike	"PG|巴布亚新几内亚"	then "PG"
		when upper(trim(a.country)) rlike	"PH|菲律宾"	then "PH"
		when upper(trim(a.country)) rlike	"PK|巴基斯坦"	then "PK"
		when upper(trim(a.country)) rlike	"PL|波兰"	then "PL"
		when upper(trim(a.country)) rlike	"PM|圣皮埃尔和密克隆"	then "PM"
		when upper(trim(a.country)) rlike	"PN|皮特凯恩群岛"	then "PN"
		when upper(trim(a.country)) rlike	"PR|波多黎各"	then "PR"
		when upper(trim(a.country)) rlike	"PS|巴勒斯坦"	then "PS"
		when upper(trim(a.country)) rlike	"PT|葡萄牙"	then "PT"
		when upper(trim(a.country)) rlike	"PW|帕劳"	then "PW"
		when upper(trim(a.country)) rlike	"PY|巴拉圭"	then "PY"
		when upper(trim(a.country)) rlike	"QA|卡塔尔"	then "QA"
		when upper(trim(a.country)) rlike	"RE|留尼汪"	then "RE"
		when upper(trim(a.country)) rlike	"RO|罗马尼亚"	then "RO"
		when upper(trim(a.country)) rlike	"RS|塞尔维亚"	then "RS"
		when upper(trim(a.country)) rlike	"RU|俄罗斯"	then "RU"
		when upper(trim(a.country)) rlike	"RW|卢旺达"	then "RW"
		when upper(trim(a.country)) rlike	"SA|沙特阿拉伯"	then "SA"
		when upper(trim(a.country)) rlike	"SB|所罗门群岛"	then "SB"
		when upper(trim(a.country)) rlike	"SC|塞舌尔"	then "SC"
		when upper(trim(a.country)) rlike	"SD|苏丹"	then "SD"
		when upper(trim(a.country)) rlike	"SE|瑞典"	then "SE"
		when upper(trim(a.country)) rlike	"SG|新加坡"	then "SG"
		when upper(trim(a.country)) rlike	"SH|圣赫勒拿"	then "SH"
		when upper(trim(a.country)) rlike	"SI|斯洛文尼亚"	then "SI"
		when upper(trim(a.country)) rlike	"SJ|Svalbard"	then "SJ"
		when upper(trim(a.country)) rlike	"SK|斯洛伐克"	then "SK"
		when upper(trim(a.country)) rlike	"SL|塞拉利昂"	then "SL"
		when upper(trim(a.country)) rlike	"SM|圣马力诺"	then "SM"
		when upper(trim(a.country)) rlike	"SN|塞内加尔"	then "SN"
		when upper(trim(a.country)) rlike	"SO|索马里"	then "SO"
		when upper(trim(a.country)) rlike	"SR|苏里南"	then "SR"
		when upper(trim(a.country)) rlike	"ST|圣多美和普林西比"	then "ST"
		when upper(trim(a.country)) rlike	"SV|萨尔瓦多"	then "SV"
		when upper(trim(a.country)) rlike	"SY|叙利亚"	then "SY"
		when upper(trim(a.country)) rlike	"SZ|斯威士兰"	then "SZ"
		when upper(trim(a.country)) rlike	"TC|特克斯和凯科斯群岛"	then "TC"
		when upper(trim(a.country)) rlike	"TD|乍得"	then "TD"
		when upper(trim(a.country)) rlike	"TF|法属南部领地"	then "TF"
		when upper(trim(a.country)) rlike	"TG|多哥"	then "TG"
		when upper(trim(a.country)) rlike	"TH|泰国"	then "TH"
		when upper(trim(a.country)) rlike	"TJ|塔吉克斯坦"	then "TJ"
		when upper(trim(a.country)) rlike	"TK|托克劳"	then "TK"
		when upper(trim(a.country)) rlike	"TL|东帝汶"	then "TL"
		when upper(trim(a.country)) rlike	"TM|土库曼斯坦"	then "TM"
		when upper(trim(a.country)) rlike	"TN|突尼西亚"	then "TN"
		when upper(trim(a.country)) rlike	"TO|汤加"	then "TO"
		when upper(trim(a.country)) rlike	"TR|土耳其"	then "TR"
		when upper(trim(a.country)) rlike	"TT|特立尼达及托巴哥"	then "TT"
		when upper(trim(a.country)) rlike	"TV|图瓦卢"	then "TV"
		when upper(trim(a.country)) rlike	"TW|台湾"	then "TW"
		when upper(trim(a.country)) rlike	"TZ|坦桑尼亚"	then "TZ"
		when upper(trim(a.country)) rlike	"UA|乌克兰"	then "UA"
		when upper(trim(a.country)) rlike	"UG|乌干达"	then "UG"
		when upper(trim(a.country)) rlike	"UM|美国本土外小岛屿"	then "UM"
		when upper(trim(a.country)) rlike	"UN|联合国"	then "UN"
		when upper(trim(a.country)) rlike	"US|美国"	then "US"
		when upper(trim(a.country)) rlike	"UY|乌拉圭"	then "UY"
		when upper(trim(a.country)) rlike	"UZ|乌兹别克斯坦"	then "UZ"
		when upper(trim(a.country)) rlike	"VA|梵蒂冈"	then "VA"
		when upper(trim(a.country)) rlike	"VC|圣文森及格瑞那丁"	then "VC"
		when upper(trim(a.country)) rlike	"VE|委内瑞拉"	then "VE"
		when upper(trim(a.country)) rlike	"VG|英属维京群岛"	then "VG"
		when upper(trim(a.country)) rlike	"VI|美属维京群岛"	then "VI"
		when upper(trim(a.country)) rlike	"VN|越南"	then "VN"
		when upper(trim(a.country)) rlike	"VU|瓦努阿图"	then "VU"
		when upper(trim(a.country)) rlike	"WF|瓦利斯和富图纳"	then "WF"
		when upper(trim(a.country)) rlike	"WS|萨摩亚"	then "WS"
		when upper(trim(a.country)) rlike	"YE|也门"	then "YE"
		when upper(trim(a.country)) rlike	"YT|马约特"	then "YT"
		when upper(trim(a.country)) rlike	"ZA|南非"	then "ZA"
		when upper(trim(a.country)) rlike	"ZM|赞比亚"	then "ZM"
		when upper(trim(a.country)) rlike	"ZW|津巴布韦"	then "ZW"
		when upper(trim(a.country)) rlike	"BS|巴哈马"	then "BS"
		when upper(trim(a.country)) rlike	"BT|不丹"	then "BT"
		when upper(trim(a.country)) rlike	"BV|布韦岛"	then "BV"
		when upper(trim(a.country)) rlike	"BW|博茨瓦纳"	then "BW"
		when upper(trim(a.country)) rlike	"BY|白俄罗斯"	then "BY"
		when upper(trim(a.country)) rlike	"BZ|伯利兹"	then "BZ"
		when upper(trim(a.country)) rlike	"CA|加拿大"	then "CA"
		when upper(trim(a.country)) rlike	"CC|科科斯（基林）群岛"	then "CC"
		when upper(trim(a.country)) rlike	"CD|刚果（金）"	then "CD"
		when upper(trim(a.country)) rlike	"CF|中非共和国"	then "CF"
		when upper(trim(a.country)) rlike	"CG|刚果（布）"	then "CG"
		when upper(trim(a.country)) rlike	"CH|瑞士"	then "CH"
		when upper(trim(a.country)) rlike	"CI|科特迪瓦"	then "CI"
		when upper(trim(a.country)) rlike	"CK|库克群岛"	then "CK"
		when upper(trim(a.country)) rlike	"AX|奥兰"	then "AX"
		when upper(trim(a.country)) rlike	"AZ|阿塞拜疆"	then "AZ"
		when upper(trim(a.country)) rlike	"BA|波斯尼亚和黑塞哥维那"	then "BA"
		when upper(trim(a.country)) rlike	"BB|巴巴多斯"	then "BB"
		when upper(trim(a.country)) rlike	"BD|孟加拉国国"	then "BD"
		when upper(trim(a.country)) rlike	"BE|比利时"	then "BE"
		when upper(trim(a.country)) rlike	"BF|布基纳法索"	then "BF"
		when upper(trim(a.country)) rlike	"BG|保加利亚"	then "BG"
		when upper(trim(a.country)) rlike	"BH|巴林"	then "BH"
		when upper(trim(a.country)) rlike	"BI|布隆迪"	then "BI"
		when upper(trim(a.country)) rlike	"BJ|贝宁"	then "BJ"
		when upper(trim(a.country)) rlike	"BL|圣巴泰勒米"	then "BL"
		when upper(trim(a.country)) rlike	"BM|百慕大"	then "BM"
		when upper(trim(a.country)) rlike	"BN|文莱"	then "BN"
		when upper(trim(a.country)) rlike	"BO|玻利维亚"	then "BO"
		when upper(trim(a.country)) rlike	"BR|巴西"	then "BR"
	end as country,
	case
		when b.province is not null then b.province
		when b.province is null and c.province is not null then c.province
	end province,
	case 
		when b.city is not null then b.city
		when b.city is null and e.new_city is not null then e.new_city
		when b.city is null and REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")='' then null
		when a.city is null or trim(a.city) =''then null
		else REGEXP_REPLACE(a.city,'[^\u4e00-\u9fa5]','')
	end city,
	street	street,
	postal_code	postcode,
	address_status	address_status,
	preferred	preferred,
	case when is_delete in ('1','0') then is_delete end deleted,
	case when create_time >'1949-01-01' and create_time <CURRENT_TIMESTAMP() then create_time end create_date,	
	case 
		when create_time is not null and update_time>=create_time and update_time>='1949-01-01' and update_time<CURRENT_TIMESTAMP() then update_time
		when create_time is null and update_time>='1949-01-01' and update_time<CURRENT_TIMESTAMP() then update_time
	end modify_date,
	day	fday
from source_cop.cop__cop_db__address a
left join (select distinct province,city from raw.raw_upload_province_city_district_map_t where city is not null )b
on REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")=regexp_replace(b.city,"新区|区|市|自治州|地区","")
and REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and a.city is not null
and b.province not in ('北京市','上海市','重庆市')
and a.city not in ('朝阳区')
left join (select distinct province from raw.raw_upload_province_city_district_map_t where city is not null )c
on REGEXP_REPLACE(a.region_code,"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")=regexp_replace(c.province,"省|市|自治区|特别行政区","")
and REGEXP_REPLACE(a.region_code,"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")<>''
and a.region_code is not null
left join (select '塘沽' old_city,'滨海新区' new_city union all	select '崇文' old_city,'东城区' new_city union all	select '宣武' old_city,'西城区' new_city union all	select '巢湖' old_city,'合肥市' new_city union all	select '永康' old_city,'金华市' new_city union all	select '三河' old_city,'廊坊市' new_city union all	select '江阴' old_city,'无锡市' new_city union all	select '莱芜' old_city,'济南市' new_city union all	select '闸北' old_city,'静安区' new_city union all	select '任丘' old_city,'沧州市' new_city union all	select '慈溪' old_city,'宁波市' new_city union all	select '襄樊' old_city,'襄阳市' new_city union all	select '大港' old_city,'滨海新区' new_city union all	select '迁安' old_city,'唐山市' new_city union all	select '思茅' old_city,'普洱市' new_city union all	select '静海县' old_city,'静海区' new_city union all	select '晋州' old_city,'石家庄市' new_city union all	select '密云县' old_city,'密云区' new_city union all	select '莱芜' old_city,'济南市' new_city union all	select '卢湾' old_city,'黄浦区' new_city union all	select '余姚' old_city,'宁波市' new_city union all	select '蓟县' old_city,'蓟州区' new_city union all	select '太仓' old_city,'苏州市' new_city union all	select '崇明县' old_city,'崇明区' new_city union all	select '开县' old_city,'开州区' new_city union all	select '汉沽' old_city,'滨海新区' new_city union all	select '大足县' old_city,'大足区' new_city union all	select '思茅' old_city,'普洱市' new_city union all	select '璧山县' old_city,'璧山区' new_city)e
on REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|市|区","")=e.old_city
and REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and a.city is not null
)x
;


--dwc.dwc_dim_cus_cop_email_t 清洗规则
select 
	cons_guid,
	cop_id,
	communication_status,
	case 
		when length(REGEXP_REPLACE(new_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_email_address,instr(new_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_email_address),1,instr(reverse(new_email_address),'.')-1))<2 then null
		when new_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_email_address,'\\.comcn$','.com.cn') 
		else new_email_address
	end email_address,
	communication_type,
	deleted,
	create_date,
	modify_date,
	fday
from(
select 
	a.*,
	case
        when email_address rlike '^\\..*\\.$' then regexp_replace(substr(email_address,2,length(email_address)-2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '^\\.' then regexp_replace(substr(email_address,2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '\\.$' then regexp_replace(substr(email_address,1,length(email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(email_address,'[^A-Za-z0-9-.@_]','') 
    end new_email_address
from (
select 
	cons_guid	cons_guid,
	cid	cop_id,
	communication_status	communication_status,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(value,1,instr(value,'@')),REGEXP_REPLACE(substr(value,instr(value,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') email_address,
	communication_type	communication_type,
	case when trim(is_delete) in ('0','1') then trim(is_delete) end	deleted,
	case when create_time>'1949-01-01' and create_time<CURRENT_TIMESTAMP() then create_time end create_date,
	case 
		when create_time is not null and update_time>=create_time and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
		when create_time is null and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
	end modify_date,
	day	fday
from source_cop.cop__cop_db__email)a)b;


--dwc.dwc_dim_cus_cop_policy_history_t 清洗规则
select 
	id	id,
	cid	cop_id,
	config_policy_id	config_policy_id,
	policy_id	policy_id,
	bc_id	channel_sources_id,
	major_version	major_version,
	minor_version	minor_version,
	case when create_time>'1949-01-01' and create_time<CURRENT_TIMESTAMP() then create_time end create_date,
	case 
		when create_time is not null and update_time>=create_time and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
		when create_time is null and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
	end modify_date,
	day	fday
from source_cop.cop__cop_db__policy_history;



--dwc.dwc_dim_cus_cop_sys_user_t 清洗规则
select 
	cop_id,
	--old_mobile_phone_number,
	mobile_phone_number,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else last_name_1 end last_name,
	gender,
	state,
	create_date,
	modify_date,
	--old_first_name,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else first_name_1 end first_name,
	gcid,
	ucid,
	wechat_head_img_url,
	wechat_nick_name,
	--old_birth_date,
	birth_date,
	base_head_img_url,
	fday,
	channel_sources
from(
select 
	a.*,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(first_name,last_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(first_name as string),2)	else first_name end first_name_1,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(last_name,first_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(last_name as string),1,1) when  first_name is null then last_name end last_name_1
from(
select 
	cid	cop_id,
	mobile old_mobile_phone_number,
	case	
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(mobile,"[^+0-9]",""),'+','')
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(mobile,"[^+0-9]","")
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(mobile,"[^+0-9]",""))
		when regexp_replace(mobile,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(mobile,"[^+0-9]",""),2))
		when regexp_replace(mobile,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(mobile,"[^+0-9]",""),2)
	end mobile_phone_number,
	sur_name old_last_name,
	REGEXP_REPLACE(sur_name,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") last_name,
	case 
		when gender ='Company' then 'U'
		when gender in ('0','else') then 'U'
		when gender in ('1','先生','M 先生','M','MR.','M.','Male') then 'M'
		when gender in ('2','女士','F 女士','F 小姐','MS','Ms','MS.','Ms.','Female') then 'F'
		when gender is null or gender='' then null
		else 'U'
	end gender,
	case when state in ('1','2') then state end	state,
	case when create_time>'1949-01-01' and create_time<CURRENT_TIMESTAMP() then create_time end create_date,
	case 
		when create_time is not null and update_time>=create_time and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
		when create_time is null and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
	end modify_date,
	given_name old_first_name,
	REGEXP_REPLACE(given_name,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	first_name,
	gcid	gcid,
	ucid	ucid,
	wx_head_img_url	wechat_head_img_url,
	wx_nick_name	wechat_nick_name,
	birth old_birth_date,
	case 
		when concat(substr(birth,1,4),'-',substr(birth,5,2),'-',substr(birth,7,2)) < '1900-01-01' then null 
		when concat(substr(birth,1,4),'-',substr(birth,5,2),'-',substr(birth,7,2)) > create_time or birth is null or birth='' then substr(trim(gcid),7,8)
		else concat(substr(birth,1,4),'-',substr(birth,5,2),'-',substr(birth,7,2),' 00:00:00')
	end	birth_date,
	base_head_img_url	base_head_img_url,
	day	fday,
	lp_from	channel_sources
from source_cop.cop__cop_db__sys_user)a)b;


--dwc.dwc_dim_cus_cop_user_login_history_t 清洗规则
select 
	jobid	job_id,
	reqid	req_id,
	case when from_unixtime(cast(starttime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(starttime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() then from_unixtime(cast(starttime/1000 as bigint),'yyyy-MM-dd HH:mm:ss') end start_time,
	case when from_unixtime(cast(endtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(endtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() then from_unixtime(cast(endtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss') end end_time,
	dataid	data_id,
	copid	cop_id,
	case when from_unixtime(unix_timestamp(logintime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(unix_timestamp(logintime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() then from_unixtime(unix_timestamp(logintime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') end login_date,
	appname	app_name,
	case	
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(mobile,"[^+0-9]",""),'+','')
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(mobile,"[^+0-9]","")
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(mobile,"[^+0-9]",""))
		when regexp_replace(mobile,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(mobile,"[^+0-9]",""),2))
		when regexp_replace(mobile,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(mobile,"[^+0-9]",""),2)
	end mobile_phone_number,
	deviceid	device_id,
	devicename	device_name,
	devicetype	device_type,
	param	param,
	phour	hours,
	pday	fday
from source_cop.cop__cop_db__user_login_history;


	
--dwc.dwc_dim_cus_cop_wx_bind_t 清洗规则
select 
	union_id	union_id,
	cid	cop_id,
	--mobile	old_mobile_phone_number,
	case	
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(mobile,"[^+0-9]",""),'+','')
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(mobile,"[^+0-9]","")
		WHEN regexp_replace(mobile,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(mobile,"[^+0-9]",""))
		when regexp_replace(mobile,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(mobile,"[^+0-9]",""),2))
		when regexp_replace(mobile,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(mobile,"[^+0-9]",""),2)
	end mobile_phone_number,
	state	state,
	case when create_time>'1949-01-01' and create_time<CURRENT_TIMESTAMP() then create_time end create_date,
	case 
		when create_time is not null and update_time>=create_time and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
		when create_time is null and update_time>'1949-01-01' and update_time<CURRENT_TIMESTAMP() then create_time
	end modify_date,
	day	fday
from source_cop.cop__cop_db__wx_bind;
	
	
	
--dwc.dwc_dim_com_omc_user_info_t 清洗规则
select
	receiveid	receive_id,
	case when from_unixtime(cast(receivetime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(receivetime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() then from_unixtime(cast(receivetime/1000 as bigint),'yyyy-MM-dd HH:mm:ss') end receive_time,
	case when from_unixtime(cast(logtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(logtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() then from_unixtime(cast(logtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss') end login_time,
	reqid	req_id,
	case	
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone,"[^+0-9]","")
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone,"[^+0-9]",""))
		when regexp_replace(phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone,"[^+0-9]",""),2))
		when regexp_replace(phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone,"[^+0-9]",""),2)
	end mobile_phone_number,
	usid	usid,
	accountgcid	account_gcid,
	case when from_unixtime(unix_timestamp(updatetime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(unix_timestamp(updatetime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() then from_unixtime(unix_timestamp(updatetime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') end modify_date,
	case when from_unixtime(cast(sendtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(sendtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() then from_unixtime(cast(sendtime/1000 as bigint),'yyyy-MM-dd HH:mm:ss') end send_time,
	cdmid	cdm_id,
	cdmstatus	cdm_status,
	msgstatus	msg_status,
	phour	phour,
	pday	pday
from cdp_drs.omc_user_info;

	
--dwc.dwc_dim_com_omc_cvr_t 清洗规则
select 
	receiveid	receive_id,
	case when from_unixtime(cast(receivetime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(receivetime/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() then from_unixtime(cast(receivetime/1000 as bigint),'yyyy-MM-dd HH:mm:ss') end receive_time,
 	reqid	req_id,
	case	
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone,"[^+0-9]","")
		WHEN regexp_replace(phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone,"[^+0-9]",""))
		when regexp_replace(phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone,"[^+0-9]",""),2))
		when regexp_replace(phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone,"[^+0-9]",""),2)
	end mobile_phone_number,
	name	full_name,
	--vin old_vin_17,
	case when trim(vin) rlike "^[A-Za-z0-9]{17}$" then trim(vin) end vin_17,
	type	type,
	cdactivestatus	cd_active_status,
	case when from_unixtime(unix_timestamp(lastupdatetime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(unix_timestamp(lastupdatetime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() then from_unixtime(unix_timestamp(lastupdatetime, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') end last_modify_date,
	phour	phour,
	pday	pday
from cdp_drs.omc_cvr;


