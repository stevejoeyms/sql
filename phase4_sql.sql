-- =========================================================================
-- Filename        : phase4 clean for test
-- Description     : the sql of phase4 clean for test
-- Author          : Joey
-- =========================================================================

--dwc_fact_cus_wechat_subscribe_t clean
select 
	case when cdp_create_time > '1949-01-01' then cdp_create_time end	cdp_create_date,
	open_id	open_id,
	union_id	union_id,
	subscribe_status	subscribe_status,
	case when event_datetime > '1949-01-01' then event_datetime end	event_date,
	case when source_time > '1949-01-01' then source_time end source_time,
	source_channel	source_channel,
	day	fday
from source_wechat.wechat_subscribe;


--dwc_dim_com_cms_article_info_t clean
select
	articleid	article_id,
	copid	cop_id,
	articlename	article_name,
	authortype	author_type,
	articletype	article_type,
	articleformat	article_format,
	case when activitystarttime > '1949-01-01' then activitystarttime end	activity_start_time,
	case when activitystarttime is not null and activityendtime>activitystarttime then activityendtime when activitystarttime is null then activityendtime end activity_end_time,
	articlestatus	article_status,
	case when publishtime > '1949-01-01' then publishtime end publish_time,
	case when pushtime > '1949-01-01' then pushtime end	push_time,
	newtime	new_time
from source_cms.article_info;


--dwc_fact_com_cms_user_action_event_t clean
select
	eventid	event_id,
	articleid	article_id,
	copid	cop_id,
	useraction	user_action,
	case when activityattendtime > '1949-01-01' then activityattendtime end	activity_attend_time,
	case when actiontime > '1949-01-01' then actiontime end	action_time,
	case when pushtime > '1949-01-01' then pushtime end	pushtime,
	newtime	new_time
from source_cms.user_action_event;


--dwc_fact_com_cdstore_order_info_t clean
select
	usid	usid,
	source	source,
	parent_order_no	parent_order_no,
	order_no	order_no,
	total_amount	total_amount,
	case when create_time > '1949-01-01' then create_time end create_date,
	status	status,
	case when event_time > '1949-01-01' then event_time end	event_time,
	event_amount	event_amount,
	receive_id	receive_id,
	part_date	part_date
from source_cdstore.cdstore_order_info;


--dwc_dim_com_cdstore_sku_items_list_t clean
select
	order_no	order_no,
	sku_group_code	sku_group_code,
	sku_group_name_cn	sku_group_name,
	sku_group_name_en	sku_group_name_en,
	sku_id	sku_id,
	sku_name	sku_name,
	sku_price	sku_price,
	receive_id	receive_id
from source_cdstore.cdstore_sku_items_list;


--dwc_dim_com_cdstore_sku_master_t clean
select
	sku_group_code	sku_group_code,
	sku_group_name	sku_group_name,
	sku_id	sku_id,
	sku_code	sku_code,
	sku_name	sku_name,
	sku_price	sku_price,
	case when sku_update_time > '1949-01-01' then sku_update_time end sku_modify_date,
	case when sku_group_update_time > '1949-01-01' then sku_group_update_time end sku_group_modify_date,
	case when create_time > '1949-01-01' then create_time end create_date,
	case when data_update_time > '1949-01-01' then data_update_time end data_modify_date,
	receive_id	receive_id,
	part_date	part_date
from source_cdstore.cdstore_sku_master;


--dwc_dim_cus_gcdm_customer_address_t clean
select
	additionalhouseid	additional_house_id,
	addresschecked	address_checked,
	addressguid	address_guid,
	addressstatus	address_status,
	buildingid	building_id,
	careofname	care_of_name,
	case 
		when b.city is not null then b.city
		when b.city is null and e.new_city is not null then e.new_city
		when b.city is null and REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")='' then null
		when a.city is null or trim(a.city) =''then null
		else REGEXP_REPLACE(a.city,'[^\u4e00-\u9fa5]','')
	end city,
	companydepartment	company_department,
	companyname	company_name,
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
	customextension	custom_extension,
	case when `delete`=true then 1 when `delete`=false then 0 else null end deleted,
	case when delete_flag in(1,0) then delete_flag end deleted1,
	districtname	district_name,
	case when trim(floorid) rlike '^\\d+$' then trim(floorid) end floor_id,
	gcid	gcid,
	housenumber	house_number,
	invoice	invoice,
	location	location,
	case when last_update between '1949-01-01' and CURRENT_TIMESTAMP() then last_update end modify_date,
	postofficebox	post_office_box,
	postalcode	postcode,
	preferred	preferred,
	receiverfirstname	receiver_first_name,
	receiverlastname	receiver_last_name,
	case
		when b.province is not null then b.province
		when b.province is null and c.province is not null then c.province
	end province,
	roomid	room_id,
	shipment	shipment,
	strsuppl1	str_suppl_1,
	strsuppl2	str_suppl_2,
	strsuppl3	str_suppl_3,
	street	street,
	streettype	street_type
from source_gcdm.gcdm_bp_address a
left join (select distinct province,city from raw.raw_upload_province_city_district_map_t where city is not null )b
on REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")=regexp_replace(b.city,"新区|区|市|自治州|地区","")
and REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and a.city is not null
and b.province not in ('北京市','上海市','重庆市')
and a.city not in ('朝阳区')
left join (select distinct province from raw.raw_upload_province_city_district_map_t where city is not null )c
on REGEXP_REPLACE(a.regioncode,"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")=regexp_replace(c.province,"省|市|自治区|特别行政区","")
and REGEXP_REPLACE(a.regioncode,"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")<>''
and a.regioncode is not null
left join (select  '塘沽' old_city,  '滨海新区' new_city union all select  '崇文' old_city,  '东城区' new_city union all select  '宣武' old_city,  '西城区' new_city union all select  '巢湖' old_city,  '合肥市' new_city union all select  '永康' old_city,  '金华市' new_city union all select  '三河' old_city,  '廊坊市' new_city union all select  '江阴' old_city,  '无锡市' new_city union all select  '莱芜' old_city,  '济南市' new_city union all select  '闸北' old_city,  '静安区' new_city union all select  '任丘' old_city,  '沧州市' new_city union all select  '慈溪' old_city,  '宁波市' new_city union all select  '襄樊' old_city,  '襄阳市' new_city union all select  '大港' old_city,  '滨海新区' new_city union all select  '迁安' old_city,  '唐山市' new_city union all select  '思茅' old_city,  '普洱市' new_city union all select  '静海县' old_city,  '静海区' new_city union all select  '晋州' old_city,  '石家庄市' new_city union all select  '密云县' old_city,  '密云区' new_city union all select  '卢湾' old_city,  '黄浦区' new_city union all select  '余姚' old_city,  '宁波市' new_city union all select  '蓟县' old_city,  '蓟州区' new_city union all select  '太仓' old_city,  '苏州市' new_city union all select  '崇明县' old_city,  '崇明区' new_city union all select  '开县' old_city,  '开州区' new_city union all select  '汉沽' old_city,  '滨海新区' new_city union all select  '大足县' old_city,  '大足区' new_city union all select  '璧山县' old_city,  '璧山区' new_city)e
on REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|市|区","")=e.old_city
and REGEXP_REPLACE(a.city,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and a.city is not null;


--dwc_dim_cus_gcdm_customer_communication_t clean
select
	communicationstatus	communication_status,
	communicationtype	communication_type,
	consguid	cons_guid,
	value	value,
	customextension	custom_extension,
	case when `delete`=true then 1 when `delete`=false then 0 else null end deleted,
	case when delete_flag in(1,0) then delete_flag end deleted1,	
	gcid	gcid,
	case when last_update < CURRENT_TIMESTAMP() then last_update end modify_date,
	preferred	preferred
from source_gcdm.gcdm_bp_communication;


--dwc_dim_cus_gcdm_customer_policy_t clean
select
	acceptchannel	accept_channel,
	acceptdate	accept_date,
	acceptmethod	accept_method,
	customextension	custom_extension,
	datausagechannel	data_usage_channel,
	datausagedate	data_usage_date,
	datausagerevoked	data_usage_revoked,
	datausagetype	data_usage_type,
	case when delete_flag in(1,0) then delete_flag end deleted,	
	gcid	gcid,
	majorversion	major_version,
	minorversion	minor_version,
	case when last_update < CURRENT_TIMESTAMP() then last_update end modify_date,
	policyagreementid	policy_agreement_id,
	policyid	policy_id,
	policyversion	policy_version,
	revokechannel	revoke_channel,
	revokedate	revoke_date,
	revokemethod	revoke_method
from source_gcdm.gcdm_bp_policy;


--dwc_dim_cus_gcdm_customer_t clean
select
	additional_academic_title_code,
	additional_last_name,
	additional_name_prefix_code,
	agerange_children,
	agerange_children_date,
	alternative_customer_ids,
	birth_date,
	birth_date_deleted,
	bp_gcid,
	modify_date,
	bp_ucid,
	brand_code,
	businessdata_custom_extension,
	businessdata_organisation_name,
	businessdata_organisation_type,
	businessdata_traderegister_no,
	communications_availability,
	contact_channel_areaspecs,
	correspond_language,
	country,
	custom_extension,
	customer_group,
	customer_status,
	customer_type,
	deleted,
	employee_of,
	ereadiness,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else first_name_1 end first_name,
	gcid,
	gender,
	highest_degree,
	hobby,
	home_market,
	income,
	income_currency,
	initial_contact_deleted,
	initial_contact_owner,
	initial_contact_owner_type,
	initials_name,
	interested,
	interested_communication_channel,
	interested_sales_channel,
	interested_vehicle,
	last_modify_dealer,
	last_modify_source,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else last_name_1 end last_name,
	marital_status,
	market,
	market_customextension,
	mh_action,
	mh_client_id,
	mh_client_variant_id,
	mh_custom_extension,
	mh_gcdm_message_id,
	mh_mdm_context,
	mh_message_id,
	mh_postprocessing_info,
	mh_sender_id,
	mh_timestamp,
	mh_use_case,
	mh_version_number,
	middle_name,
	mobile_phone_number,
	mobile_validated,
	name_prefix_code,
	name_suffix_generation,
	name_supplement_code,
	nick_name,
	number_of_cars_in_household,
	number_of_family_members,
	planned_purchase_date,
	planned_purchase_scheduled,
	profession,
	roles,
	salutation,
	title,
	ua_alias,
	ua_email_validated,
	ua_gcid,
	ua_mail,
	ua_status,
	ucid
from (
select
	a.*,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(first_name,last_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(first_name as string),2)	else first_name end first_name_1,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(last_name,first_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(last_name as string),1,1) when  first_name is null then last_name end last_name_1
from(
select
	bp_additionalacademictitlecode	additional_academic_title_code,
	bp_additionalfamilyname	additional_last_name,
	bp_additionalnameprefixcode	additional_name_prefix_code,
	bp_profile_agerangechildren	agerange_children,
	bp_profile_agerangechildrendate	agerange_children_date,
	bp_alternativecustomerids	alternative_customer_ids,
	case 
		when bp_birthday < '1900-01-01' then null
		else bp_birthday
	end birth_date,
	case when `bp_birthdaydelete`=true then 1 when `bp_birthdaydelete`=false then 0 else null end birth_date_deleted,
	bp_gcid	bp_gcid,
	case when bp_lastupdated_at < CURRENT_TIMESTAMP() then bp_lastupdated_at end modify_date,
	bp_ucid	bp_ucid,
	bp_market_brand	brand_code,
	bp_businessdata_customextension	businessdata_custom_extension,
	bp_businessdata_organisationname	businessdata_organisation_name,
	bp_businessdata_organisationtype	businessdata_organisation_type,
	bp_businessdata_traderegisterno	businessdata_traderegister_no,
	bp_communications_availability	communications_availability,
	bp_contactchannelareaspecs	contact_channel_areaspecs,
	bp_correspondlanguageiso	correspond_language,
	case 
		when upper(trim(bp_nationalityiso)) rlike	"AD|安道尔"	then "AD"
		when upper(trim(bp_nationalityiso)) rlike	"AE|阿联酋"	then "AE"
		when upper(trim(bp_nationalityiso)) rlike	"AF|阿富汗"	then "AF"
		when upper(trim(bp_nationalityiso)) rlike	"AG|安提瓜和巴布达"	then "AG"
		when upper(trim(bp_nationalityiso)) rlike	"AI|安圭拉"	then "AI"
		when upper(trim(bp_nationalityiso)) rlike	"AL|阿尔巴尼亚"	then "AL"
		when upper(trim(bp_nationalityiso)) rlike	"AM|亚美尼亚"	then "AM"
		when upper(trim(bp_nationalityiso)) rlike	"AN|荷属安的列斯群岛"	then "AN"
		when upper(trim(bp_nationalityiso)) rlike	"AO|安哥拉"	then "AO"
		when upper(trim(bp_nationalityiso)) rlike	"AQ|南极"	then "AQ"
		when upper(trim(bp_nationalityiso)) rlike	"AR|阿根廷"	then "AR"
		when upper(trim(bp_nationalityiso)) rlike	"AS|美属萨摩亚"	then "AS"
		when upper(trim(bp_nationalityiso)) rlike	"AT|奥地利"	then "AT"
		when upper(trim(bp_nationalityiso)) rlike	"AU|澳大利亚"	then "AU"
		when upper(trim(bp_nationalityiso)) rlike	"AW|阿鲁巴"	then "AW"
		when upper(trim(bp_nationalityiso)) rlike	"CL|智利"	then "CL"
		when upper(trim(bp_nationalityiso)) rlike	"CM|喀麦隆"	then "CM"
		when upper(trim(bp_nationalityiso)) rlike	"CN|中国"	then "CN"
		when upper(trim(bp_nationalityiso)) rlike	"CO|哥伦比亚"	then "CO"
		when upper(trim(bp_nationalityiso)) rlike	"CR|哥斯达黎加"	then "CR"
		when upper(trim(bp_nationalityiso)) rlike	"CS|塞尔维亚和黑山"	then "CS"
		when upper(trim(bp_nationalityiso)) rlike	"CU|古巴"	then "CU"
		when upper(trim(bp_nationalityiso)) rlike	"CV|库拉索"	then "CV"
		when upper(trim(bp_nationalityiso)) rlike	"CX|圣诞岛"	then "CX"
		when upper(trim(bp_nationalityiso)) rlike	"CY|塞浦路斯"	then "CY"
		when upper(trim(bp_nationalityiso)) rlike	"CZ|捷克"	then "CZ"
		when upper(trim(bp_nationalityiso)) rlike	"DE|德国"	then "DE"
		when upper(trim(bp_nationalityiso)) rlike	"DJ|吉布提"	then "DJ"
		when upper(trim(bp_nationalityiso)) rlike	"DK|丹麦"	then "DK"
		when upper(trim(bp_nationalityiso)) rlike	"DM|多米尼克"	then "DM"
		when upper(trim(bp_nationalityiso)) rlike	"DO|多米尼加"	then "DO"
		when upper(trim(bp_nationalityiso)) rlike	"DZ|阿尔及利亚"	then "DZ"
		when upper(trim(bp_nationalityiso)) rlike	"EC|厄瓜多尔"	then "EC"
		when upper(trim(bp_nationalityiso)) rlike	"EE|爱沙尼亚"	then "EE"
		when upper(trim(bp_nationalityiso)) rlike	"EG|埃及"	then "EG"
		when upper(trim(bp_nationalityiso)) rlike	"EH|阿拉伯撒哈拉民主共和国"	then "EH"
		when upper(trim(bp_nationalityiso)) rlike	"ER|厄立特里亚"	then "ER"
		when upper(trim(bp_nationalityiso)) rlike	"ES|西班牙"	then "ES"
		when upper(trim(bp_nationalityiso)) rlike	"ET|埃塞俄比亚"	then "ET"
		when upper(trim(bp_nationalityiso)) rlike	"EU|欧盟"	then "EU"
		when upper(trim(bp_nationalityiso)) rlike	"FI|芬兰"	then "FI"
		when upper(trim(bp_nationalityiso)) rlike	"FJ|斐济"	then "FJ"
		when upper(trim(bp_nationalityiso)) rlike	"FK|马尔维纳斯群岛"	then "FK"
		when upper(trim(bp_nationalityiso)) rlike	"FM|密克罗尼西亚联邦"	then "FM"
		when upper(trim(bp_nationalityiso)) rlike	"FO|法罗群岛"	then "FO"
		when upper(trim(bp_nationalityiso)) rlike	"FR|法国"	then "FR"
		when upper(trim(bp_nationalityiso)) rlike	"GA|加蓬"	then "GA"
		when upper(trim(bp_nationalityiso)) rlike	"GB|英国"	then "GB"
		when upper(trim(bp_nationalityiso)) rlike	"GD|格林纳达"	then "GD"
		when upper(trim(bp_nationalityiso)) rlike	"GE|格鲁吉亚"	then "GE"
		when upper(trim(bp_nationalityiso)) rlike	"GF|法属圭亚那"	then "GF"
		when upper(trim(bp_nationalityiso)) rlike	"GH|加纳"	then "GH"
		when upper(trim(bp_nationalityiso)) rlike	"GI|直布罗陀"	then "GI"
		when upper(trim(bp_nationalityiso)) rlike	"GL|格陵兰"	then "GL"
		when upper(trim(bp_nationalityiso)) rlike	"GM|冈比亚"	then "GM"
		when upper(trim(bp_nationalityiso)) rlike	"GN|几内亚"	then "GN"
		when upper(trim(bp_nationalityiso)) rlike	"GP|瓜德罗普"	then "GP"
		when upper(trim(bp_nationalityiso)) rlike	"GQ|赤道几内亚"	then "GQ"
		when upper(trim(bp_nationalityiso)) rlike	"GR|希腊"	then "GR"
		when upper(trim(bp_nationalityiso)) rlike	"GS|南乔治亚和南桑威奇群岛"	then "GS"
		when upper(trim(bp_nationalityiso)) rlike	"GT|危地马拉"	then "GT"
		when upper(trim(bp_nationalityiso)) rlike	"GU|Guam"	then "GU"
		when upper(trim(bp_nationalityiso)) rlike	"GW|几内亚比绍"	then "GW"
		when upper(trim(bp_nationalityiso)) rlike	"GY|圭亚那"	then "GY"
		when upper(trim(bp_nationalityiso)) rlike	"HK|香港"	then "HK"
		when upper(trim(bp_nationalityiso)) rlike	"HM|赫德岛和麦克唐纳群岛"	then "HM"
		when upper(trim(bp_nationalityiso)) rlike	"HN|洪都拉斯"	then "HN"
		when upper(trim(bp_nationalityiso)) rlike	"HR|克罗地亚"	then "HR"
		when upper(trim(bp_nationalityiso)) rlike	"HT|海地"	then "HT"
		when upper(trim(bp_nationalityiso)) rlike	"HU|匈牙利"	then "HU"
		when upper(trim(bp_nationalityiso)) rlike	"ID|印度尼西亚"	then "ID"
		when upper(trim(bp_nationalityiso)) rlike	"IE|爱尔兰"	then "IE"
		when upper(trim(bp_nationalityiso)) rlike	"IL|以色列"	then "IL"
		when upper(trim(bp_nationalityiso)) rlike	"IN|印度"	then "IN"
		when upper(trim(bp_nationalityiso)) rlike	"IO|英属印度洋领地"	then "IO"
		when upper(trim(bp_nationalityiso)) rlike	"IQ|伊拉克"	then "IQ"
		when upper(trim(bp_nationalityiso)) rlike	"IR|伊朗"	then "IR"
		when upper(trim(bp_nationalityiso)) rlike	"IS|冰岛"	then "IS"
		when upper(trim(bp_nationalityiso)) rlike	"IT|意大利"	then "IT"
		when upper(trim(bp_nationalityiso)) rlike	"JM|牙买加"	then "JM"
		when upper(trim(bp_nationalityiso)) rlike	"JO|约旦"	then "JO"
		when upper(trim(bp_nationalityiso)) rlike	"JP|日本"	then "JP"
		when upper(trim(bp_nationalityiso)) rlike	"KE|肯尼亚"	then "KE"
		when upper(trim(bp_nationalityiso)) rlike	"KG|吉尔吉斯斯坦"	then "KG"
		when upper(trim(bp_nationalityiso)) rlike	"KH|柬埔寨"	then "KH"
		when upper(trim(bp_nationalityiso)) rlike	"KI|基里巴斯"	then "KI"
		when upper(trim(bp_nationalityiso)) rlike	"KM|科摩罗"	then "KM"
		when upper(trim(bp_nationalityiso)) rlike	"KN|圣基茨和尼维斯"	then "KN"
		when upper(trim(bp_nationalityiso)) rlike	"KP|朝鲜"	then "KP"
		when upper(trim(bp_nationalityiso)) rlike	"KR|韩国"	then "KR"
		when upper(trim(bp_nationalityiso)) rlike	"KW|科威特"	then "KW"
		when upper(trim(bp_nationalityiso)) rlike	"KY|开曼群岛"	then "KY"
		when upper(trim(bp_nationalityiso)) rlike	"KZ|哈萨克斯坦"	then "KZ"
		when upper(trim(bp_nationalityiso)) rlike	"LA|老挝"	then "LA"
		when upper(trim(bp_nationalityiso)) rlike	"LB|黎巴嫩"	then "LB"
		when upper(trim(bp_nationalityiso)) rlike	"LC|St. Lucia"	then "LC"
		when upper(trim(bp_nationalityiso)) rlike	"LI|列支敦士登"	then "LI"
		when upper(trim(bp_nationalityiso)) rlike	"LK|斯里兰卡"	then "LK"
		when upper(trim(bp_nationalityiso)) rlike	"LR|利比里亚"	then "LR"
		when upper(trim(bp_nationalityiso)) rlike	"LS|莱索托"	then "LS"
		when upper(trim(bp_nationalityiso)) rlike	"LT|立陶宛"	then "LT"
		when upper(trim(bp_nationalityiso)) rlike	"LU|卢森堡"	then "LU"
		when upper(trim(bp_nationalityiso)) rlike	"LV|拉脱维亚"	then "LV"
		when upper(trim(bp_nationalityiso)) rlike	"LY|利比亚"	then "LY"
		when upper(trim(bp_nationalityiso)) rlike	"MA|摩洛哥"	then "MA"
		when upper(trim(bp_nationalityiso)) rlike	"MC|摩纳哥"	then "MC"
		when upper(trim(bp_nationalityiso)) rlike	"MD|摩尔多瓦"	then "MD"
		when upper(trim(bp_nationalityiso)) rlike	"ME|蒙特内哥罗"	then "ME"
		when upper(trim(bp_nationalityiso)) rlike	"MG|马达加斯加"	then "MG"
		when upper(trim(bp_nationalityiso)) rlike	"MH|马绍尔群岛"	then "MH"
		when upper(trim(bp_nationalityiso)) rlike	"MK|马其顿"	then "MK"
		when upper(trim(bp_nationalityiso)) rlike	"ML|马里"	then "ML"
		when upper(trim(bp_nationalityiso)) rlike	"MM|缅甸"	then "MM"
		when upper(trim(bp_nationalityiso)) rlike	"MN|蒙古国"	then "MN"
		when upper(trim(bp_nationalityiso)) rlike	"MO|澳门"	then "MO"
		when upper(trim(bp_nationalityiso)) rlike	"MP|北马里亚纳群岛"	then "MP"
		when upper(trim(bp_nationalityiso)) rlike	"MQ|马提尼克"	then "MQ"
		when upper(trim(bp_nationalityiso)) rlike	"MR|毛里塔尼亚"	then "MR"
		when upper(trim(bp_nationalityiso)) rlike	"MS|蒙特塞拉特"	then "MS"
		when upper(trim(bp_nationalityiso)) rlike	"MT|马耳他"	then "MT"
		when upper(trim(bp_nationalityiso)) rlike	"MU|毛里求斯"	then "MU"
		when upper(trim(bp_nationalityiso)) rlike	"MV|马尔代夫"	then "MV"
		when upper(trim(bp_nationalityiso)) rlike	"MW|Malawi"	then "MW"
		when upper(trim(bp_nationalityiso)) rlike	"MX|墨西哥"	then "MX"
		when upper(trim(bp_nationalityiso)) rlike	"MY|马来西亚"	then "MY"
		when upper(trim(bp_nationalityiso)) rlike	"MZ|莫桑比克"	then "MZ"
		when upper(trim(bp_nationalityiso)) rlike	"NA|纳米比亚"	then "NA"
		when upper(trim(bp_nationalityiso)) rlike	"NC|新喀里多尼亚"	then "NC"
		when upper(trim(bp_nationalityiso)) rlike	"NE|尼日尔"	then "NE"
		when upper(trim(bp_nationalityiso)) rlike	"NF|诺福克岛"	then "NF"
		when upper(trim(bp_nationalityiso)) rlike	"NG|尼日利亚"	then "NG"
		when upper(trim(bp_nationalityiso)) rlike	"NI|尼加拉瓜"	then "NI"
		when upper(trim(bp_nationalityiso)) rlike	"NL|荷兰"	then "NL"
		when upper(trim(bp_nationalityiso)) rlike	"NO|挪威"	then "NO"
		when upper(trim(bp_nationalityiso)) rlike	"NP|尼泊尔"	then "NP"
		when upper(trim(bp_nationalityiso)) rlike	"NR|瑙鲁"	then "NR"
		when upper(trim(bp_nationalityiso)) rlike	"NT|北约"	then "NT"
		when upper(trim(bp_nationalityiso)) rlike	"NU|纽埃"	then "NU"
		when upper(trim(bp_nationalityiso)) rlike	"NZ|新西兰"	then "NZ"
		when upper(trim(bp_nationalityiso)) rlike	"OM|阿曼"	then "OM"
		when upper(trim(bp_nationalityiso)) rlike	"OR|Orange"	then "OR"
		when upper(trim(bp_nationalityiso)) rlike	"PA|巴拿马"	then "PA"
		when upper(trim(bp_nationalityiso)) rlike	"PE|秘鲁"	then "PE"
		when upper(trim(bp_nationalityiso)) rlike	"PF|法属波利尼西亚"	then "PF"
		when upper(trim(bp_nationalityiso)) rlike	"PG|巴布亚新几内亚"	then "PG"
		when upper(trim(bp_nationalityiso)) rlike	"PH|菲律宾"	then "PH"
		when upper(trim(bp_nationalityiso)) rlike	"PK|巴基斯坦"	then "PK"
		when upper(trim(bp_nationalityiso)) rlike	"PL|波兰"	then "PL"
		when upper(trim(bp_nationalityiso)) rlike	"PM|圣皮埃尔和密克隆"	then "PM"
		when upper(trim(bp_nationalityiso)) rlike	"PN|皮特凯恩群岛"	then "PN"
		when upper(trim(bp_nationalityiso)) rlike	"PR|波多黎各"	then "PR"
		when upper(trim(bp_nationalityiso)) rlike	"PS|巴勒斯坦"	then "PS"
		when upper(trim(bp_nationalityiso)) rlike	"PT|葡萄牙"	then "PT"
		when upper(trim(bp_nationalityiso)) rlike	"PW|帕劳"	then "PW"
		when upper(trim(bp_nationalityiso)) rlike	"PY|巴拉圭"	then "PY"
		when upper(trim(bp_nationalityiso)) rlike	"QA|卡塔尔"	then "QA"
		when upper(trim(bp_nationalityiso)) rlike	"RE|留尼汪"	then "RE"
		when upper(trim(bp_nationalityiso)) rlike	"RO|罗马尼亚"	then "RO"
		when upper(trim(bp_nationalityiso)) rlike	"RS|塞尔维亚"	then "RS"
		when upper(trim(bp_nationalityiso)) rlike	"RU|俄罗斯"	then "RU"
		when upper(trim(bp_nationalityiso)) rlike	"RW|卢旺达"	then "RW"
		when upper(trim(bp_nationalityiso)) rlike	"SA|沙特阿拉伯"	then "SA"
		when upper(trim(bp_nationalityiso)) rlike	"SB|所罗门群岛"	then "SB"
		when upper(trim(bp_nationalityiso)) rlike	"SC|塞舌尔"	then "SC"
		when upper(trim(bp_nationalityiso)) rlike	"SD|苏丹"	then "SD"
		when upper(trim(bp_nationalityiso)) rlike	"SE|瑞典"	then "SE"
		when upper(trim(bp_nationalityiso)) rlike	"SG|新加坡"	then "SG"
		when upper(trim(bp_nationalityiso)) rlike	"SH|圣赫勒拿"	then "SH"
		when upper(trim(bp_nationalityiso)) rlike	"SI|斯洛文尼亚"	then "SI"
		when upper(trim(bp_nationalityiso)) rlike	"SJ|Svalbard"	then "SJ"
		when upper(trim(bp_nationalityiso)) rlike	"SK|斯洛伐克"	then "SK"
		when upper(trim(bp_nationalityiso)) rlike	"SL|塞拉利昂"	then "SL"
		when upper(trim(bp_nationalityiso)) rlike	"SM|圣马力诺"	then "SM"
		when upper(trim(bp_nationalityiso)) rlike	"SN|塞内加尔"	then "SN"
		when upper(trim(bp_nationalityiso)) rlike	"SO|索马里"	then "SO"
		when upper(trim(bp_nationalityiso)) rlike	"SR|苏里南"	then "SR"
		when upper(trim(bp_nationalityiso)) rlike	"ST|圣多美和普林西比"	then "ST"
		when upper(trim(bp_nationalityiso)) rlike	"SV|萨尔瓦多"	then "SV"
		when upper(trim(bp_nationalityiso)) rlike	"SY|叙利亚"	then "SY"
		when upper(trim(bp_nationalityiso)) rlike	"SZ|斯威士兰"	then "SZ"
		when upper(trim(bp_nationalityiso)) rlike	"TC|特克斯和凯科斯群岛"	then "TC"
		when upper(trim(bp_nationalityiso)) rlike	"TD|乍得"	then "TD"
		when upper(trim(bp_nationalityiso)) rlike	"TF|法属南部领地"	then "TF"
		when upper(trim(bp_nationalityiso)) rlike	"TG|多哥"	then "TG"
		when upper(trim(bp_nationalityiso)) rlike	"TH|泰国"	then "TH"
		when upper(trim(bp_nationalityiso)) rlike	"TJ|塔吉克斯坦"	then "TJ"
		when upper(trim(bp_nationalityiso)) rlike	"TK|托克劳"	then "TK"
		when upper(trim(bp_nationalityiso)) rlike	"TL|东帝汶"	then "TL"
		when upper(trim(bp_nationalityiso)) rlike	"TM|土库曼斯坦"	then "TM"
		when upper(trim(bp_nationalityiso)) rlike	"TN|突尼西亚"	then "TN"
		when upper(trim(bp_nationalityiso)) rlike	"TO|汤加"	then "TO"
		when upper(trim(bp_nationalityiso)) rlike	"TR|土耳其"	then "TR"
		when upper(trim(bp_nationalityiso)) rlike	"TT|特立尼达及托巴哥"	then "TT"
		when upper(trim(bp_nationalityiso)) rlike	"TV|图瓦卢"	then "TV"
		when upper(trim(bp_nationalityiso)) rlike	"TW|台湾"	then "TW"
		when upper(trim(bp_nationalityiso)) rlike	"TZ|坦桑尼亚"	then "TZ"
		when upper(trim(bp_nationalityiso)) rlike	"UA|乌克兰"	then "UA"
		when upper(trim(bp_nationalityiso)) rlike	"UG|乌干达"	then "UG"
		when upper(trim(bp_nationalityiso)) rlike	"UM|美国本土外小岛屿"	then "UM"
		when upper(trim(bp_nationalityiso)) rlike	"UN|联合国"	then "UN"
		when upper(trim(bp_nationalityiso)) rlike	"US|美国"	then "US"
		when upper(trim(bp_nationalityiso)) rlike	"UY|乌拉圭"	then "UY"
		when upper(trim(bp_nationalityiso)) rlike	"UZ|乌兹别克斯坦"	then "UZ"
		when upper(trim(bp_nationalityiso)) rlike	"VA|梵蒂冈"	then "VA"
		when upper(trim(bp_nationalityiso)) rlike	"VC|圣文森及格瑞那丁"	then "VC"
		when upper(trim(bp_nationalityiso)) rlike	"VE|委内瑞拉"	then "VE"
		when upper(trim(bp_nationalityiso)) rlike	"VG|英属维京群岛"	then "VG"
		when upper(trim(bp_nationalityiso)) rlike	"VI|美属维京群岛"	then "VI"
		when upper(trim(bp_nationalityiso)) rlike	"VN|越南"	then "VN"
		when upper(trim(bp_nationalityiso)) rlike	"VU|瓦努阿图"	then "VU"
		when upper(trim(bp_nationalityiso)) rlike	"WF|瓦利斯和富图纳"	then "WF"
		when upper(trim(bp_nationalityiso)) rlike	"WS|萨摩亚"	then "WS"
		when upper(trim(bp_nationalityiso)) rlike	"YE|也门"	then "YE"
		when upper(trim(bp_nationalityiso)) rlike	"YT|马约特"	then "YT"
		when upper(trim(bp_nationalityiso)) rlike	"ZA|南非"	then "ZA"
		when upper(trim(bp_nationalityiso)) rlike	"ZM|赞比亚"	then "ZM"
		when upper(trim(bp_nationalityiso)) rlike	"ZW|津巴布韦"	then "ZW"
		when upper(trim(bp_nationalityiso)) rlike	"BS|巴哈马"	then "BS"
		when upper(trim(bp_nationalityiso)) rlike	"BT|不丹"	then "BT"
		when upper(trim(bp_nationalityiso)) rlike	"BV|布韦岛"	then "BV"
		when upper(trim(bp_nationalityiso)) rlike	"BW|博茨瓦纳"	then "BW"
		when upper(trim(bp_nationalityiso)) rlike	"BY|白俄罗斯"	then "BY"
		when upper(trim(bp_nationalityiso)) rlike	"BZ|伯利兹"	then "BZ"
		when upper(trim(bp_nationalityiso)) rlike	"CA|加拿大"	then "CA"
		when upper(trim(bp_nationalityiso)) rlike	"CC|科科斯（基林）群岛"	then "CC"
		when upper(trim(bp_nationalityiso)) rlike	"CD|刚果（金）"	then "CD"
		when upper(trim(bp_nationalityiso)) rlike	"CF|中非共和国"	then "CF"
		when upper(trim(bp_nationalityiso)) rlike	"CG|刚果（布）"	then "CG"
		when upper(trim(bp_nationalityiso)) rlike	"CH|瑞士"	then "CH"
		when upper(trim(bp_nationalityiso)) rlike	"CI|科特迪瓦"	then "CI"
		when upper(trim(bp_nationalityiso)) rlike	"CK|库克群岛"	then "CK"
		when upper(trim(bp_nationalityiso)) rlike	"AX|奥兰"	then "AX"
		when upper(trim(bp_nationalityiso)) rlike	"AZ|阿塞拜疆"	then "AZ"
		when upper(trim(bp_nationalityiso)) rlike	"BA|波斯尼亚和黑塞哥维那"	then "BA"
		when upper(trim(bp_nationalityiso)) rlike	"BB|巴巴多斯"	then "BB"
		when upper(trim(bp_nationalityiso)) rlike	"BD|孟加拉国国"	then "BD"
		when upper(trim(bp_nationalityiso)) rlike	"BE|比利时"	then "BE"
		when upper(trim(bp_nationalityiso)) rlike	"BF|布基纳法索"	then "BF"
		when upper(trim(bp_nationalityiso)) rlike	"BG|保加利亚"	then "BG"
		when upper(trim(bp_nationalityiso)) rlike	"BH|巴林"	then "BH"
		when upper(trim(bp_nationalityiso)) rlike	"BI|布隆迪"	then "BI"
		when upper(trim(bp_nationalityiso)) rlike	"BJ|贝宁"	then "BJ"
		when upper(trim(bp_nationalityiso)) rlike	"BL|圣巴泰勒米"	then "BL"
		when upper(trim(bp_nationalityiso)) rlike	"BM|百慕大"	then "BM"
		when upper(trim(bp_nationalityiso)) rlike	"BN|文莱"	then "BN"
		when upper(trim(bp_nationalityiso)) rlike	"BO|玻利维亚"	then "BO"
		when upper(trim(bp_nationalityiso)) rlike	"BR|巴西"	then "BR"
	end as country,
	bp_customextension	custom_extension,
	bp_partnertype	customer_group,
	bp_customerstatus	customer_status,
	bp_partnercategory	customer_type,
	case when delete_flag in('0','1') then delete_flag end deleted,
	bp_employeeof	employee_of,
	bp_profile_ereadiness	ereadiness,
	REGEXP_REPLACE(bp_givenname,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	first_name,
	gcid	gcid,
	case 
		when trim(bp_gender) ='Company' then 'U'
		when trim(bp_gender) in ('0','else') then 'U'
		when trim(bp_gender) in ('1','先生','M 先生','M','MR.','M.','Male') then 'M'
		when trim(bp_gender) in ('2','女士','F 女士','F 小姐','MS','Ms','MS.','Ms.','Female') then 'F'
		when trim(bp_gender) is null or bp_gender='' then null
		else 'U'
	end gender,	
	bp_profile_highestdegree	highest_degree,
	bp_profile_hobbies	hobby,
	bp_homemarket	home_market,
	bp_profile_income	income,
	bp_profile_incomecurrency	income_currency,
	bp_initialcontact_delete	initial_contact_deleted,
	bp_initialcontact_owner	initial_contact_owner,
	bp_initialcontact_ownertype	initial_contact_owner_type,
	bp_initialsname	initials_name,
	bp_profile_interests	interested,
	bp_profile_communicationtypepreferred	interested_communication_channel,
	bp_profile_preferredsaleschannel	interested_sales_channel,
	bp_profile_vehicleinterests	interested_vehicle,
	bp_lastupdated_bydealer	last_modify_dealer,
	bp_lastupdated_bysource	last_modify_source,
	REGEXP_REPLACE(bp_surname,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") last_name,
	bp_profile_maritalstatus	marital_status,
	bp_market	market,
	bp_market_customextension	market_customextension,
	mh_action	mh_action,
	mh_clientid	mh_client_id,
	mh_clientvariantid	mh_client_variant_id,
	mh_customextension	mh_custom_extension,
	mh_gcdmmessageid	mh_gcdm_message_id,
	mh_mdmcontext	mh_mdm_context,
	mh_messageid	mh_message_id,
	mh_postprocessinginfo	mh_postprocessing_info,
	mh_senderid	mh_sender_id,
	mh_timestamp	mh_timestamp,
	mh_usecase	mh_use_case,
	mh_version	mh_version_number,
	bp_middlename	middle_name,
	case	
		WHEN regexp_replace(ua_mobile,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(ua_mobile,"[^+0-9]",""),'+','')
		WHEN regexp_replace(ua_mobile,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(ua_mobile,"[^+0-9]","")
		WHEN regexp_replace(ua_mobile,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(ua_mobile,"[^+0-9]",""))
		when regexp_replace(ua_mobile,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(ua_mobile,"[^+0-9]",""),2))
		when regexp_replace(ua_mobile,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(ua_mobile,"[^+0-9]",""),2)
	end mobile_phone_number,
	case when `ua_mobilevalidated`=true then 1 when `ua_mobilevalidated`=false then 0 else null end mobile_validated,
	bp_nameprefixcode	name_prefix_code,
	bp_namesuffixgeneration	name_suffix_generation,
	bp_namesupplementcode	name_supplement_code,
	bp_nickname	nick_name,
	bp_profile_numberofcarsinhousehold	number_of_cars_in_household,
	bp_profile_numberoffamilymembers	number_of_family_members,
	bp_profile_plannedpurchase	planned_purchase_date,
	bp_profile_plannedpurchasescheduled	planned_purchase_scheduled,
	bp_occupationcode	profession,
	bp_roles	roles,
	bp_salutation	salutation,
	bp_title	title,
	ua_alias	ua_alias,
	ua_emailvalidated	ua_email_validated,
	ua_gcid	ua_gcid,
	ua_mail	ua_mail,
	ua_status	ua_status,
	ucid	ucid
from source_gcdm.gcdm_account)a)b
;


--dwc_fact_com_carmen_b_cx_disclaimer_t clean
select
	row_id	row_id,
	case when created > '1949-01-01' then created end create_date,	
	created_by	create_user_id,
	case when last_upd > '1949-01-01' then last_upd end modify_date,	
	last_upd_by	modify_user_id,
	modification_num	modification_number,
	conflict_id	conflict_id,
	case when db_last_upd > '1949-01-01' then db_last_upd end db_modify_date,	
	case when disclaimer_dt > '1949-01-01' then disclaimer_dt end disclaimer_date,	
	acc_id	acc_id,
	con_id	customer_id,
	db_last_upd_src	db_last_upd_src,
	disclaimer_digital_con_id	disclaimer_digital_con_id,
	disclaimer_name	disclaimer_name,
	disclaimer_source	disclaimer_source,
	disclaimer_status	disclaimer_status,
	x_sub_source	x_sub_source,
	external_id	external_id,
	policy_store	policy_store,
	version	version_number,
	fday	fday
from source_carmen.a_carmen_b_cx_disclaimer;


--dwc_dim_com_carmen_s_asset_x_t clean
select
	attrib_01	attrib_01,
	attrib_02	brand_code,
	case when trim(attrib_03) rlike '^[0-9a-zA-Z]{17}$' then trim(attrib_03) end vin_17,
	attrib_04	attrib_04,
	attrib_05	model_code,
	attrib_06	attrib_06,
	attrib_07	attrib_07,
	attrib_08	attrib_08,
	attrib_09	attrib_09,
	attrib_10	attrib_10,
	attrib_11	attrib_11,
	attrib_12	attrib_12,
	attrib_13	attrib_13,
	attrib_14	attrib_14,
	attrib_15	attrib_15,
	attrib_16	attrib_16,
	attrib_17	attrib_17,
	attrib_18	attrib_18,
	attrib_19	attrib_19,
	attrib_20	retail_price,
	attrib_21	attrib_21,
	attrib_22	attrib_22,
	attrib_23	attrib_23,
	attrib_24	attrib_24,
	attrib_25	attrib_25,
	attrib_26	attrib_26,
	attrib_27	attrib_27,
	attrib_28	attrib_28,
	attrib_29	attrib_29,
	attrib_30	attrib_30,
	attrib_31	attrib_31,
	attrib_32	attrib_32,
	attrib_33	attrib_33,
	attrib_34	eseries_code,
	attrib_35	attrib_35,
	attrib_36	attrib_36,
	attrib_37	attrib_37,
	attrib_38	attrib_38,
	attrib_39	attrib_39,
	attrib_40	attrib_40,
	attrib_41	attrib_41,
	attrib_42	attrib_42,
	attrib_43	attrib_43,
	attrib_44	attrib_44,
	attrib_45	attrib_45,
	attrib_46	attrib_46,
	attrib_47	attrib_47,
	conflict_id	conflict_id,
	created	create_date,
	case when created > '1949-01-01' then created end create_date,
	created_by	created_user_id,
	case 
		when created is not null and last_upd_by BETWEEN created and CURRENT_TIMESTAMP() then last_upd_by
		when created is null and last_upd_by < CURRENT_TIMESTAMP() then  last_upd_by
	end modify_date,
	last_upd_by	modify_user_id,
	modification_num	modification_number,
	par_row_id	par_row_id,
	row_id	row_id,
	x_attrib_48	x_attrib_48,
	x_attrib_49	x_attrib_49,
	x_attrib_50	x_attrib_50,
	x_attrib_51	x_attrib_51,
	x_attrib_52	x_attrib_52,
	x_attrib_53	x_attrib_53,
	x_attrib_54	x_attrib_54,
	x_attrib_55	x_attrib_55,
	x_attrib_56	x_attrib_56,
	x_attrib_57	x_attrib_57,
	x_attrib_58	x_attrib_58,
	x_attrib_60	x_attrib_60,
	fday	fday
from source_carmen.a_carmen_s_asset_x;


--dwc_dim_cus_carmen_l_account_cn_t clean
select 
	t1_aba_number,
	t1_accnt_flag,
	t1_accnt_pr_cmpt_id,
	t1_accnt_type_cd,
	t1_active_flag,
	t1_adl_status,
	t1_agency_flag,
	t1_alias_name,
	case 
		when length(REGEXP_REPLACE(new_t1_alt_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_t1_alt_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_t1_alt_email_address,instr(new_t1_alt_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_t1_alt_email_address),1,instr(reverse(new_t1_alt_email_address),'.')-1))<2 then null
		when new_t1_alt_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_t1_alt_email_address,'\\.comcn$','.com.cn') 
		else new_t1_alt_email_address
	end t1_alt_email_address,
	t1_alt_email_loc_cd,
	t1_ans_srvc_ph_num,
	t1_asgn_date,
	t1_asgn_usr_excld_flag,
	t1_asset_amt,
	t1_atm_count,
	t1_avail_credit_amt,
	t1_base_curcy_cd,
	t1_bill_pblshr_flag,
	t1_bo_cust_grp_cd,
	t1_bo_ordqry_end_date,
	t1_bo_ordqry_start_date,
	t1_branch_flag,
	t1_branch_type_cd,
	t1_briefing_layout,
	t1_buying_group_flag,
	t1_bu_id,
	t1_call_frequency,
	t1_cc_txnproc_ac_num,
	t1_cc_txnproc_vndr_id,
	t1_cg_cons_end_offset,
	t1_cg_cons_strtoffset,
	t1_cg_dedn_auth_flag,
	t1_cg_prmo_end_offset,
	t1_cg_prmo_strt_day,
	t1_cg_ship_end_offset,
	t1_cg_ship_strtoffset,
	t1_cg_svp_a_lock_flag,
	t1_cg_svp_lock_flag,
	t1_cg_svp_skip_flag,
	t1_cg_svp_status,
	t1_cg_svp_upper_lock,
	t1_channel_type,
	t1_chnl_annl_sales,
	t1_chnl_qtr_sales,
	t1_chnl_sales_growth,
	t1_client_flag,
	t1_close_date,
	t1_cl_site_flag,
	t1_cmpt_flag,
	t1_conflict_id,
	t1_contract_vis_flag,
	t1_corp_stock_symbol,
	t1_court_pay_flag,
	create_date,
	create_user_id,
	t1_creator_login,
	t1_credit_days,
	t1_credit_score,
	t1_cross_street,
	t1_curr_pri_lst_id,
	t1_curr_rate_lst_id,
	t1_cur_srv_address_id,
	t1_cur_yr_bk,
	t1_cur_yr_bk_curcy_cd,
	t1_cur_yr_bl,
	t1_cur_yr_bl_curcy_cd,
	t1_cust_end_date,
	t1_cust_since_date,
	t1_cust_stat_cd,
	t1_dcking_num,
	t1_dedup_dataclnsd_date,
	t1_dedup_key_modify_date,
	t1_dedup_last_mtch_date,
	t1_dedup_token,
	t1_dept_num,
	t1_desc_text,
	t1_dflt_ship_prio_cd,
	t1_disa_all_mails_flag,
	t1_disa_cleanse_flag,
	t1_dist_channel_cd,
	t1_division,
	t1_division_count,
	t1_divn_cd,
	t1_divn_type_cd,
	t1_dom_ult_duns_num,
	t1_duns_num,
	t1_eai_error_text,
	t1_eai_exprt_stat_cd,
	t1_eai_sync_date,
	case 
		when length(REGEXP_REPLACE(new_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_email_address,instr(new_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_email_address),1,instr(reverse(new_email_address),'.')-1))<2 then null
		when new_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_email_address,'\\.comcn$','.com.cn') 
		else new_email_address
	end email_address,
	t1_email_loc_cd,
	t1_emp_count,
	t1_enterprise_flag,
	t1_evt_hotel_std_rt,
	t1_evt_loc_cd,
	t1_evt_loc_flag,
	t1_exch_date,
	t1_exec_spnsr_pstn_id,
	t1_expertise_cd,
	t1_facility_flag,
	t1_fcst_org_flag,
	t1_fin_resp_con_id,
	t1_frd_owner_emp_id,
	t1_frght_terms_cd,
	t1_frght_terms_info,
	t1_ful_center_flag,
	t1_fund_elig_flag,
	t1_general_ledger,
	t1_glblult_duns_num,
	t1_good_standing_flag,
	t1_grwth_strtgy_desc,
	t1_gsa_flag,
	t1_hard_to_reach,
	t1_hist_sls_curcy_cd,
	t1_hist_sls_exch_date,
	t1_hist_sls_vol,
	t1_hshldhd_age,
	t1_hshldhd_gen_cd,
	t1_hshldhd_occ_cd,
	t1_hshld_ethn_cd,
	t1_hshld_inc,
	t1_hshld_kids,
	t1_hshld_loc_cd,
	t1_hshld_size,
	t1_impl_desc,
	t1_impl_stage_cd,
	t1_incl_flag,
	t1_integration_id,
	t1_int_org_flag,
	t1_invstr_flag,
	t1_lang_id,
	t1_last_call_date,
	t1_last_mgr_revw_date,
	t1_last_revw_mgr_id,
	modify_date,
	modify_user_id,
	t1_latitude,
	t1_legal_form_cd,
	t1_loc,
	t1_location_level,
	t1_longitude,
	t1_loy_partner_cd,
	t1_main_email_address,
	t1_main_fax_phone_number,
	mobile_phone_number,
	t1_manager_name,
	t1_market_class_cd,
	t1_market_type_cd,
	t1_master_ou_id,
	t1_misc_flag,
	t1_modification_number,
	company_name,
	t1_name_1,
	t1_num_hshlds,
	t1_num_regs,
	t1_ou_number,
	t1_ou_number1,
	t1_ou_type_cd,
	t1_partner_flag,
	t1_par_bu_id,
	t1_par_divn_id,
	t1_par_duns_number,
	t1_par_ou_id,
	t1_par_row_id,
	t1_password,
	t1_payment_term_id,
	t1_pay_type_cd,
	t1_plan_group_flag,
	t1_po_crdchk_thrsh,
	t1_po_crdchk_thrsh_date,
	t1_po_pay_curcy_cd,
	t1_po_pay_exch_date,
	t1_po_pay_flag,
	t1_po_pay_max_amt,
	t1_pref_comm_meth_cd,
	t1_privacy_cd,
	t1_pri_grp_cd,
	t1_pri_yr_bk,
	t1_pri_yr_bk_curcy_cd,
	t1_pri_yr_bl,
	t1_pri_yr_bl_curcy_cd,
	t1_proced_flag,
	t1_prod_dist_cd,
	t1_prospect_flag,
	t1_prtnrshp_start_date,
	t1_prtnr_cert_cd,
	t1_prtnr_flag,
	t1_prtnr_org_int_id,
	t1_prtnr_publish_flag,
	t1_prtnr_sales_rank,
	t1_prtnr_type_cd,
	t1_pr_address_id,
	t1_pr_address_per_id,
	t1_pr_agree_id,
	t1_pr_bl_address_id,
	t1_pr_bl_ou_id,
	t1_pr_bl_per_id,
	t1_pr_competitor_id,
	t1_pr_con_id,
	t1_pr_co_mstr_id,
	t1_pr_crdate_area_id,
	t1_pr_discnt_id,
	t1_pr_eai_sls_area_id,
	t1_pr_emp_rel_id,
	t1_pr_emp_terr_id,
	t1_pr_fulfl_invloc_id,
	t1_pr_geo_id,
	t1_pr_implsvc_vndr_id,
	t1_pr_indust_id,
	t1_pr_logo_id,
	t1_pr_med_proc_id,
	t1_pr_mgr_postn_id,
	t1_pr_mkt_seg_id,
	t1_pr_org_trgt_mkt_id,
	t1_pr_ou_type_id,
	t1_pr_pay_ou_id,
	t1_pr_phone_id,
	t1_pr_postn_id,
	t1_pr_prfl_id,
	t1_pr_pri_lst_id,
	t1_pr_prod_id,
	t1_pr_prod_ln_id,
	t1_pr_prtnr_ou_id,
	t1_pr_prtnr_tier_id,
	t1_pr_prtnr_type_id,
	t1_pr_ptshp_mktseg_id,
	t1_pr_rep_asgn_type,
	t1_pr_rep_dnrm_flag,
	t1_pr_rep_manl_flag,
	t1_pr_rep_sys_flag,
	t1_pr_security_id,
	t1_pr_ship_address_id,
	t1_pr_ship_ou_id,
	t1_pr_ship_per_id,
	t1_pr_situ_id,
	t1_pr_specialty_id,
	t1_pr_spec_id,
	t1_pr_srv_agree_id,
	t1_pr_svc_postn_id,
	t1_pr_syn_id,
	t1_pr_terr_id,
	t1_pr_vehicle_id,
	t1_ptntl_sls_curcy_cd,
	t1_ptntl_sls_exch_date,
	t1_ptntl_sls_vol,
	t1_rating,
	t1_reference_cust_flag,
	t1_reference_start_date,
	t1_region,
	t1_region_id,
	t1_rel_id,
	t1_rel_name,
	t1_revenue_class_cd,
	t1_rlzd_roi_desc,
	t1_route,
	company_id,
	t1_rplcd_wth_cmpt_flag,
	t1_rte_to_mkt_desc,
	t1_sales_emp_cnt,
	t1_sales_org_cd,
	t1_service_emp_cnt,
	t1_skip_po_crdchk_flag,
	t1_sls_dist_cd,
	t1_srv_provdr_flag,
	t1_staff,
	t1_status_cd,
	t1_stat_chg_date,
	t1_stat_reason_cd,
	t1_store_size,
	t1_suppress_share_flag,
	t1_supress_call_flag,
	t1_survey_type_cd,
	t1_svc_cvrg_stat_cd,
	t1_tax_exempt_flag,
	t1_tax_exempt_num,
	t1_tax_iden_num,
	t1_tax_list_id,
	t1_ticker_sym,
	t1_tlr_intg_msg,
	t1_tlr_intg_ret_cd,
	t1_trgt_impl_date,
	t1_url,
	t1_vat_regn_num,
	t1_visit_frequency,
	t1_visit_period,
	t1_weekly_acv,
	t1_x_accnt_name_1,
	t1_x_accnt_name_2,
	t1_x_accnt_name_3,
	t1_x_acc_salutation,
	t1_x_add_fax_number,
	t1_x_add_ph_num,
	t1_x_alphabet_flag,
	t1_x_anagraphical_role,
	t1_x_ape,
	t1_x_apet,
	t1_x_blocked_by_sf,
	t1_x_bmw,
	t1_x_bmw_car_pool,
	t1_x_bmw_fs,
	t1_x_bmw_i_flag,
	t1_x_bmw_motorcycle,
	t1_x_branche,
	t1_x_branche_subsidary,
	t1_x_business_code,
	t1_x_bus_part_id,
	t1_x_bus_type_code,
	t1_x_ccc_payment_flag,
	t1_x_certified_partner_flag,
	t1_x_cham_com_nr,
	t1_x_cl_code,
	t1_x_cl_name,
	t1_x_comm_cust,
	t1_x_company_code,
	t1_x_company_legal_name,
	t1_x_contracting_party_id,
	t1_x_con_acc_switch_count,
	t1_x_con_acc_switch_type,
	t1_x_created_by_epa_transact,
	t1_x_created_by_source,
	t1_x_csn,
	t1_x_csn_orig,
	t1_x_customer_card,
	t1_x_cust_class,
	t1_x_cust_num_fs,
	t1_x_dealer_do_not_contact,
	t1_x_dfe_id,
	t1_x_dlr_end_date,
	t1_x_dlr_nickname,
	t1_x_dlr_renamed_flag,
	t1_x_dn_contact_flag,
	t1_x_do_not_contact,
	t1_x_dpa_consents_date,
	t1_x_dpa_email_consent,
	t1_x_dpa_email_consent_flag,
	t1_x_dpa_mail_consent,
	t1_x_dpa_mail_consent_flag,
	t1_x_dpa_phone_consent,
	t1_x_dpa_phone_consent_flag,
	t1_x_dpa_product_cat,
	t1_x_dpa_sms_consent,
	t1_x_dpa_sms_consent_flag,
	t1_x_dpa_modify_source,
	case 
		when length(REGEXP_REPLACE(new_t1_x_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_t1_x_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_t1_x_email_address,instr(new_t1_x_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_t1_x_email_address),1,instr(reverse(new_t1_x_email_address),'.')-1))<2 then null
		when new_t1_x_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_t1_x_email_address,'\\.comcn$','.com.cn') 
		else new_t1_x_email_address
	end t1_x_email_address,
	t1_x_employee_range,
	t1_x_fiscal_number,
	t1_x_flash_note,
	t1_x_freelancer_flag,
	t1_x_gk_status,
	t1_x_inactive_flag,
	t1_x_intl_dealer_id,
	t1_x_int_cust_flag,
	t1_x_loc_dealer_id,
	t1_x_loc_sf_dealer_id,
	t1_x_lst_main_address_calc_date,
	t1_x_main_address_modify_by_src,
	t1_x_main_address_modify_src,
	t1_x_main_phone_number,
	t1_x_main_email_address_low,
	t1_x_main_outlet_id,
	t1_x_major_cust,
	t1_x_make_pr_id,
	t1_x_master_cust,
	t1_x_master_number,
	t1_x_master_outlet_number,
	t1_x_merged_to_acc_id,
	t1_x_mini,
	t1_x_mini_club,
	t1_x_ml_code,
	t1_x_ml_name,
	t1_x_motor_club,
	company_name_low,
	t1_x_never_call,
	t1_x_never_email_address,
	t1_x_never_fax,
	t1_x_never_mail,
	t1_x_new_record_flag,
	t1_x_no_address_fwd_to_dealer,
	t1_x_no_after_sales_contact,
	t1_x_no_fwd_to_dealer,
	t1_x_no_select_for_segment,
	t1_x_other_makes,
	t1_x_outlet_name,
	t1_x_outlet_number,
	t1_x_outlet_titel,
	t1_x_outlet_type,
	t1_x_outlet_type_cd,
	t1_x_ou_num_low,
	t1_x_owner_name,
	t1_x_owner_number,
	t1_x_partner_cd,
	t1_x_payment_code,
	t1_x_portfolio_cd,
	t1_x_portfolio_name,
	t1_x_pr_address_id_former,
	t1_x_regio_alphabet_flag,
	t1_x_rel_type,
	t1_x_rel_type_code,
	t1_x_rfe_flag,
	t1_x_sales_channel,
	t1_x_sales_channel_cd,
	t1_x_sf_customer_id2,
	t1_x_siret,
	t1_x_siret_main_business,
	t1_x_source,
	t1_x_stop_advertisement,
	t1_x_stop_bmw_service_card,
	t1_x_stop_dealer_kpp,
	t1_x_stop_fulfillment,
	t1_x_stop_magazine,
	t1_x_stop_market_research,
	t1_x_stop_mini_service_card,
	t1_x_stop_moto_service_card,
	t1_x_stop_newsletter,
	t1_x_stop_sf_communication,
	t1_x_stop_survey,
	t1_x_suppress_call,
	t1_x_suppress_mail,
	t1_x_suppress_wcp,
	t1_x_sup_in_market_number,
	t1_x_sup_in_part_number,
	t1_x_sys_id,
	t1_x_sys_id_switch,
	t1_x_tax_obligatory_flag,
	t1_x_tefet,
	t1_x_tefet_employee_number,
	t1_x_teledata_number,
	t1_x_total_car_pool,
	t1_x_turnover_range,
	t1_x_unpaid_level,
	t1_x_modified_by_source,
	t1_x_modified_source,
	t1_x_modify_by_epa_transact,
	t1_x_vp_class,
	t1_x_vp_num,
	t1_x_linked_account_id,
	--null_1,
	--null_2,
	--null_3,
	t2_attrib_01,
	partner,
	t2_attrib_03,
	t2_attrib_04,
	t2_attrib_05,
	pix_receiver,
	offered_service,
	public_flag,
	bankrupt_flag,
	export_to_ecom_flag,
	t2_attrib_11,
	offline_from_date,
	offline_to_date,
	annual_revenue,
	revenue_growth_rate,
	number_employees,
	visit_frequency,
	t2_attrib_18,
	t2_attrib_19,
	number_bmw,
	number_mini,
	t2_attrib_22,
	alphabet_fleet,
	eu_fleet,
	local_fleet,
	t2_attrib_26,
	foundation_date,
	t2_attrib_28,
	t2_attrib_29,
	t2_attrib_30,
	contract_start_date,
	contract_end_date,
	registration_date,
	dealer_sales_rep,
	acc_brands_dealer_district,
	t2_attrib_36,
	sales_region,
	brand,
	leasing_fleet_owner,
	brand_choice,
	la_support,
	origin,
	al_key_accnt_mgr,
	t2_attrib_44,
	t2_attrib_45,
	current_acquisition_method,
	t2_attrib_47,
	cs_accnt_mgr,
	t2_attrib_49,
	lease_company_1,
	accnt_mgr_1,
	car_policy,
	duns_code,
	t2_attrib_54,
	t2_attrib_56,
	number_suppliers,
	t2_attrib_58,
	accnt_number_employees,
	bmw_percent,
	mini_percent,
	t2_attrib_62,
	t2_attrib_63,
	t2_attrib_64,
	t2_attrib_65,
	lease_company_2,
	lease_company_3,
	related_sales_category,
	alphabet_status,
	customer_type_sale,
	quarter_accnt_approach,
	customer_potential,
	t2_attrib_73,
	t2_attrib_74,
	t2_attrib_75,
	t2_attrib_76,
	t2_attrib_77,
	t2_attrib_78,
	t2_attrib_79,
	t2_attrib_80,
	t2_attrib_81,
	t2_conflict_id,
	t2_create_date,
	t2_create_user_id,
	t2_dcking_num,
	t2_fri_1st_close_tm,
	t2_fri_1st_open_tm,
	t2_fri_2nd_close_tm,
	t2_fri_2nd_open_tm,
	t2_modify_date,
	t2_modify_user_id,
	t2_modification_number,
	t2_mon_1st_close_tm,
	t2_mon_1st_open_tm,
	t2_mon_2nd_close_tm,
	t2_mon_2nd_open_tm,
	t2_par_row_id,
	t2_row_id,
	t2_sat_1st_close_tm,
	t2_sat_1st_open_tm,
	t2_sat_2nd_close_tm,
	t2_sat_2nd_open_tm,
	t2_sun_1st_close_tm,
	t2_sun_1st_open_tm,
	t2_sun_2nd_close_tm,
	t2_sun_2nd_open_tm,
	t2_thu_1st_close_tm,
	t2_thu_1st_open_tm,
	t2_thu_2nd_close_tm,
	t2_thu_2nd_open_tm,
	t2_tue_1st_close_tm,
	t2_tue_1st_open_tm,
	t2_tue_2nd_close_tm,
	t2_tue_2nd_open_tm,
	t2_wed_1st_close_tm,
	t2_wed_1st_open_tm,
	t2_wed_2nd_close_tm,
	t2_wed_2nd_open_tm,
	t2_x_agenon_mandatory_flag,
	t2_x_blacklist_flag,
	t2_x_budgetnon_mandatory_flag,
	t2_x_contract_alive_flag,
	t2_x_dornon_mandatory_flag,
	--null_5,
	t2_x_integration_id
from (
select 
	a.*,
	case
        when email_address rlike '^\\..*\\.$' then regexp_replace(substr(email_address,2,length(email_address)-2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '^\\.' then regexp_replace(substr(email_address,2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '\\.$' then regexp_replace(substr(email_address,1,length(email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(email_address,'[^A-Za-z0-9-.@_]','') 
    end new_t1_alt_email_address,
	case
        when email_address rlike '^\\..*\\.$' then regexp_replace(substr(email_address,2,length(email_address)-2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '^\\.' then regexp_replace(substr(email_address,2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '\\.$' then regexp_replace(substr(email_address,1,length(email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(email_address,'[^A-Za-z0-9-.@_]','') 
    end new_email_address,
    case
        when t1_x_email_address rlike '^\\..*\\.$' then regexp_replace(substr(t1_x_email_address,2,length(t1_x_email_address)-2),'[^A-Za-z0-9-.@_]','')
        when t1_x_email_address rlike '^\\.' then regexp_replace(substr(t1_x_email_address,2),'[^A-Za-z0-9-.@_]','')
        when t1_x_email_address rlike '\\.$' then regexp_replace(substr(t1_x_email_address,1,length(t1_x_email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(t1_x_email_address,'[^A-Za-z0-9-.@_]','') 
    end new_t1_x_email_address
from(
select 
	T1.aba_number	t1_aba_number,
	T1.accnt_flg	t1_accnt_flag,
	T1.accnt_pr_cmpt_id	t1_accnt_pr_cmpt_id,
	T1.accnt_type_cd	t1_accnt_type_cd,
	T1.active_flg	t1_active_flag,
	T1.adl_status	t1_adl_status,
	T1.agency_flg	t1_agency_flag,
	T1.alias_name	t1_alias_name,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(T1.alias_name,1,instr(T1.alias_name,'@')),REGEXP_REPLACE(substr(T1.alias_name,instr(T1.alias_name,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') t1_alt_email_address,
	T1.alt_email_loc_cd	t1_alt_email_loc_cd,
	T1.ans_srvc_ph_num	t1_ans_srvc_ph_num,
	case when T1.asgn_dt > '1949-01-01' then T1.asgn_dt end t1_asgn_date,
	T1.asgn_usr_excld_flg	t1_asgn_usr_excld_flag,
	T1.asset_amt	t1_asset_amt,
	T1.atm_count	t1_atm_count,
	T1.avail_credit_amt	t1_avail_credit_amt,
	T1.base_curcy_cd	t1_base_curcy_cd,
	T1.bill_pblshr_flg	t1_bill_pblshr_flag,
	T1.bo_cust_grp_cd	t1_bo_cust_grp_cd,
	case when T1.bo_ordqry_end_dt > '1949-01-01' then T1.bo_ordqry_end_dt end t1_bo_ordqry_end_date,
	case when T1.bo_ordqry_start_dt > '1949-01-01' then T1.bo_ordqry_start_dt end t1_bo_ordqry_start_date,
	T1.branch_flg	t1_branch_flag,
	T1.branch_type_cd	t1_branch_type_cd,
	T1.briefing_layout	t1_briefing_layout,
	T1.buying_group_flg	t1_buying_group_flag,
	T1.bu_id	t1_bu_id,
	T1.call_frequency	t1_call_frequency,
	T1.cc_txnproc_ac_num	t1_cc_txnproc_ac_num,
	T1.cc_txnproc_vndr_id	t1_cc_txnproc_vndr_id,
	T1.cg_cons_end_offset	t1_cg_cons_end_offset,
	T1.cg_cons_strtoffset	t1_cg_cons_strtoffset,
	T1.cg_dedn_auth_flg	t1_cg_dedn_auth_flag,
	T1.cg_prmo_end_offset	t1_cg_prmo_end_offset,
	T1.cg_prmo_strt_day	t1_cg_prmo_strt_day,
	T1.cg_ship_end_offset	t1_cg_ship_end_offset,
	T1.cg_ship_strtoffset	t1_cg_ship_strtoffset,
	T1.cg_svp_a_lock_flg	t1_cg_svp_a_lock_flag,
	T1.cg_svp_lock_flg	t1_cg_svp_lock_flag,
	T1.cg_svp_skip_flg	t1_cg_svp_skip_flag,
	T1.cg_svp_status	t1_cg_svp_status,
	T1.cg_svp_upper_lock	t1_cg_svp_upper_lock,
	T1.channel_type	t1_channel_type,
	T1.chnl_annl_sales	t1_chnl_annl_sales,
	T1.chnl_qtr_sales	t1_chnl_qtr_sales,
	T1.chnl_sales_growth	t1_chnl_sales_growth,
	T1.client_flg	t1_client_flag,
	case when T1.close_dt > '1949-01-01' then T1.close_dt end t1_close_date,
	T1.cl_site_flg	t1_cl_site_flag,
	T1.cmpt_flg	t1_cmpt_flag,
	T1.conflict_id	t1_conflict_id,
	T1.contract_vis_flg	t1_contract_vis_flag,
	T1.corp_stock_symbol	t1_corp_stock_symbol,
	T1.court_pay_flg	t1_court_pay_flag,
	case when T1.created > '1949-01-01' then T1.created end create_date,
	T1.created_by	create_user_id,
	T1.creator_login	t1_creator_login,
	T1.credit_days	t1_credit_days,
	T1.credit_score	t1_credit_score,
	T1.cross_street	t1_cross_street,
	T1.curr_pri_lst_id	t1_curr_pri_lst_id,
	T1.curr_rate_lst_id	t1_curr_rate_lst_id,
	T1.cur_srv_addr_id	t1_cur_srv_address_id,
	T1.cur_yr_bk	t1_cur_yr_bk,
	T1.cur_yr_bk_curcy_cd	t1_cur_yr_bk_curcy_cd,
	T1.cur_yr_bl	t1_cur_yr_bl,
	T1.cur_yr_bl_curcy_cd	t1_cur_yr_bl_curcy_cd,
	case when T1.cust_end_dt > '1949-01-01' then T1.cust_end_dt end t1_cust_end_date,
	case when T1.cust_since_dt > '1949-01-01' then T1.cust_since_dt end t1_cust_since_date,
	T1.cust_stat_cd	t1_cust_stat_cd,
	T1.dcking_num	t1_dcking_num,
	case when T1.dedup_dataclnsd_dt > '1949-01-01' then T1.dedup_dataclnsd_dt end t1_dedup_dataclnsd_date,
	case when T1.dedup_key_upd_dt > '1949-01-01' then T1.dedup_key_upd_dt end t1_dedup_key_modify_date,
	case when T1.dedup_last_mtch_dt > '1949-01-01' then T1.dedup_last_mtch_dt end t1_dedup_last_mtch_date,
	T1.dedup_token	t1_dedup_token,
	T1.dept_num	t1_dept_num,
	T1.desc_text	t1_desc_text,
	T1.dflt_ship_prio_cd	t1_dflt_ship_prio_cd,
	T1.disa_all_mails_flg	t1_disa_all_mails_flag,
	T1.disa_cleanse_flg	t1_disa_cleanse_flag,
	T1.dist_channel_cd	t1_dist_channel_cd,
	T1.division	t1_division,
	T1.division_count	t1_division_count,
	T1.divn_cd	t1_divn_cd,
	T1.divn_type_cd	t1_divn_type_cd,
	T1.dom_ult_duns_num	t1_dom_ult_duns_num,
	T1.duns_num	t1_duns_num,
	T1.eai_error_text	t1_eai_error_text,
	T1.eai_exprt_stat_cd	t1_eai_exprt_stat_cd,
	case when T1.eai_sync_dt > '1949-01-01' then T1.eai_sync_dt end t1_eai_sync_date,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(T1.email_addr,1,instr(T1.email_addr,'@')),REGEXP_REPLACE(substr(T1.email_addr,instr(T1.email_addr,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') email_address,
	T1.email_loc_cd	t1_email_loc_cd,
	T1.emp_count	t1_emp_count,
	T1.enterprise_flag	t1_enterprise_flag,
	T1.evt_hotel_std_rt	t1_evt_hotel_std_rt,
	T1.evt_loc_cd	t1_evt_loc_cd,
	T1.evt_loc_flg	t1_evt_loc_flag,
	case when T1.exch_dt > '1949-01-01' then T1.exch_dt end t1_exch_date,
	T1.exec_spnsr_pstn_id	t1_exec_spnsr_pstn_id,
	T1.expertise_cd	t1_expertise_cd,
	T1.facility_flg	t1_facility_flag,
	T1.fcst_org_flg	t1_fcst_org_flag,
	T1.fin_resp_con_id	t1_fin_resp_con_id,
	T1.frd_owner_emp_id	t1_frd_owner_emp_id,
	T1.frght_terms_cd	t1_frght_terms_cd,
	T1.frght_terms_info	t1_frght_terms_info,
	T1.ful_center_flg	t1_ful_center_flag,
	T1.fund_elig_flg	t1_fund_elig_flag,
	T1.general_ledger	t1_general_ledger,
	T1.glblult_duns_num	t1_glblult_duns_num,
	T1.good_standing_flg	t1_good_standing_flag,
	T1.grwth_strtgy_desc	t1_grwth_strtgy_desc,
	T1.gsa_flg	t1_gsa_flag,
	T1.hard_to_reach	t1_hard_to_reach,
	T1.hist_sls_curcy_cd	t1_hist_sls_curcy_cd,
	case when T1.hist_sls_exch_dt > '1949-01-01' then T1.hist_sls_exch_dt end t1_hist_sls_exch_date,
	T1.hist_sls_vol	t1_hist_sls_vol,
	T1.hshldhd_age	t1_hshldhd_age,
	T1.hshldhd_gen_cd	t1_hshldhd_gen_cd,
	T1.hshldhd_occ_cd	t1_hshldhd_occ_cd,
	T1.hshld_ethn_cd	t1_hshld_ethn_cd,
	T1.hshld_inc	t1_hshld_inc,
	T1.hshld_kids	t1_hshld_kids,
	T1.hshld_loc_cd	t1_hshld_loc_cd,
	T1.hshld_size	t1_hshld_size,
	T1.impl_desc	t1_impl_desc,
	T1.impl_stage_cd	t1_impl_stage_cd,
	T1.incl_flg	t1_incl_flag,
	T1.integration_id	t1_integration_id,
	T1.int_org_flg	t1_int_org_flag,
	T1.invstr_flg	t1_invstr_flag,
	T1.lang_id	t1_lang_id,
	case when T1.last_call_dt > '1949-01-01' then T1.last_call_dt end t1_last_call_date,
	case when T1.last_mgr_revw_dt > '1949-01-01' then T1.last_mgr_revw_dt end t1_last_mgr_revw_date,
	T1.last_revw_mgr_id	t1_last_revw_mgr_id,
	case 
		when T1.created is not null and T1.last_upd BETWEEN T1.created and CURRENT_TIMESTAMP() then T1.created 
		when T1.created is null and T1.last_upd < CURRENT_TIMESTAMP() then T1.created
	end modify_date,
	T1.last_upd_by	modify_user_id,
	T1.latitude	t1_latitude,
	T1.legal_form_cd	t1_legal_form_cd,
	T1.loc	t1_loc,
	T1.location_level	t1_location_level,
	T1.longitude	t1_longitude,
	T1.loy_partner_cd	t1_loy_partner_cd,
	T1.main_email_addr	t1_main_email_address,
	T1.main_fax_ph_num	t1_main_fax_phone_number,
	case 
		when regexp_replace(T1.main_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.main_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.main_ph_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.main_ph_num,'[^0-9]','')
		when regexp_replace(T1.main_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.main_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.main_ph_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.main_ph_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.main_ph_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.main_ph_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.main_ph_num,"[^+0-9]","")
		WHEN regexp_replace(T1.main_ph_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.main_ph_num,"[^+0-9]",""))
		when regexp_replace(T1.main_ph_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.main_ph_num,"[^+0-9]",""),2))
		when regexp_replace(T1.main_ph_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.main_ph_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.main_ph_num,"[^0-9]",""))>20 or length(regexp_replace(T1.main_ph_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.main_ph_num,'[^0-9]','')
	end mobile_phone_number,
	T1.manager_name	t1_manager_name,
	T1.market_class_cd	t1_market_class_cd,
	T1.market_type_cd	t1_market_type_cd,
	T1.master_ou_id	t1_master_ou_id,
	T1.misc_flg	t1_misc_flag,
	T1.modification_num	t1_modification_number,
	T1.name	company_name,
	T1.name_1	t1_name_1,
	T1.num_hshlds	t1_num_hshlds,
	T1.num_regs	t1_num_regs,
	T1.ou_num	t1_ou_number,
	T1.ou_num_1	t1_ou_number1,
	T1.ou_type_cd	t1_ou_type_cd,
	T1.partner_flg	t1_partner_flag,
	T1.par_bu_id	t1_par_bu_id,
	T1.par_divn_id	t1_par_divn_id,
	T1.par_duns_num	t1_par_duns_number,
	T1.par_ou_id	t1_par_ou_id,
	T1.par_row_id	t1_par_row_id,
	T1.password	t1_password,
	T1.payment_term_id	t1_payment_term_id,
	T1.pay_type_cd	t1_pay_type_cd,
	T1.plan_group_flg	t1_plan_group_flag,
	T1.po_crdchk_thrsh	t1_po_crdchk_thrsh,
	case when T1.po_crdchk_thrsh_dt > '1949-01-01' then T1.po_crdchk_thrsh_dt end t1_po_crdchk_thrsh_date,
	T1.po_pay_curcy_cd	t1_po_pay_curcy_cd,
	case when T1.po_pay_exch_dt > '1949-01-01' then T1.po_pay_exch_dt end t1_po_pay_exch_date,
	T1.po_pay_flg	t1_po_pay_flag,
	T1.po_pay_max_amt	t1_po_pay_max_amt,
	T1.pref_comm_meth_cd	t1_pref_comm_meth_cd,
	T1.privacy_cd	t1_privacy_cd,
	T1.pri_grp_cd	t1_pri_grp_cd,
	T1.pri_yr_bk	t1_pri_yr_bk,
	T1.pri_yr_bk_curcy_cd	t1_pri_yr_bk_curcy_cd,
	T1.pri_yr_bl	t1_pri_yr_bl,
	T1.pri_yr_bl_curcy_cd	t1_pri_yr_bl_curcy_cd,
	T1.proced_flg	t1_proced_flag,
	T1.prod_dist_cd	t1_prod_dist_cd,
	T1.prospect_flg	t1_prospect_flag,
	case when T1.prtnrshp_start_dt > '1949-01-01' then T1.prtnrshp_start_dt end t1_prtnrshp_start_date,
	T1.prtnr_cert_cd	t1_prtnr_cert_cd,
	T1.prtnr_flg	t1_prtnr_flag,
	T1.prtnr_org_int_id	t1_prtnr_org_int_id,
	T1.prtnr_publish_flg	t1_prtnr_publish_flag,
	T1.prtnr_sales_rank	t1_prtnr_sales_rank,
	T1.prtnr_type_cd	t1_prtnr_type_cd,
	T1.pr_addr_id	t1_pr_address_id,
	T1.pr_addr_per_id	t1_pr_address_per_id,
	T1.pr_agree_id	t1_pr_agree_id,
	T1.pr_bl_addr_id	t1_pr_bl_address_id,
	T1.pr_bl_ou_id	t1_pr_bl_ou_id,
	T1.pr_bl_per_id	t1_pr_bl_per_id,
	T1.pr_competitor_id	t1_pr_competitor_id,
	T1.pr_con_id	t1_pr_con_id,
	T1.pr_co_mstr_id	t1_pr_co_mstr_id,
	T1.pr_crdt_area_id	t1_pr_crdate_area_id,
	T1.pr_discnt_id	t1_pr_discnt_id,
	T1.pr_eai_sls_area_id	t1_pr_eai_sls_area_id,
	T1.pr_emp_rel_id	t1_pr_emp_rel_id,
	T1.pr_emp_terr_id	t1_pr_emp_terr_id,
	T1.pr_fulfl_invloc_id	t1_pr_fulfl_invloc_id,
	T1.pr_geo_id	t1_pr_geo_id,
	T1.pr_implsvc_vndr_id	t1_pr_implsvc_vndr_id,
	T1.pr_indust_id	t1_pr_indust_id,
	T1.pr_logo_id	t1_pr_logo_id,
	T1.pr_med_proc_id	t1_pr_med_proc_id,
	T1.pr_mgr_postn_id	t1_pr_mgr_postn_id,
	T1.pr_mkt_seg_id	t1_pr_mkt_seg_id,
	T1.pr_org_trgt_mkt_id	t1_pr_org_trgt_mkt_id,
	T1.pr_ou_type_id	t1_pr_ou_type_id,
	T1.pr_pay_ou_id	t1_pr_pay_ou_id,
	T1.pr_phone_id	t1_pr_phone_id,
	T1.pr_postn_id	t1_pr_postn_id,
	T1.pr_prfl_id	t1_pr_prfl_id,
	T1.pr_pri_lst_id	t1_pr_pri_lst_id,
	T1.pr_prod_id	t1_pr_prod_id,
	T1.pr_prod_ln_id	t1_pr_prod_ln_id,
	T1.pr_prtnr_ou_id	t1_pr_prtnr_ou_id,
	T1.pr_prtnr_tier_id	t1_pr_prtnr_tier_id,
	T1.pr_prtnr_type_id	t1_pr_prtnr_type_id,
	T1.pr_ptshp_mktseg_id	t1_pr_ptshp_mktseg_id,
	T1.pr_rep_asgn_type	t1_pr_rep_asgn_type,
	T1.pr_rep_dnrm_flg	t1_pr_rep_dnrm_flag,
	T1.pr_rep_manl_flg	t1_pr_rep_manl_flag,
	T1.pr_rep_sys_flg	t1_pr_rep_sys_flag,
	T1.pr_security_id	t1_pr_security_id,
	T1.pr_ship_addr_id	t1_pr_ship_address_id,
	T1.pr_ship_ou_id	t1_pr_ship_ou_id,
	T1.pr_ship_per_id	t1_pr_ship_per_id,
	T1.pr_situ_id	t1_pr_situ_id,
	T1.pr_specialty_id	t1_pr_specialty_id,
	T1.pr_spec_id	t1_pr_spec_id,
	T1.pr_srv_agree_id	t1_pr_srv_agree_id,
	T1.pr_svc_postn_id	t1_pr_svc_postn_id,
	T1.pr_syn_id	t1_pr_syn_id,
	T1.pr_terr_id	t1_pr_terr_id,
	T1.pr_vehicle_id	t1_pr_vehicle_id,
	T1.ptntl_sls_curcy_cd	t1_ptntl_sls_curcy_cd,
	case when T1.ptntl_sls_exch_dt > '1949-01-01' then T1.ptntl_sls_exch_dt end t1_ptntl_sls_exch_date,
	T1.ptntl_sls_vol	t1_ptntl_sls_vol,
	T1.rating	t1_rating,
	T1.reference_cust_flg	t1_reference_cust_flag,
	case when T1.reference_start_dt > '1949-01-01' then T1.reference_start_dt end t1_reference_start_date,
	T1.region	t1_region,
	T1.region_id	t1_region_id,
	T1.rel_id	t1_rel_id,
	T1.rel_name	t1_rel_name,
	T1.revenue_class_cd	t1_revenue_class_cd,
	T1.rlzd_roi_desc	t1_rlzd_roi_desc,
	T1.route	t1_route,
	T1.row_id	company_id,
	T1.rplcd_wth_cmpt_flg	t1_rplcd_wth_cmpt_flag,
	T1.rte_to_mkt_desc	t1_rte_to_mkt_desc,
	T1.sales_emp_cnt	t1_sales_emp_cnt,
	T1.sales_org_cd	t1_sales_org_cd,
	T1.service_emp_cnt	t1_service_emp_cnt,
	T1.skip_po_crdchk_flg	t1_skip_po_crdchk_flag,
	T1.sls_dist_cd	t1_sls_dist_cd,
	T1.srv_provdr_flg	t1_srv_provdr_flag,
	T1.staff	t1_staff,
	T1.status_cd	t1_status_cd,
	case when T1.stat_chg_dt > '1949-01-01' then T1.stat_chg_dt end t1_stat_chg_date,
	T1.stat_reason_cd	t1_stat_reason_cd,
	T1.store_size	t1_store_size,
	T1.suppress_share_flg	t1_suppress_share_flag,
	T1.supress_call_flg	t1_supress_call_flag,
	T1.survey_type_cd	t1_survey_type_cd,
	T1.svc_cvrg_stat_cd	t1_svc_cvrg_stat_cd,
	T1.tax_exempt_flg	t1_tax_exempt_flag,
	T1.tax_exempt_num	t1_tax_exempt_num,
	T1.tax_iden_num	t1_tax_iden_num,
	T1.tax_list_id	t1_tax_list_id,
	T1.ticker_sym	t1_ticker_sym,
	T1.tlr_intg_msg	t1_tlr_intg_msg,
	T1.tlr_intg_ret_cd	t1_tlr_intg_ret_cd,
	case when T1.trgt_impl_dt > '1949-01-01' then T1.trgt_impl_dt end t1_trgt_impl_date,
	T1.url	t1_url,
	T1.vat_regn_num	t1_vat_regn_num,
	T1.visit_frequency	t1_visit_frequency,
	T1.visit_period	t1_visit_period,
	T1.weekly_acv	t1_weekly_acv,
	T1.x_accnt_name_1	t1_x_accnt_name_1,
	T1.x_accnt_name_2	t1_x_accnt_name_2,
	T1.x_accnt_name_3	t1_x_accnt_name_3,
	T1.x_acc_salutation	t1_x_acc_salutation,	
	case 
		when regexp_replace(T1.x_add_fax_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.x_add_fax_num,'[^-0-9]',''),instr(regexp_replace(T1.x_add_fax_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.x_add_fax_num,'[^0-9]','')
		when regexp_replace(T1.x_add_fax_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.x_add_fax_num,'[^-0-9]',''),instr(regexp_replace(T1.x_add_fax_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.x_add_fax_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.x_add_fax_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.x_add_fax_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.x_add_fax_num,"[^+0-9]","")
		WHEN regexp_replace(T1.x_add_fax_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.x_add_fax_num,"[^+0-9]",""))
		when regexp_replace(T1.x_add_fax_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.x_add_fax_num,"[^+0-9]",""),2))
		when regexp_replace(T1.x_add_fax_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.x_add_fax_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.x_add_fax_num,"[^0-9]",""))>20 or length(regexp_replace(T1.x_add_fax_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.x_add_fax_num,'[^0-9]','')
	end t1_x_add_fax_number,
	T1.x_add_ph_num	t1_x_add_ph_num,
	T1.x_alphabet_flg	t1_x_alphabet_flag,
	T1.x_anagraphical_role	t1_x_anagraphical_role,
	T1.x_ape	t1_x_ape,
	T1.x_apet	t1_x_apet,
	T1.x_blocked_by_sf	t1_x_blocked_by_sf,
	T1.x_bmw	t1_x_bmw,
	T1.x_bmw_car_pool	t1_x_bmw_car_pool,
	T1.x_bmw_fs	t1_x_bmw_fs,
	T1.x_bmw_i_flg	t1_x_bmw_i_flag,
	T1.x_bmw_motorcycle	t1_x_bmw_motorcycle,
	T1.x_branche	t1_x_branche,
	T1.x_branche_subsidary	t1_x_branche_subsidary,
	T1.x_business_code	t1_x_business_code,
	T1.x_bus_part_id	t1_x_bus_part_id,
	T1.x_bus_type_code	t1_x_bus_type_code,
	T1.x_ccc_payment_flg	t1_x_ccc_payment_flag,
	T1.x_certified_partner_flg	t1_x_certified_partner_flag,
	T1.x_cham_com_nr	t1_x_cham_com_nr,
	T1.x_cl_code	t1_x_cl_code,
	T1.x_cl_name	t1_x_cl_name,
	T1.x_comm_cust	t1_x_comm_cust,
	T1.x_company_code	t1_x_company_code,
	T1.x_company_legal_name	t1_x_company_legal_name,
	T1.x_contracting_party_id	t1_x_contracting_party_id,
	T1.x_con_acc_switch_count	t1_x_con_acc_switch_count,
	T1.x_con_acc_switch_type	t1_x_con_acc_switch_type,
	T1.x_created_by_epa_transact	t1_x_created_by_epa_transact,
	T1.x_created_by_source	t1_x_created_by_source,
	T1.x_csn	t1_x_csn,
	T1.x_csn_orig	t1_x_csn_orig,
	T1.x_customer_card	t1_x_customer_card,
	T1.x_cust_class	t1_x_cust_class,
	T1.x_cust_num_fs	t1_x_cust_num_fs,
	T1.x_dealer_do_not_contact	t1_x_dealer_do_not_contact,
	T1.x_dfe_id	t1_x_dfe_id,
	case when T1.x_dlr_end_dt > '1949-01-01' then T1.x_dlr_end_dt end t1_x_dlr_end_date,
	T1.x_dlr_nickname	t1_x_dlr_nickname,
	T1.x_dlr_renamed_flg	t1_x_dlr_renamed_flag,
	T1.x_dn_contact_flg	t1_x_dn_contact_flag,
	T1.x_do_not_contact	t1_x_do_not_contact,
	case when T1.x_dpa_consents_date > '1949-01-01' then T1.x_dpa_consents_date end t1_x_dpa_consents_date,
	T1.x_dpa_email_consent	t1_x_dpa_email_consent,
	T1.x_dpa_email_consent_flg	t1_x_dpa_email_consent_flag,
	T1.x_dpa_mail_consent	t1_x_dpa_mail_consent,
	T1.x_dpa_mail_consent_flg	t1_x_dpa_mail_consent_flag,
	T1.x_dpa_phone_consent	t1_x_dpa_phone_consent,
	T1.x_dpa_phone_consent_flg	t1_x_dpa_phone_consent_flag,
	T1.x_dpa_product_cat	t1_x_dpa_product_cat,
	T1.x_dpa_sms_consent	t1_x_dpa_sms_consent,
	T1.x_dpa_sms_consent_flg	t1_x_dpa_sms_consent_flag,
	T1.x_dpa_update_source	t1_x_dpa_modify_source,	
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(T1.x_email_address,1,instr(T1.x_email_address,'@')),REGEXP_REPLACE(substr(T1.x_email_address,instr(T1.x_email_address,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') t1_x_email_address,
	T1.x_employee_range	t1_x_employee_range,
	T1.x_fiscal_num	t1_x_fiscal_number,
	T1.x_flash_note	t1_x_flash_note,
	T1.x_freelancer_flg	t1_x_freelancer_flag,
	T1.x_gk_status	t1_x_gk_status,
	T1.x_inactive_flg	t1_x_inactive_flag,
	T1.x_intl_dealer_id	t1_x_intl_dealer_id,
	T1.x_int_cust_flg	t1_x_int_cust_flag,
	T1.x_loc_dealer_id	t1_x_loc_dealer_id,
	T1.x_loc_sf_dealer_id	t1_x_loc_sf_dealer_id,
	case when T1.x_lst_main_addr_calc_dt > '1949-01-01' then T1.x_lst_main_addr_calc_dt end t1_x_lst_main_address_calc_date,
	T1.x_main_addr_upd_by_src	t1_x_main_address_modify_by_src,
	T1.x_main_addr_upd_src	t1_x_main_address_modify_src,	
	case 
		when regexp_replace(T1.x_main_cell_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.x_main_cell_num,'[^-0-9]',''),instr(regexp_replace(T1.x_main_cell_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.x_main_cell_num,'[^0-9]','')
		when regexp_replace(T1.x_main_cell_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.x_main_cell_num,'[^-0-9]',''),instr(regexp_replace(T1.x_main_cell_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.x_main_cell_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.x_main_cell_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.x_main_cell_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.x_main_cell_num,"[^+0-9]","")
		WHEN regexp_replace(T1.x_main_cell_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.x_main_cell_num,"[^+0-9]",""))
		when regexp_replace(T1.x_main_cell_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.x_main_cell_num,"[^+0-9]",""),2))
		when regexp_replace(T1.x_main_cell_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.x_main_cell_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.x_main_cell_num,"[^0-9]",""))>20 or length(regexp_replace(T1.x_main_cell_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.x_main_cell_num,'[^0-9]','')
	end t1_x_main_phone_number,
	T1.x_main_email_addr_low	t1_x_main_email_address_low,
	T1.x_main_outlet_id	t1_x_main_outlet_id,
	T1.x_major_cust	t1_x_major_cust,
	T1.x_make_pr_id	t1_x_make_pr_id,
	T1.x_master_cust	t1_x_master_cust,
	T1.x_master_number	t1_x_master_number,
	T1.x_master_outlet_num	t1_x_master_outlet_number,
	T1.x_merged_to_acc_id	t1_x_merged_to_acc_id,
	T1.x_mini	t1_x_mini,
	T1.x_mini_club	t1_x_mini_club,
	T1.x_ml_code	t1_x_ml_code,
	T1.x_ml_name	t1_x_ml_name,
	T1.x_motor_club	t1_x_motor_club,
	T1.x_name_low	company_name_low,
	T1.x_never_call	t1_x_never_call,
	T1.x_never_email	t1_x_never_email_address,
	T1.x_never_fax	t1_x_never_fax,
	T1.x_never_mail	t1_x_never_mail,
	T1.x_new_record_flg	t1_x_new_record_flag,
	T1.x_no_addr_fwd_to_dealer	t1_x_no_address_fwd_to_dealer,
	T1.x_no_after_sales_contact	t1_x_no_after_sales_contact,
	T1.x_no_fwd_to_dealer	t1_x_no_fwd_to_dealer,
	T1.x_no_select_for_segment	t1_x_no_select_for_segment,
	T1.x_other_makes	t1_x_other_makes,
	T1.x_outlet_name	t1_x_outlet_name,
	T1.x_outlet_num	t1_x_outlet_number,
	T1.x_outlet_titel	t1_x_outlet_titel,
	T1.x_outlet_type	t1_x_outlet_type,
	T1.x_outlet_type_cd	t1_x_outlet_type_cd,
	T1.x_ou_num_low	t1_x_ou_num_low,
	T1.x_owner_name	t1_x_owner_name,
	T1.x_owner_num	t1_x_owner_number,
	T1.x_partner_cd	t1_x_partner_cd,
	T1.x_payment_code	t1_x_payment_code,
	T1.x_portfolio_cd	t1_x_portfolio_cd,
	T1.x_portfolio_name	t1_x_portfolio_name,
	T1.x_pr_addr_id_former	t1_x_pr_address_id_former,
	T1.x_regio_alphabet_flg	t1_x_regio_alphabet_flag,
	T1.x_rel_type	t1_x_rel_type,
	T1.x_rel_type_code	t1_x_rel_type_code,
	T1.x_rfe_flg	t1_x_rfe_flag,
	T1.x_sales_channel	t1_x_sales_channel,
	T1.x_sales_channel_cd	t1_x_sales_channel_cd,
	T1.x_sf_customer_id2	t1_x_sf_customer_id2,
	T1.x_siret	t1_x_siret,
	T1.x_siret_main_business	t1_x_siret_main_business,
	T1.x_source	t1_x_source,
	T1.x_stop_advertisement	t1_x_stop_advertisement,
	T1.x_stop_bmw_service_card	t1_x_stop_bmw_service_card,
	T1.x_stop_dealer_kpp	t1_x_stop_dealer_kpp,
	T1.x_stop_fulfillment	t1_x_stop_fulfillment,
	T1.x_stop_magazine	t1_x_stop_magazine,
	T1.x_stop_market_research	t1_x_stop_market_research,
	T1.x_stop_mini_service_card	t1_x_stop_mini_service_card,
	T1.x_stop_moto_service_card	t1_x_stop_moto_service_card,
	T1.x_stop_newsletter	t1_x_stop_newsletter,
	T1.x_stop_sf_communication	t1_x_stop_sf_communication,
	T1.x_stop_survey	t1_x_stop_survey,
	T1.x_suppress_call	t1_x_suppress_call,
	T1.x_suppress_mail	t1_x_suppress_mail,
	T1.x_suppress_wcp	t1_x_suppress_wcp,
	T1.x_sup_in_market_num	t1_x_sup_in_market_number,
	T1.x_sup_in_part_num	t1_x_sup_in_part_number,
	T1.x_sys_id	t1_x_sys_id,
	T1.x_sys_id_switch	t1_x_sys_id_switch,
	T1.x_tax_obligatory_flg	t1_x_tax_obligatory_flag,
	T1.x_tefet	t1_x_tefet,
	T1.x_tefet_employee_num	t1_x_tefet_employee_number,
	T1.x_teledata_num	t1_x_teledata_number,
	T1.x_total_car_pool	t1_x_total_car_pool,
	T1.x_turnover_range	t1_x_turnover_range,
	T1.x_unpaid_level	t1_x_unpaid_level,
	T1.x_updated_by_source	t1_x_modified_by_source,
	T1.x_updated_source	t1_x_modified_source,
	T1.x_upd_by_epa_transact	t1_x_modify_by_epa_transact,
	T1.x_vp_class	t1_x_vp_class,
	T1.x_vp_num	t1_x_vp_num,
	T1.x_linked_account_id	t1_x_linked_account_id,
	T1.x_stop_online_survey_flg	null_1,						--need confirm
	T1.x_gc_id	null_2,										--need confirm
	T1.x_uc_id	null_3,										--need confirm
	T2.attrib_01	t2_attrib_01,
	T2.attrib_02	partner,
	T2.attrib_03	t2_attrib_03,
	T2.attrib_04	t2_attrib_04,
	T2.attrib_05	t2_attrib_05,
	T2.attrib_06	pix_receiver,
	T2.attrib_07	offered_service,
	T2.attrib_08	public_flag,
	T2.attrib_09	bankrupt_flag,
	T2.attrib_10	export_to_ecom_flag,
	T2.attrib_11	t2_attrib_11,
	case when T2.attrib_12 > '1949-01-01' then T2.attrib_12 end offline_from_date,
	case when T2.attrib_13 > '1949-01-01' then T2.attrib_13 end offline_to_date,
	T2.attrib_14	annual_revenue,
	T2.attrib_15	revenue_growth_rate,
	T2.attrib_16	number_employees,
	T2.attrib_17	visit_frequency,
	T2.attrib_18	t2_attrib_18,
	T2.attrib_19	t2_attrib_19,
	T2.attrib_20	number_bmw,
	T2.attrib_21	number_mini,
	T2.attrib_22	t2_attrib_22,
	T2.attrib_23	alphabet_fleet,
	T2.attrib_24	eu_fleet,
	T2.attrib_25	local_fleet,
	T2.attrib_26	t2_attrib_26,
	case when T2.attrib_27 > '1949-01-01' then T2.attrib_27 end foundation_date,
	T2.attrib_28	t2_attrib_28,
	T2.attrib_29	t2_attrib_29,
	T2.attrib_30	t2_attrib_30,
	case when T2.attrib_31 > '1949-01-01' then T2.attrib_31 end contract_start_date,
	case when T2.attrib_32 > '1949-01-01' and T2.attrib_32>T2.attrib_31 then T2.attrib_32 end contract_end_date,
	case when T2.attrib_33 > '1949-01-01' then T2.attrib_33 end registration_date,
	T2.attrib_34	dealer_sales_rep,
	T2.attrib_35	acc_brands_dealer_district,
	T2.attrib_36	t2_attrib_36,
	T2.attrib_37	sales_region,
	T2.attrib_38	brand,
	T2.attrib_39	leasing_fleet_owner,
	T2.attrib_40	brand_choice,
	T2.attrib_41	la_support,
	T2.attrib_42	origin,
	T2.attrib_43	al_key_accnt_mgr,
	T2.attrib_44	t2_attrib_44,
	T2.attrib_45	t2_attrib_45,
	T2.attrib_46	current_acquisition_method,
	T2.attrib_47	t2_attrib_47,
	T2.attrib_48	cs_accnt_mgr,
	T2.attrib_49	t2_attrib_49,
	T2.attrib_50	lease_company_1,
	T2.attrib_51	accnt_mgr_1,
	T2.attrib_52	car_policy,
	T2.attrib_53	duns_code,
	T2.attrib_54	t2_attrib_54,
	T2.attrib_56	t2_attrib_56,
	T2.attrib_57	number_suppliers,
	T2.attrib_58	t2_attrib_58,
	T2.attrib_59	accnt_number_employees,
	T2.attrib_60	bmw_percent,
	T2.attrib_61	mini_percent,
	T2.attrib_62	t2_attrib_62,
	T2.attrib_63	t2_attrib_63,
	T2.attrib_64	t2_attrib_64,
	T2.attrib_65	t2_attrib_65,
	T2.attrib_66	lease_company_2,
	T2.attrib_67	lease_company_3,
	T2.attrib_68	related_sales_category,
	T2.attrib_69	alphabet_status,
	T2.attrib_70	customer_type_sale,
	T2.attrib_71	quarter_accnt_approach,
	T2.attrib_72	customer_potential,
	T2.attrib_73	t2_attrib_73,
	T2.attrib_74	t2_attrib_74,
	T2.attrib_75	t2_attrib_75,
	T2.attrib_76	t2_attrib_76,
	T2.attrib_77	t2_attrib_77,
	T2.attrib_78	t2_attrib_78,
	T2.attrib_79	t2_attrib_79,
	T2.attrib_80	t2_attrib_80,
	T2.attrib_81	t2_attrib_81,
	T2.conflict_id	t2_conflict_id,
	case when T2.created > '1949-01-01' then T2.created end t2_create_date,
	T2.created_by	t2_create_user_id,
	T2.dcking_num	t2_dcking_num,
	T2.fri_1st_close_tm	t2_fri_1st_close_tm,
	T2.fri_1st_open_tm	t2_fri_1st_open_tm,
	T2.fri_2nd_close_tm	t2_fri_2nd_close_tm,
	T2.fri_2nd_open_tm	t2_fri_2nd_open_tm,
	case when T2.last_upd > '1949-01-01' then T2.last_upd end t2_modify_date,
	T2.last_upd_by	t2_modify_user_id,
	T2.modification_num	t2_modification_number,
	T2.mon_1st_close_tm	t2_mon_1st_close_tm,
	T2.mon_1st_open_tm	t2_mon_1st_open_tm,
	T2.mon_2nd_close_tm	t2_mon_2nd_close_tm,
	T2.mon_2nd_open_tm	t2_mon_2nd_open_tm,
	T2.par_row_id	t2_par_row_id,
	T2.row_id	t2_row_id,
	T2.sat_1st_close_tm	t2_sat_1st_close_tm,
	T2.sat_1st_open_tm	t2_sat_1st_open_tm,
	T2.sat_2nd_close_tm	t2_sat_2nd_close_tm,
	T2.sat_2nd_open_tm	t2_sat_2nd_open_tm,
	T2.sun_1st_close_tm	t2_sun_1st_close_tm,
	T2.sun_1st_open_tm	t2_sun_1st_open_tm,
	T2.sun_2nd_close_tm	t2_sun_2nd_close_tm,
	T2.sun_2nd_open_tm	t2_sun_2nd_open_tm,
	T2.thu_1st_close_tm	t2_thu_1st_close_tm,
	T2.thu_1st_open_tm	t2_thu_1st_open_tm,
	T2.thu_2nd_close_tm	t2_thu_2nd_close_tm,
	T2.thu_2nd_open_tm	t2_thu_2nd_open_tm,
	T2.tue_1st_close_tm	t2_tue_1st_close_tm,
	T2.tue_1st_open_tm	t2_tue_1st_open_tm,
	T2.tue_2nd_close_tm	t2_tue_2nd_close_tm,
	T2.tue_2nd_open_tm	t2_tue_2nd_open_tm,
	T2.wed_1st_close_tm	t2_wed_1st_close_tm,
	T2.wed_1st_open_tm	t2_wed_1st_open_tm,
	T2.wed_2nd_close_tm	t2_wed_2nd_close_tm,
	T2.wed_2nd_open_tm	t2_wed_2nd_open_tm,
	T2.x_agenon_mandatory_flg	t2_x_agenon_mandatory_flag,
	T2.x_blacklist_flg	t2_x_blacklist_flag,
	T2.x_budgetnon_mandatory_flg	t2_x_budgetnon_mandatory_flag,
	T2.x_contract_alive_flg	t2_x_contract_alive_flag,
	T2.x_dornon_mandatory_flg	t2_x_dornon_mandatory_flag,
	T2.x_parent_dealer_id	null_5,				--need confirm
	T2.x_integration_id	t2_x_integration_id
from source_carmen.a_carmen_s_org_ext T1
join source_carmen.a_carmen_S_ORG_EXT_X T2 
on t1.row_id = t2.par_row_id AND t1.prtnr_flg = 'N'
where t1.bu_id = '1-2N0H' and t1.cust_stat_cd not like '%Inactive'
)a)b
union all
select
	null	t1_aba_number,
	null	t1_accnt_flag,
	null	t1_accnt_pr_cmpt_id,
	null	t1_accnt_type_cd,
	null	t1_active_flag,
	null	t1_adl_status,
	null	t1_agency_flag,
	null	t1_alias_name,
	null	t1_alt_email_address,
	null	t1_alt_email_loc_cd,
	null	t1_ans_srvc_ph_num,
	null	t1_asgn_date,
	null	t1_asgn_usr_excld_flag,
	null	t1_asset_amt,
	null	t1_atm_count,
	null	t1_avail_credit_amt,
	null	t1_base_curcy_cd,
	null	t1_bill_pblshr_flag,
	null	t1_bo_cust_grp_cd,
	null	t1_bo_ordqry_end_date,
	null	t1_bo_ordqry_start_date,
	null	t1_branch_flag,
	null	t1_branch_type_cd,
	null	t1_briefing_layout,
	null	t1_buying_group_flag,
	null	t1_bu_id,
	null	t1_call_frequency,
	null	t1_cc_txnproc_ac_num,
	null	t1_cc_txnproc_vndr_id,
	null	t1_cg_cons_end_offset,
	null	t1_cg_cons_strtoffset,
	null	t1_cg_dedn_auth_flag,
	null	t1_cg_prmo_end_offset,
	null	t1_cg_prmo_strt_day,
	null	t1_cg_ship_end_offset,
	null	t1_cg_ship_strtoffset,
	null	t1_cg_svp_a_lock_flag,
	null	t1_cg_svp_lock_flag,
	null	t1_cg_svp_skip_flag,
	null	t1_cg_svp_status,
	null	t1_cg_svp_upper_lock,
	null	t1_channel_type,
	null	t1_chnl_annl_sales,
	null	t1_chnl_qtr_sales,
	null	t1_chnl_sales_growth,
	null	t1_client_flag,
	null	t1_close_date,
	null	t1_cl_site_flag,
	null	t1_cmpt_flag,
	null	t1_conflict_id,
	null	t1_contract_vis_flag,
	null	t1_corp_stock_symbol,
	null	t1_court_pay_flag,
	null	create_date,
	null	create_user_id,
	null	t1_creator_login,
	null	t1_credit_days,
	null	t1_credit_score,
	null	t1_cross_street,
	null	t1_curr_pri_lst_id,
	null	t1_curr_rate_lst_id,
	null	t1_cur_srv_address_id,
	null	t1_cur_yr_bk,
	null	t1_cur_yr_bk_curcy_cd,
	null	t1_cur_yr_bl,
	null	t1_cur_yr_bl_curcy_cd,
	null	t1_cust_end_date,
	null	t1_cust_since_date,
	T1.cust_stat_cd	t1_cust_stat_cd,
	null	t1_dcking_num,
	null	t1_dedup_dataclnsd_date,
	null	t1_dedup_key_modify_date,
	null	t1_dedup_last_mtch_date,
	null	t1_dedup_token,
	null	t1_dept_num,
	null	t1_desc_text,
	null	t1_dflt_ship_prio_cd,
	null	t1_disa_all_mails_flag,
	null	t1_disa_cleanse_flag,
	null	t1_dist_channel_cd,
	null	t1_division,
	null	t1_division_count,
	null	t1_divn_cd,
	null	t1_divn_type_cd,
	null	t1_dom_ult_duns_num,
	null	t1_duns_num,
	null	t1_eai_error_text,
	null	t1_eai_exprt_stat_cd,
	null	t1_eai_sync_date,
	null	email_address,
	null	t1_email_loc_cd,
	null	t1_emp_count,
	null	t1_enterprise_flag,
	null	t1_evt_hotel_std_rt,
	null	t1_evt_loc_cd,
	null	t1_evt_loc_flag,
	null	t1_exch_date,
	null	t1_exec_spnsr_pstn_id,
	null	t1_expertise_cd,
	null	t1_facility_flag,
	null	t1_fcst_org_flag,
	null	t1_fin_resp_con_id,
	null	t1_frd_owner_emp_id,
	null	t1_frght_terms_cd,
	null	t1_frght_terms_info,
	null	t1_ful_center_flag,
	null	t1_fund_elig_flag,
	null	t1_general_ledger,
	null	t1_glblult_duns_num,
	null	t1_good_standing_flag,
	null	t1_grwth_strtgy_desc,
	null	t1_gsa_flag,
	null	t1_hard_to_reach,
	null	t1_hist_sls_curcy_cd,
	null	t1_hist_sls_exch_date,
	null	t1_hist_sls_vol,
	null	t1_hshldhd_age,
	null	t1_hshldhd_gen_cd,
	null	t1_hshldhd_occ_cd,
	null	t1_hshld_ethn_cd,
	null	t1_hshld_inc,
	null	t1_hshld_kids,
	null	t1_hshld_loc_cd,
	null	t1_hshld_size,
	null	t1_impl_desc,
	null	t1_impl_stage_cd,
	null	t1_incl_flag,
	null	t1_integration_id,
	null	t1_int_org_flag,
	null	t1_invstr_flag,
	null	t1_lang_id,
	null	t1_last_call_date,
	null	t1_last_mgr_revw_date,
	null	t1_last_revw_mgr_id,
	case 
		when T1.created is not null and T1.last_upd BETWEEN T1.created and CURRENT_TIMESTAMP() then T1.created 
		when T1.created is null and T1.last_upd < CURRENT_TIMESTAMP() then T1.created
	end modify_date,
	null	modify_user_id,
	null	t1_latitude,
	null	t1_legal_form_cd,
	null	t1_loc,
	null	t1_location_level,
	null	t1_longitude,
	null	t1_loy_partner_cd,
	null	t1_main_email_address,
	null	t1_main_fax_phone_number,
	null	mobile_phone_number,
	null	t1_manager_name,
	null	t1_market_class_cd,
	null	t1_market_type_cd,
	null	t1_master_ou_id,
	null	t1_misc_flag,
	null	t1_modification_number,
	null	company_name,
	null	t1_name_1,
	null	t1_num_hshlds,
	null	t1_num_regs,
	null	t1_ou_number,
	null	t1_ou_number1,
	null	t1_ou_type_cd,
	null	t1_partner_flag,
	null	t1_par_bu_id,
	null	t1_par_divn_id,
	null	t1_par_duns_number,
	null	t1_par_ou_id,
	null	t1_par_row_id,
	null	t1_password,
	null	t1_payment_term_id,
	null	t1_pay_type_cd,
	null	t1_plan_group_flag,
	null	t1_po_crdchk_thrsh,
	null	t1_po_crdchk_thrsh_date,
	null	t1_po_pay_curcy_cd,
	null	t1_po_pay_exch_date,
	null	t1_po_pay_flag,
	null	t1_po_pay_max_amt,
	null	t1_pref_comm_meth_cd,
	null	t1_privacy_cd,
	null	t1_pri_grp_cd,
	null	t1_pri_yr_bk,
	null	t1_pri_yr_bk_curcy_cd,
	null	t1_pri_yr_bl,
	null	t1_pri_yr_bl_curcy_cd,
	null	t1_proced_flag,
	null	t1_prod_dist_cd,
	null	t1_prospect_flag,
	null	t1_prtnrshp_start_date,
	null	t1_prtnr_cert_cd,
	null	t1_prtnr_flag,
	null	t1_prtnr_org_int_id,
	null	t1_prtnr_publish_flag,
	null	t1_prtnr_sales_rank,
	null	t1_prtnr_type_cd,
	null	t1_pr_address_id,
	null	t1_pr_address_per_id,
	null	t1_pr_agree_id,
	null	t1_pr_bl_address_id,
	null	t1_pr_bl_ou_id,
	null	t1_pr_bl_per_id,
	null	t1_pr_competitor_id,
	null	t1_pr_con_id,
	null	t1_pr_co_mstr_id,
	null	t1_pr_crdate_area_id,
	null	t1_pr_discnt_id,
	null	t1_pr_eai_sls_area_id,
	null	t1_pr_emp_rel_id,
	null	t1_pr_emp_terr_id,
	null	t1_pr_fulfl_invloc_id,
	null	t1_pr_geo_id,
	null	t1_pr_implsvc_vndr_id,
	null	t1_pr_indust_id,
	null	t1_pr_logo_id,
	null	t1_pr_med_proc_id,
	null	t1_pr_mgr_postn_id,
	null	t1_pr_mkt_seg_id,
	null	t1_pr_org_trgt_mkt_id,
	null	t1_pr_ou_type_id,
	null	t1_pr_pay_ou_id,
	null	t1_pr_phone_id,
	null	t1_pr_postn_id,
	null	t1_pr_prfl_id,
	null	t1_pr_pri_lst_id,
	null	t1_pr_prod_id,
	null	t1_pr_prod_ln_id,
	null	t1_pr_prtnr_ou_id,
	null	t1_pr_prtnr_tier_id,
	null	t1_pr_prtnr_type_id,
	null	t1_pr_ptshp_mktseg_id,
	null	t1_pr_rep_asgn_type,
	null	t1_pr_rep_dnrm_flag,
	null	t1_pr_rep_manl_flag,
	null	t1_pr_rep_sys_flag,
	null	t1_pr_security_id,
	null	t1_pr_ship_address_id,
	null	t1_pr_ship_ou_id,
	null	t1_pr_ship_per_id,
	null	t1_pr_situ_id,
	null	t1_pr_specialty_id,
	null	t1_pr_spec_id,
	null	t1_pr_srv_agree_id,
	null	t1_pr_svc_postn_id,
	null	t1_pr_syn_id,
	null	t1_pr_terr_id,
	null	t1_pr_vehicle_id,
	null	t1_ptntl_sls_curcy_cd,
	null	t1_ptntl_sls_exch_date,
	null	t1_ptntl_sls_vol,
	null	t1_rating,
	null	t1_reference_cust_flag,
	null	t1_reference_start_date,
	null	t1_region,
	null	t1_region_id,
	null	t1_rel_id,
	null	t1_rel_name,
	null	t1_revenue_class_cd,
	null	t1_rlzd_roi_desc,
	null	t1_route,
	T1.row_id	company_id,
	null	t1_rplcd_wth_cmpt_flag,
	null	t1_rte_to_mkt_desc,
	null	t1_sales_emp_cnt,
	null	t1_sales_org_cd,
	null	t1_service_emp_cnt,
	null	t1_skip_po_crdchk_flag,
	null	t1_sls_dist_cd,
	null	t1_srv_provdr_flag,
	null	t1_staff,
	null	t1_status_cd,
	null	t1_stat_chg_date,
	null	t1_stat_reason_cd,
	null	t1_store_size,
	null	t1_suppress_share_flag,
	null	t1_supress_call_flag,
	null	t1_survey_type_cd,
	null	t1_svc_cvrg_stat_cd,
	null	t1_tax_exempt_flag,
	null	t1_tax_exempt_num,
	null	t1_tax_iden_num,
	null	t1_tax_list_id,
	null	t1_ticker_sym,
	null	t1_tlr_intg_msg,
	null	t1_tlr_intg_ret_cd,
	null	t1_trgt_impl_date,
	null	t1_url,
	null	t1_vat_regn_num,
	null	t1_visit_frequency,
	null	t1_visit_period,
	null	t1_weekly_acv,
	null	t1_x_accnt_name_1,
	null	t1_x_accnt_name_2,
	null	t1_x_accnt_name_3,
	null	t1_x_acc_salutation,
	null	t1_x_add_fax_number,
	null	t1_x_add_ph_num,
	null	t1_x_alphabet_flag,
	null	t1_x_anagraphical_role,
	null	t1_x_ape,
	null	t1_x_apet,
	null	t1_x_blocked_by_sf,
	null	t1_x_bmw,
	null	t1_x_bmw_car_pool,
	null	t1_x_bmw_fs,
	null	t1_x_bmw_i_flag,
	null	t1_x_bmw_motorcycle,
	null	t1_x_branche,
	null	t1_x_branche_subsidary,
	null	t1_x_business_code,
	null	t1_x_bus_part_id,
	null	t1_x_bus_type_code,
	null	t1_x_ccc_payment_flag,
	null	t1_x_certified_partner_flag,
	null	t1_x_cham_com_nr,
	null	t1_x_cl_code,
	null	t1_x_cl_name,
	null	t1_x_comm_cust,
	null	t1_x_company_code,
	null	t1_x_company_legal_name,
	null	t1_x_contracting_party_id,
	null	t1_x_con_acc_switch_count,
	null	t1_x_con_acc_switch_type,
	null	t1_x_created_by_epa_transact,
	null	t1_x_created_by_source,
	null	t1_x_csn,
	null	t1_x_csn_orig,
	null	t1_x_customer_card,
	null	t1_x_cust_class,
	null	t1_x_cust_num_fs,
	null	t1_x_dealer_do_not_contact,
	null	t1_x_dfe_id,
	null	t1_x_dlr_end_date,
	null	t1_x_dlr_nickname,
	null	t1_x_dlr_renamed_flag,
	null	t1_x_dn_contact_flag,
	null	t1_x_do_not_contact,
	null	t1_x_dpa_consents_date,
	null	t1_x_dpa_email_consent,
	null	t1_x_dpa_email_consent_flag,
	null	t1_x_dpa_mail_consent,
	null	t1_x_dpa_mail_consent_flag,
	null	t1_x_dpa_phone_consent,
	null	t1_x_dpa_phone_consent_flag,
	null	t1_x_dpa_product_cat,
	null	t1_x_dpa_sms_consent,
	null	t1_x_dpa_sms_consent_flag,
	null	t1_x_dpa_modify_source,
	null	t1_x_email_address,
	null	t1_x_employee_range,
	null	t1_x_fiscal_number,
	null	t1_x_flash_note,
	null	t1_x_freelancer_flag,
	null	t1_x_gk_status,
	null	t1_x_inactive_flag,
	null	t1_x_intl_dealer_id,
	null	t1_x_int_cust_flag,
	null	t1_x_loc_dealer_id,
	null	t1_x_loc_sf_dealer_id,
	null	t1_x_lst_main_address_calc_date,
	null	t1_x_main_address_modify_by_src,
	null	t1_x_main_address_modify_src,
	null	t1_x_main_phone_number,
	null	t1_x_main_email_address_low,
	null	t1_x_main_outlet_id,
	null	t1_x_major_cust,
	null	t1_x_make_pr_id,
	null	t1_x_master_cust,
	null	t1_x_master_number,
	null	t1_x_master_outlet_number,
	null	t1_x_merged_to_acc_id,
	null	t1_x_mini,
	null	t1_x_mini_club,
	null	t1_x_ml_code,
	null	t1_x_ml_name,
	null	t1_x_motor_club,
	null	company_name_low,
	null	t1_x_never_call,
	null	t1_x_never_email_address,
	null	t1_x_never_fax,
	null	t1_x_never_mail,
	null	t1_x_new_record_flag,
	null	t1_x_no_address_fwd_to_dealer,
	null	t1_x_no_after_sales_contact,
	null	t1_x_no_fwd_to_dealer,
	null	t1_x_no_select_for_segment,
	null	t1_x_other_makes,
	null	t1_x_outlet_name,
	null	t1_x_outlet_number,
	null	t1_x_outlet_titel,
	null	t1_x_outlet_type,
	null	t1_x_outlet_type_cd,
	null	t1_x_ou_num_low,
	null	t1_x_owner_name,
	null	t1_x_owner_number,
	null	t1_x_partner_cd,
	null	t1_x_payment_code,
	null	t1_x_portfolio_cd,
	null	t1_x_portfolio_name,
	null	t1_x_pr_address_id_former,
	null	t1_x_regio_alphabet_flag,
	null	t1_x_rel_type,
	null	t1_x_rel_type_code,
	null	t1_x_rfe_flag,
	null	t1_x_sales_channel,
	null	t1_x_sales_channel_cd,
	null	t1_x_sf_customer_id2,
	null	t1_x_siret,
	null	t1_x_siret_main_business,
	null	t1_x_source,
	null	t1_x_stop_advertisement,
	null	t1_x_stop_bmw_service_card,
	null	t1_x_stop_dealer_kpp,
	null	t1_x_stop_fulfillment,
	null	t1_x_stop_magazine,
	null	t1_x_stop_market_research,
	null	t1_x_stop_mini_service_card,
	null	t1_x_stop_moto_service_card,
	null	t1_x_stop_newsletter,
	null	t1_x_stop_sf_communication,
	null	t1_x_stop_survey,
	null	t1_x_suppress_call,
	null	t1_x_suppress_mail,
	null	t1_x_suppress_wcp,
	null	t1_x_sup_in_market_number,
	null	t1_x_sup_in_part_number,
	T1.x_sys_id	t1_x_sys_id,
	null	t1_x_sys_id_switch,
	null	t1_x_tax_obligatory_flag,
	null	t1_x_tefet,
	null	t1_x_tefet_employee_number,
	null	t1_x_teledata_number,
	null	t1_x_total_car_pool,
	null	t1_x_turnover_range,
	null	t1_x_unpaid_level,
	null	t1_x_modified_by_source,
	null	t1_x_modified_source,
	null	t1_x_modify_by_epa_transact,
	null	t1_x_vp_class,
	null	t1_x_vp_num,
	null	t1_x_linked_account_id,
	--null	null_1,						--need confirm
	--null	null_2,						--need confirm
	--null	null_3,						--need confirm
	null	t2_attrib_01,
	null	partner,
	null	t2_attrib_03,
	null	t2_attrib_04,
	null	t2_attrib_05,
	null	pix_receiver,
	null	offered_service,
	null	public_flag,
	null	bankrupt_flag,
	null	export_to_ecom_flag,
	null	t2_attrib_11,
	null	offline_from_date,
	null	offline_to_date,
	null	annual_revenue,
	null	revenue_growth_rate,
	null	number_employees,
	null	visit_frequency,
	null	t2_attrib_18,
	null	t2_attrib_19,
	null	number_bmw,
	null	number_mini,
	null	t2_attrib_22,
	null	alphabet_fleet,
	null	eu_fleet,
	null	local_fleet,
	null	t2_attrib_26,
	null	foundation_date,
	null	t2_attrib_28,
	null	t2_attrib_29,
	null	t2_attrib_30,
	null	contract_start_date,
	null	contract_end_date,
	null	registration_date,
	null	dealer_sales_rep,
	null	acc_brands_dealer_district,
	null	t2_attrib_36,
	null	sales_region,
	null	brand,
	null	leasing_fleet_owner,
	null	brand_choice,
	null	la_support,
	null	origin,
	null	al_key_accnt_mgr,
	null	t2_attrib_44,
	null	t2_attrib_45,
	null	current_acquisition_method,
	null	t2_attrib_47,
	null	cs_accnt_mgr,
	null	t2_attrib_49,
	null	lease_company_1,
	null	accnt_mgr_1,
	null	car_policy,
	null	duns_code,
	null	t2_attrib_54,
	null	t2_attrib_56,
	null	number_suppliers,
	null	t2_attrib_58,
	null	accnt_number_employees,
	null	bmw_percent,
	null	mini_percent,
	null	t2_attrib_62,
	null	t2_attrib_63,
	null	t2_attrib_64,
	null	t2_attrib_65,
	null	lease_company_2,
	null	lease_company_3,
	null	related_sales_category,
	null	alphabet_status,
	null	customer_type_sale,
	null	quarter_accnt_approach,
	null	customer_potential,
	null	t2_attrib_73,
	null	t2_attrib_74,
	null	t2_attrib_75,
	null	t2_attrib_76,
	null	t2_attrib_77,
	null	t2_attrib_78,
	null	t2_attrib_79,
	null	t2_attrib_80,
	null	t2_attrib_81,
	null	t2_conflict_id,
	null	t2_create_date,
	null	t2_create_user_id,
	null	t2_dcking_num,
	null	t2_fri_1st_close_tm,
	null	t2_fri_1st_open_tm,
	null	t2_fri_2nd_close_tm,
	null	t2_fri_2nd_open_tm,
	null	t2_modify_date,
	null	t2_modify_user_id,
	null	t2_modification_number,
	null	t2_mon_1st_close_tm,
	null	t2_mon_1st_open_tm,
	null	t2_mon_2nd_close_tm,
	null	t2_mon_2nd_open_tm,
	null	t2_par_row_id,
	null	t2_row_id,
	null	t2_sat_1st_close_tm,
	null	t2_sat_1st_open_tm,
	null	t2_sat_2nd_close_tm,
	null	t2_sat_2nd_open_tm,
	null	t2_sun_1st_close_tm,
	null	t2_sun_1st_open_tm,
	null	t2_sun_2nd_close_tm,
	null	t2_sun_2nd_open_tm,
	null	t2_thu_1st_close_tm,
	null	t2_thu_1st_open_tm,
	null	t2_thu_2nd_close_tm,
	null	t2_thu_2nd_open_tm,
	null	t2_tue_1st_close_tm,
	null	t2_tue_1st_open_tm,
	null	t2_tue_2nd_close_tm,
	null	t2_tue_2nd_open_tm,
	null	t2_wed_1st_close_tm,
	null	t2_wed_1st_open_tm,
	null	t2_wed_2nd_close_tm,
	null	t2_wed_2nd_open_tm,
	null	t2_x_agenon_mandatory_flag,
	null	t2_x_blacklist_flag,
	null	t2_x_budgetnon_mandatory_flag,
	null	t2_x_contract_alive_flag,
	null	t2_x_dornon_mandatory_flag,
	--null	null_5,			--need confirm
	null	t2_x_integration_id
from source_carmen.a_carmen_s_org_ext T1
join source_carmen.a_carmen_S_ORG_EXT_X T2 
on t1.row_id = t2.par_row_id AND t1.prtnr_flg = 'N'
where t1.bu_id = '1-2N0H' and t1.cust_stat_cd like '%Inactive';


--dwc_dim_cus_carmen_l_contact_cn_t clean
select
	t1_active_cti_cfg_id,
	t1_active_flg,
	t1_active_teleset_id,
	age,
	t1_agent_flag,
	t1_alias_name,
	case 
		when length(REGEXP_REPLACE(new_t1_alt_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_t1_alt_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_t1_alt_email_address,instr(new_t1_alt_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_t1_alt_email_address),1,instr(reverse(new_t1_alt_email_address),'.')-1))<2 then null
		when new_t1_alt_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_t1_alt_email_address,'\\.comcn$','.com.cn') 
		else new_t1_alt_email_address
	end t1_alt_email_address,
	t1_alt_email_loc_cd,
	t1_alt_phone_number,
	t1_annl_incm_curcy_cd,
	t1_annl_incm_exch_date,
	t1_area_id,
	t1_asgn_date,
	t1_asgn_excld_flag2,
	t1_asgn_required_flag2,
	t1_asgn_usr_excld_flag,
	t1_asst_phone_number,
	birth_date,
	t1_bu_id,
	t1_call_flag,
	t1_call_frequency,
	mobile_phone_number,
	t1_citizenship_cd,
	t1_comments,
	t1_complexion_cd,
	t1_conflict_id,
	t1_consumer_flag,
	t1_con_asst_name,
	t1_con_asst_per_id,
	t1_con_cd,
	t1_con_create_date,
	t1_con_exper_cd,
	t1_con_image_id,
	t1_con_influnc_id,
	t1_con_manager_name,
	t1_con_manager_per_id,
	t1_court_pay_flag,
	create_date,
	create_user_id,
	t1_creator_login,
	t1_credit_agency,
	t1_credit_score,
	t1_csn,
	t1_cust_end_date,
	t1_cust_since_date,
	t1_cust_stat_cd,
	t1_cust_value_cd,
	t1_dcking_num,
	t1_decision_type_cd,
	t1_dedup_dataclnsd_date,
	t1_dedup_key_modify_date,
	t1_dedup_last_mtch_date,
	t1_dedup_token,
	t1_degree,
	t1_dflt_order_proc_cd,
	t1_disa_cleanse_flag,
	t1_disp_img_auth_flag,
	case 
		when length(REGEXP_REPLACE(new_email_address,'[^@]',''))=0 or length(REGEXP_REPLACE(new_email_address,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(new_email_address,instr(new_email_address,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(new_email_address),1,instr(reverse(new_email_address),'.')-1))<2 then null
		when new_email_address rlike '\\.comcn$' then REGEXP_REPLACE(new_email_address,'\\.comcn$','.com.cn') 
		else new_email_address
	end email_address,
	t1_email_loc_cd,
	t1_email_sr_modify_flag,
	t1_emplmnt_stat_cd,
	t1_emp_flag,
	t1_emp_id,
	t1_emp_number,
	t1_emp_work_loc_name,
	t1_enterprise_flag,
	t1_eye_color,
	fax_phone_number,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else first_name_1 end first_name,
	t1_hair_color,
	t1_hard_to_reach,
	t1_height,
	t1_home_phone_number,
	t1_indust_id,
	t1_integration_id,
	t1_inves_start_date,
	t1_invstgtr_flag,
	t1_inv_org_st_date,
	job_title,
	t1_last_credit_date,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else last_name_1 end last_name,
	modify_date,
	modify_user_id,
	t1_latitude,
	t1_login,
	t1_longitude,
	maiden_name,
	marital_status,
	t1_med_spec_id,
	t1_member_flag,
	t1_mgmnt_flag,
	middle_name,
	t1_modification_number,
	t1_mother_maiden_name,
	nationality,
	t1_new_user_resp_name,
	nick_name,
	t1_occupation,
	t1_ok_to_sample_flag,
	t1_ou_id,
	t1_ou_mail_stop,
	t1_owner_login,
	t1_owner_per_id,
	t1_pager_company_id,
	t1_pager_num,
	t1_pager_phone_number,
	t1_pager_pin,
	t1_pager_type_cd,
	t1_par_row_id,
	t1_password,
	t1_person_uid,
	gender,
	per_title_suffix,
	t1_place_of_birth,
	t1_postn_cd,
	t1_po_pay_flag,
	t1_practice_type,
	t1_pref_comm_media_cd,
	t1_pref_comm_meth_cd,
	t1_pref_lang_id,
	t1_pref_locale_id,
	t1_pref_sale_dlr_id,
	t1_privacy_cd,
	t1_priv_flag,
	prospect_flag,
	t1_provider_flag,
	t1_pr_act_id,
	t1_pr_affl_id,
	t1_pr_alt_phone_number_id,
	t1_pr_asset_id,
	t1_pr_bl_per_address_id,
	t1_pr_client_ou_id,
	t1_pr_comm_lang_id,
	t1_pr_con_address_id,
	t1_pr_cst_accnt_id,
	t1_pr_cti_cfg_id,
	t1_pr_dept_ou_id,
	t1_pr_drvr_license_id,
	t1_pr_email_address_id,
	t1_pr_facility_id,
	t1_pr_grp_ou_id,
	t1_pr_held_postn_id,
	t1_pr_image_id,
	t1_pr_indust_id,
	t1_pr_mkt_seg_id,
	t1_pr_note_id,
	t1_pr_opty_id,
	t1_pr_ou_address_id,
	t1_pr_address_id,
	t1_pr_per_pay_prfl_id,
	t1_pr_phone_id,
	t1_pr_postn_id,
	t1_pr_prod_id,
	t1_pr_prod_ln_id,
	t1_pr_region_id,
	t1_pr_rep_dnrm_flag,
	t1_pr_rep_manl_flag,
	t1_pr_rep_sys_flag,
	t1_pr_resp_id,
	t1_pr_security_id,
	t1_pr_sh_per_address_id,
	t1_pr_specialty_id,
	t1_pr_state_lic_id,
	t1_pr_sync_user_id,
	t1_pr_terr_id,
	t1_pr_userrole_id,
	t1_ptshp_contact_flag,
	t1_ptshp_key_con_flag,
	t1_race,
	t1_rating,
	t1_region_id,
	t1_regl_stat_cd,
	t1_reliability_cd,
	t1_route,
	customer_id,
	t1_sec_answr,
	t1_sec_quest_cd,
	t1_seminar_invit_flag,
	t1_send_fin_flag,
	t1_send_news_flag,
	t1_send_promotes_flag,
	t1_send_survey_flag,
	t1_sex_mf,
	id_number,
	t1_speaker_flag,
	t1_src_id,
	t1_status_cd,
	t1_stat_reason_cd,
	t1_stock_portfolio,
	t1_sub_spec_id,
	t1_suppress_call_flag,
	t1_suppress_email_flag,
	t1_suppress_fax_flag,
	t1_suppress_mail_flag,
	t1_suspect_flag,
	t1_svc_branch_id,
	t1_timezone_id,
	t1_tmzone_cd,
	t1_weathr_loc_pref,
	t1_web_region_id,
	t1_weight,
	phone_number_business,
	t1_x_academic_title,
	t1_x_accnt_name,
	t1_x_addressess_flag,
	t1_x_agreement_date_written,
	t1_x_alias_name_low,
	t1_x_alphabet_date_contact_flag,
	t1_x_annual_income_type,
	t1_x_arf_flag,
	t1_x_aux_income_type,
	province,
	t1_x_blocked_by_sf,
	t1_x_bmw_assoc_status,
	t1_x_bmw_mag_count_modify_date,
	t1_x_bmw_i_flag,
	t1_x_branche,
	t1_x_branche_subsidary,
	t1_x_business_code,
	t1_x_closing,
	t1_x_cl_code,
	t1_x_cl_name,
	t1_x_comm_cust,
	t1_x_comm_salutation,
	t1_x_comm_salutation_inf,
	t1_x_company_code,
	t1_x_contracting_party_id,
	t1_x_cont_loc_id,
	t1_x_con_acc_switch_count,
	t1_x_con_acc_switch_type,
	t1_x_created_by_epa_transact,
	t1_x_created_by_source,
	t1_x_csn,
	t1_x_csn_orig,
	t1_x_cust_category,
	t1_x_cust_class,
	t1_x_cust_num_fs,
	t1_x_diplomat_flag,
	t1_x_doc_type,
	t1_x_dor_date,
	t1_x_dpa_consents_date,
	t1_x_dpa_email_consent,
	t1_x_dpa_email_consent_flag,
	t1_x_dpa_mail_consent,
	t1_x_dpa_mail_consent_flag,
	t1_x_dpa_phone_consent,
	t1_x_dpa_phone_consent_flag,
	t1_x_dpa_product_cat,
	t1_x_dpa_sms_consent,
	t1_x_dpa_sms_consent_flag,
	t1_x_dpa_modify_source,
	t1_x_emp_phone,
	t1_x_emp_postal_code,
	t1_x_exp_bu_id,
	t1_x_fiscal_num,
	t1_x_flash_note,
	t1_x_freelancer_flag,
	first_name_low,
	first_name_uk,
	t1_x_fullscore,
	t1_x_gk_status,
	t1_x_ids_email_address,
	t1_x_indep_profession_flag,
	t1_x_initials,
	t1_x_initials_low,
	t1_x_insertion,
	t1_x_insertion_proper,
	last_name_low,
	t1_x_lst_main_address_calc_date,
	t1_x_main_address_modify_by_src,
	t1_x_main_address_modify_src,
	t1_x_marketing_profiling_flag,
	t1_x_marketing_promotion_flag,
	t1_x_master_cust,
	t1_x_merged_to_con_id,
	t1_x_mini_club,
	t1_x_mini_mag_count_lst_modify,
	t1_x_mitarbeiterstatus,
	t1_x_ml_code,
	t1_x_ml_name,
	t1_x_motor_club,
	t1_x_mybmwsf_reg_flag,
	t1_x_mybmwsf_last_login_date,
	t1_x_mybmwsf_reg_date,
	t1_x_nationality,
	t1_x_no_conn_crm,
	t1_x_num_children,
	t1_x_num_per_hhold,
	t1_x_num_veh_hhold,
	passport_number,
	t1_x_payment_code,
	t1_x_pay_reminder,
	t1_x_pref_comm_sf,
	t1_x_prefix,
	t1_x_prefix2,
	t1_x_premium_flag,
	t1_x_press_flag,
	t1_x_professional_flag,
	t1_x_pr_agency_id,
	t1_x_pr_per_address_id_former,
	t1_x_pr_queue_id,
	t1_x_rel_type_cd,
	t1_x_residence_perm_type,
	t1_x_rfe_visibility,
	t1_x_sfi_dn_contact_flag,
	t1_x_siret_number,
	t1_x_sl_code,
	t1_x_sl_name,
	t1_x_stop_gcdm_modify_flag,
	t1_x_stop_mini_mag_flag,
	t1_x_stop_newsletter,
	t1_x_stop_newsl_chngd_date,
	t1_x_stop_newsl_chngd_src,
	t1_x_suppress_mms_flag,
	t1_x_suppress_sms_flag,
	t1_x_suppress_sms_sf,
	t1_x_sys_id,
	t1_x_sys_id_switch,
	t1_x_type_cd,
	t1_x_unpaid_level,
	t1_x_modified_by_source,
	t1_x_modified_source_date,
	t1_x_modify_by_epa_transact,
	t1_x_usage_note,
	t1_x_validity,
	t1_x_vat_category,
	t1_x_vat_number,
	t1_x_vip_flag,
	mobile_phone_number_business,
	fax_phone_number_business,
	t1_x_stop_online_survey_flag,
	t1_x_v_cust_deleted,
	--null_1,
	--null_2,
	--null_3,
	t1_x_linked_contact_id,
	t1_x_uc_id,
	t1_x_gc_id,
	t2_attrib_01,
	involved_person,
	--null_4,
	t2_attrib_03,
	t2_attrib_04,
	t2_attrib_05,
	t2_attrib_06,
	currency_cd,
	t2_attrib_08,
	bankrupt_flag,
	t2_attrib_10,
	new_record_flag,
	verbal_agreement_date,
	t2_attrib_13,
	t2_attrib_14,
	t2_attrib_15,
	t2_attrib_16,
	recvd_bmw_magazines,
	send_bmw_magazines,
	recvd_mini_magazines,
	send_mini_magazines,
	t2_attrib_21,
	alphabet_region,
	number_pers_in_household,
	side_income,
	income,
	t2_attrib_26,
	exchange_date,
	t2_attrib_28,
	customer_since_date,
	valid_until_date,
	resident_since_date,
	t2_attrib_32,
	t2_attrib_33,
	occupation,
	t2_attrib_35,
	outbound_email_address,
	driver_license,
	outbound_fax,
	outbound_phone,
	comms_blocked_by_bmw,
	stop_mini_magazine_flag,
	stop_motorcycl_magazine_flag,
	bmw_sf_flag,
	customer_card_flag,
	stop_magazine_flag,
	stop_wcp_flag,
	t2_attrib_47,
	industry,
	al_key_account_mgr,
	stop_survey,
	alphabet_status,
	customer_type_sale,
	gk_key_account_mgr,
	company_name,
	t2_attrib_55,
	kids_number,
	living_expenses,
	t2_attrib_58,
	t2_attrib_59,
	t2_attrib_60,
	t2_attrib_61,
	t2_attrib_62,
	t2_attrib_63,
	t2_attrib_64,
	t2_conflict_id,
	t2_create_date,
	t2_create_user_id,
	t2_dcking_number,
	t2_modify_date,
	t2_modify_user_id,
	t2_modification_number,
	t2_par_row_id,
	t2_row_id,
	t2_x_alphabet,
	t2_x_alphera,
	t2_x_bmw_mtrbk_lst_modify,
	t2_x_bmw_mtrbk_mag_recv,
	t2_x_bmw_mtrbk_mag_sent,
	t2_x_dealer_do_not_contact,
	t2_x_drv_lic_date,
	t2_x_no_address_fwd_to_dealer,
	x_no_address_fwd_to_dlr_last_u,
	t2_x_no_after_sales_contact,
	t2_x_no_fwd_to_dealer,
	t2_x_no_fwd_to_dealer_dea,
	t2_x_no_select_for_segment,
	t2_x_stop_advertisement,
	t2_x_stop_dealer_kpp,
	t2_x_stop_fulfillment,
	t2_x_stop_kpp,
	t2_x_stop_mailings,
	t2_x_stop_market_research,
	t2_x_stop_mini_service_card,
	t2_x_stop_moto_magazine,
	t2_x_stop_moto_service_card,
	t2_x_stop_sf_communication,
	t2_x_undeliverable_counter,
	t2_x_up_2_drive,
	t2_x_contact_sub_status
from (
select 
	a.*,
	case
        when t1_alt_email_address rlike '^\\..*\\.$' then regexp_replace(substr(t1_alt_email_address,2,length(t1_alt_email_address)-2),'[^A-Za-z0-9-.@_]','')
        when t1_alt_email_address rlike '^\\.' then regexp_replace(substr(t1_alt_email_address,2),'[^A-Za-z0-9-.@_]','')
        when t1_alt_email_address rlike '\\.$' then regexp_replace(substr(t1_alt_email_address,1,length(t1_alt_email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(t1_alt_email_address,'[^A-Za-z0-9-.@_]','') 
    end new_t1_alt_email_address,
    case
        when email_address rlike '^\\..*\\.$' then regexp_replace(substr(email_address,2,length(email_address)-2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '^\\.' then regexp_replace(substr(email_address,2),'[^A-Za-z0-9-.@_]','')
        when email_address rlike '\\.$' then regexp_replace(substr(email_address,1,length(email_address)-1),'[^A-Za-z0-9-.@_]','')
        else regexp_replace(email_address,'[^A-Za-z0-9-.@_]','') 
    end new_email_address,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(first_name,last_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(first_name as string),2)	else first_name end first_name_1,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(last_name,first_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(last_name as string),1,1) when  first_name is null then last_name end last_name_1
from(
select
	T1.active_cti_cfg_id	t1_active_cti_cfg_id,
	T1.active_flg	t1_active_flg,
	T1.active_teleset_id	t1_active_teleset_id,
	T1.age	age,
	T1.agent_flg	t1_agent_flag,
	T1.alias_name	t1_alias_name,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(T1.alt_email_addr,1,instr(T1.alt_email_addr,'@')),REGEXP_REPLACE(substr(T1.alt_email_addr,instr(T1.alt_email_addr,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') t1_alt_email_address,
	T1.alt_email_loc_cd	t1_alt_email_loc_cd,
	case 
		when regexp_replace(T1.alt_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.alt_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.alt_ph_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.alt_ph_num,'[^0-9]','')
		when regexp_replace(T1.alt_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.alt_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.alt_ph_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.alt_ph_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.alt_ph_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.alt_ph_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.alt_ph_num,"[^+0-9]","")
		WHEN regexp_replace(T1.alt_ph_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.alt_ph_num,"[^+0-9]",""))
		when regexp_replace(T1.alt_ph_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.alt_ph_num,"[^+0-9]",""),2))
		when regexp_replace(T1.alt_ph_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.alt_ph_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.alt_ph_num,"[^0-9]",""))>20 or length(regexp_replace(T1.alt_ph_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.alt_ph_num,'[^0-9]','')
	end t1_alt_phone_number,
	T1.annl_incm_curcy_cd	t1_annl_incm_curcy_cd,
	case when T1.annl_incm_exch_dt > '1949-01-01' then T1.annl_incm_exch_dt end t1_annl_incm_exch_date,
	T1.area_id	t1_area_id,
	case when T1.asgn_dt > '1949-01-01' then T1.asgn_dt end t1_asgn_date,
	T1.asgn_excld_flg2	t1_asgn_excld_flag2,
	T1.asgn_required_flg2	t1_asgn_required_flag2,
	T1.asgn_usr_excld_flg	t1_asgn_usr_excld_flag,
	T1.asst_ph_num	t1_asst_phone_number,
	case 
		when T1.birth_dt< '1900-01-01' then NULL
		when T1.birth_dt> t1.created or T1.birth_dt is not null or T1.birth_dt='' then substr(trim(T1.soc_security_num),7,8)
		else T1.birth_dt
	end birth_date,
	T1.bu_id	t1_bu_id,
	T1.call_flg	t1_call_flag,
	T1.call_frequency	t1_call_frequency,
	case	
		WHEN regexp_replace(T1.cell_ph_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.cell_ph_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.cell_ph_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.cell_ph_num,"[^+0-9]","")
		WHEN regexp_replace(T1.cell_ph_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.cell_ph_num,"[^+0-9]",""))
		when regexp_replace(T1.cell_ph_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.cell_ph_num,"[^+0-9]",""),2))
		when regexp_replace(T1.cell_ph_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.cell_ph_num,"[^+0-9]",""),2)
	end mobile_phone_number,
	T1.citizenship_cd	t1_citizenship_cd,
	T1.comments	t1_comments,
	T1.complexion_cd	t1_complexion_cd,
	T1.conflict_id	t1_conflict_id,
	T1.consumer_flg	t1_consumer_flag,
	T1.con_asst_name	t1_con_asst_name,
	T1.con_asst_per_id	t1_con_asst_per_id,
	T1.con_cd	t1_con_cd,
	case when T1.con_created_dt > '1949-01-01' then T1.con_created_dt end t1_con_create_date,
	T1.con_exper_cd	t1_con_exper_cd,
	T1.con_image_id	t1_con_image_id,
	T1.con_influnc_id	t1_con_influnc_id,
	T1.con_manager_name	t1_con_manager_name,
	T1.con_manager_per_id	t1_con_manager_per_id,
	T1.court_pay_flg	t1_court_pay_flag,
	case when T1.created > '1949-01-01' then T1.created end create_date,
	T1.created_by	create_user_id,
	T1.creator_login	t1_creator_login,
	T1.credit_agency	t1_credit_agency,
	T1.credit_score	t1_credit_score,
	T1.csn	t1_csn,
	case when T1.cust_end_dt > '1949-01-01' then T1.cust_end_dt end t1_cust_end_date,
	case when T1.cust_since_dt > '1949-01-01' then T1.cust_since_dt end t1_cust_since_date,
	T1.cust_stat_cd	t1_cust_stat_cd,
	T1.cust_value_cd	t1_cust_value_cd,
	T1.dcking_num	t1_dcking_num,
	T1.decision_type_cd	t1_decision_type_cd,
	case when T1.dedup_dataclnsd_dt > '1949-01-01' then T1.dedup_dataclnsd_dt end t1_dedup_dataclnsd_date,
	case when T1.dedup_key_upd_dt > '1949-01-01' then T1.dedup_key_upd_dt end t1_dedup_key_modify_date,
	case when T1.dedup_last_mtch_dt > '1949-01-01' then T1.dedup_last_mtch_dt end t1_dedup_last_mtch_date,
	T1.dedup_token	t1_dedup_token,
	T1.degree	t1_degree,
	T1.dflt_order_proc_cd	t1_dflt_order_proc_cd,
	T1.disa_cleanse_flg	t1_disa_cleanse_flag,
	T1.disp_img_auth_flg	t1_disp_img_auth_flag,
	REGEXP_REPLACE(REGEXP_REPLACE(concat(substr(T1.email_addr,1,instr(T1.email_addr,'@')),REGEXP_REPLACE(substr(T1.email_addr,instr(T1.email_addr,'@')+1),'@','')),'[.]{2,}','.'),"(@\\.)|(\\.@)",'@') email_address,
	T1.email_loc_cd	t1_email_loc_cd,
	T1.email_sr_upd_flg	t1_email_sr_modify_flag,
	T1.emplmnt_stat_cd	t1_emplmnt_stat_cd,
	T1.emp_flg	t1_emp_flag,
	T1.emp_id	t1_emp_id,
	T1.emp_num	t1_emp_number,
	T1.emp_work_loc_name	t1_emp_work_loc_name,
	T1.enterprise_flag	t1_enterprise_flag,
	T1.eye_color	t1_eye_color,
	case 
		when regexp_replace(T1.fax_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.fax_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.fax_ph_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.fax_ph_num,'[^0-9]','')
		when regexp_replace(T1.fax_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.fax_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.fax_ph_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.fax_ph_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.fax_ph_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.fax_ph_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.fax_ph_num,"[^+0-9]","")
		WHEN regexp_replace(T1.fax_ph_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.fax_ph_num,"[^+0-9]",""))
		when regexp_replace(T1.fax_ph_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.fax_ph_num,"[^+0-9]",""),2))
		when regexp_replace(T1.fax_ph_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.fax_ph_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.fax_ph_num,"[^0-9]",""))>20 or length(regexp_replace(T1.fax_ph_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.fax_ph_num,'[^0-9]','')
	end fax_phone_number,
	REGEXP_REPLACE(T1.fst_name,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	first_name,
	T1.hair_color	t1_hair_color,
	T1.hard_to_reach	t1_hard_to_reach,
	T1.height	t1_height,
	case 
		when regexp_replace(T1.home_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.home_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.home_ph_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.home_ph_num,'[^0-9]','')
		when regexp_replace(T1.home_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.home_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.home_ph_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.home_ph_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.home_ph_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.home_ph_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.home_ph_num,"[^+0-9]","")
		WHEN regexp_replace(T1.home_ph_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.home_ph_num,"[^+0-9]",""))
		when regexp_replace(T1.home_ph_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.home_ph_num,"[^+0-9]",""),2))
		when regexp_replace(T1.home_ph_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.home_ph_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.home_ph_num,"[^0-9]",""))>20 or length(regexp_replace(T1.home_ph_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.home_ph_num,'[^0-9]','')
	end t1_home_phone_number,
	T1.indust_id	t1_indust_id,
	T1.integration_id	t1_integration_id,
	case when T1.inves_start_dt > '1949-01-01' then T1.inves_start_dt end t1_inves_start_date,
	T1.invstgtr_flg	t1_invstgtr_flag,
	case when T1.inv_org_st_dt > '1949-01-01' then T1.inv_org_st_dt end t1_inv_org_st_date,
	T1.job_title	job_title,
	case when T1.last_credit_dt > '1949-01-01' then T1.last_credit_dt end t1_last_credit_date,
	REGEXP_REPLACE(T1.last_name,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") last_name,
	case 
		when t1.created is not null and t1.last_upd between t1.created and CURRENT_TIMESTAMP() then T1.last_upd
		when t1.created is null and t1.last_upd <=CURRENT_TIMESTAMP() then t1.last_upd
	end modify_date,
	T1.last_upd_by	modify_user_id,
	T1.latitude	t1_latitude,
	T1.login	t1_login,
	T1.longitude	t1_longitude,
	T1.maiden_name	maiden_name,
	T1.marital_stat_cd	marital_status,
	T1.med_spec_id	t1_med_spec_id,
	T1.member_flg	t1_member_flag,
	T1.mgmnt_flg	t1_mgmnt_flag,
	T1.mid_name	middle_name,
	T1.modification_num	t1_modification_number,
	T1.mother_maiden_name	t1_mother_maiden_name,
	T1.nationality	nationality,
	T1.new_user_resp_name	t1_new_user_resp_name,
	T1.nick_name	nick_name,
	T1.occupation	t1_occupation,
	T1.ok_to_sample_flg	t1_ok_to_sample_flag,
	T1.ou_id	t1_ou_id,
	T1.ou_mail_stop	t1_ou_mail_stop,
	T1.owner_login	t1_owner_login,
	T1.owner_per_id	t1_owner_per_id,
	T1.pager_company_id	t1_pager_company_id,
	T1.pager_num	t1_pager_num,
	T1.pager_ph_num	t1_pager_phone_number,
	T1.pager_pin	t1_pager_pin,
	T1.pager_type_cd	t1_pager_type_cd,
	T1.par_row_id	t1_par_row_id,
	T1.password	t1_password,
	T1.person_uid	t1_person_uid,
	case 
		when T1.per_title ='Company' then 'U'
		when T1.per_title in ('0','else') then 'U'
		when T1.per_title in ('1','先生','M 先生','M','MR.','M.','Male') then 'M'
		when T1.per_title in ('2','女士','F 女士','F 小姐','MS','Ms','MS.','Ms.','Female') then 'F'
		when T1.per_title is null or T1.per_title='' then null
		else 'U'
	end gender,
	T1.per_title_suffix	per_title_suffix,
	T1.place_of_birth	t1_place_of_birth,
	T1.postn_cd	t1_postn_cd,
	T1.po_pay_flg	t1_po_pay_flag,
	T1.practice_type	t1_practice_type,
	T1.pref_comm_media_cd	t1_pref_comm_media_cd,
	T1.pref_comm_meth_cd	t1_pref_comm_meth_cd,
	T1.pref_lang_id	t1_pref_lang_id,
	T1.pref_locale_id	t1_pref_locale_id,
	T1.pref_sale_dlr_id	t1_pref_sale_dlr_id,
	T1.privacy_cd	t1_privacy_cd,
	T1.priv_flg	t1_priv_flag,
	T1.prospect_flg	prospect_flag,
	T1.provider_flg	t1_provider_flag,
	T1.pr_act_id	t1_pr_act_id,
	T1.pr_affl_id	t1_pr_affl_id,
	T1.pr_alt_ph_num_id	t1_pr_alt_phone_number_id,
	T1.pr_asset_id	t1_pr_asset_id,
	T1.pr_bl_per_addr_id	t1_pr_bl_per_address_id,
	T1.pr_client_ou_id	t1_pr_client_ou_id,
	T1.pr_comm_lang_id	t1_pr_comm_lang_id,
	T1.pr_con_addr_id	t1_pr_con_address_id,
	T1.pr_cst_accnt_id	t1_pr_cst_accnt_id,
	T1.pr_cti_cfg_id	t1_pr_cti_cfg_id,
	T1.pr_dept_ou_id	t1_pr_dept_ou_id,
	T1.pr_drvr_license_id	t1_pr_drvr_license_id,
	T1.pr_email_addr_id	t1_pr_email_address_id,
	T1.pr_facility_id	t1_pr_facility_id,
	T1.pr_grp_ou_id	t1_pr_grp_ou_id,
	T1.pr_held_postn_id	t1_pr_held_postn_id,
	T1.pr_image_id	t1_pr_image_id,
	T1.pr_indust_id	t1_pr_indust_id,
	T1.pr_mkt_seg_id	t1_pr_mkt_seg_id,
	T1.pr_note_id	t1_pr_note_id,
	T1.pr_opty_id	t1_pr_opty_id,
	T1.pr_ou_addr_id	t1_pr_ou_address_id,
	T1.pr_per_addr_id	t1_pr_address_id,
	T1.pr_per_pay_prfl_id	t1_pr_per_pay_prfl_id,
	T1.pr_phone_id	t1_pr_phone_id,
	T1.pr_postn_id	t1_pr_postn_id,
	T1.pr_prod_id	t1_pr_prod_id,
	T1.pr_prod_ln_id	t1_pr_prod_ln_id,
	T1.pr_region_id	t1_pr_region_id,
	T1.pr_rep_dnrm_flg	t1_pr_rep_dnrm_flag,
	T1.pr_rep_manl_flg	t1_pr_rep_manl_flag,
	T1.pr_rep_sys_flg	t1_pr_rep_sys_flag,
	T1.pr_resp_id	t1_pr_resp_id,
	T1.pr_security_id	t1_pr_security_id,
	T1.pr_sh_per_addr_id	t1_pr_sh_per_address_id,
	T1.pr_specialty_id	t1_pr_specialty_id,
	T1.pr_state_lic_id	t1_pr_state_lic_id,
	T1.pr_sync_user_id	t1_pr_sync_user_id,
	T1.pr_terr_id	t1_pr_terr_id,
	T1.pr_userrole_id	t1_pr_userrole_id,
	T1.ptshp_contact_flg	t1_ptshp_contact_flag,
	T1.ptshp_key_con_flg	t1_ptshp_key_con_flag,
	T1.race	t1_race,
	T1.rating	t1_rating,
	T1.region_id	t1_region_id,
	T1.regl_stat_cd	t1_regl_stat_cd,
	T1.reliability_cd	t1_reliability_cd,
	T1.route	t1_route,
	T1.row_id	customer_id,
	T1.sec_answr	t1_sec_answr,
	T1.sec_quest_cd	t1_sec_quest_cd,
	T1.seminar_invit_flg	t1_seminar_invit_flag,
	T1.send_fin_flg	t1_send_fin_flag,
	T1.send_news_flg	t1_send_news_flag,
	T1.send_promotes_flg	t1_send_promotes_flag,
	T1.send_survey_flg	t1_send_survey_flag,
	T1.sex_mf	t1_sex_mf,
	case 
		when trim(T1.soc_security_num) rlike '^\\d{17}[0-9Xx]$' and concat(substr(trim(T1.soc_security_num),7,4),'-',substr(trim(T1.soc_security_num),11,2),'-',substr(trim(T1.soc_security_num),13,2)) between '1900-01-01' and CURRENT_DATE() 
		then concat(substr(trim(T1.soc_security_num),1,17),upper(substr(trim(T1.soc_security_num),-1,1)))
	end id_number,
	T1.speaker_flg	t1_speaker_flag,
	T1.src_id	t1_src_id,
	T1.status_cd	t1_status_cd,
	T1.stat_reason_cd	t1_stat_reason_cd,
	T1.stock_portfolio	t1_stock_portfolio,
	T1.sub_spec_id	t1_sub_spec_id,
	T1.suppress_call_flg	t1_suppress_call_flag,
	T1.suppress_email_flg	t1_suppress_email_flag,
	T1.suppress_fax_flg	t1_suppress_fax_flag,
	T1.suppress_mail_flg	t1_suppress_mail_flag,
	T1.suspect_flg	t1_suspect_flag,
	T1.svc_branch_id	t1_svc_branch_id,
	T1.timezone_id	t1_timezone_id,
	T1.tmzone_cd	t1_tmzone_cd,
	T1.weathr_loc_pref	t1_weathr_loc_pref,
	T1.web_region_id	t1_web_region_id,
	T1.weight	t1_weight,
	case 
		when regexp_replace(T1.work_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.work_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.work_ph_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.work_ph_num,'[^0-9]','')
		when regexp_replace(T1.work_ph_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.work_ph_num,'[^-0-9]',''),instr(regexp_replace(T1.work_ph_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.work_ph_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.work_ph_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.work_ph_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.work_ph_num,"[^+0-9]","")
		WHEN regexp_replace(T1.work_ph_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.work_ph_num,"[^+0-9]",""))
		when regexp_replace(T1.work_ph_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.work_ph_num,"[^+0-9]",""),2))
		when regexp_replace(T1.work_ph_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.work_ph_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.work_ph_num,"[^0-9]",""))>20 or length(regexp_replace(T1.work_ph_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.work_ph_num,'[^0-9]','')
	end phone_number_business,	
	T1.x_academic_title	t1_x_academic_title,
	T1.x_accnt_name	t1_x_accnt_name,
	T1.x_address_flg	t1_x_addressess_flag,
	T1.x_agreement_date_written	t1_x_agreement_date_written,
	T1.x_alias_name_low	t1_x_alias_name_low,
	T1.x_alphabet_dt_contact_flg	t1_x_alphabet_date_contact_flag,
	T1.x_annual_income_type	t1_x_annual_income_type,
	T1.x_arf_flg	t1_x_arf_flag,
	T1.x_aux_income_type	t1_x_aux_income_type,
	T1.x_birth_province	province,
	T1.x_blocked_by_sf	t1_x_blocked_by_sf,
	T1.x_bmw_assoc_status	t1_x_bmw_assoc_status,
	T1.x_bmw_mag_count_lst_upd	t1_x_bmw_mag_count_modify_date,
	T1.x_bmw_i_flg	t1_x_bmw_i_flag,
	T1.x_branche	t1_x_branche,
	T1.x_branche_subsidary	t1_x_branche_subsidary,
	T1.x_business_code	t1_x_business_code,
	T1.x_closing	t1_x_closing,
	T1.x_cl_code	t1_x_cl_code,
	T1.x_cl_name	t1_x_cl_name,
	T1.x_comm_cust	t1_x_comm_cust,
	T1.x_comm_salutation	t1_x_comm_salutation,
	T1.x_comm_salutation_inf	t1_x_comm_salutation_inf,
	T1.x_company_code	t1_x_company_code,
	T1.x_contracting_party_id	t1_x_contracting_party_id,
	T1.x_cont_loc_id	t1_x_cont_loc_id,
	T1.x_con_acc_switch_count	t1_x_con_acc_switch_count,
	T1.x_con_acc_switch_type	t1_x_con_acc_switch_type,
	T1.x_created_by_epa_transact	t1_x_created_by_epa_transact,
	T1.x_created_by_source	t1_x_created_by_source,
	T1.x_csn	t1_x_csn,
	T1.x_csn_orig	t1_x_csn_orig,
	T1.x_cust_category	t1_x_cust_category,
	T1.x_cust_class	t1_x_cust_class,
	T1.x_cust_num_fs	t1_x_cust_num_fs,
	T1.x_diplomat_flg	t1_x_diplomat_flag,
	T1.x_doc_type	t1_x_doc_type,
	case when T1.x_dor_dt > '1949-01-01' then T1.x_dor_dt end t1_x_dor_date,
	case when T1.x_dpa_consents_date > '1949-01-01' then T1.x_dpa_consents_date end t1_x_dpa_consents_date,
	T1.x_dpa_email_consent	t1_x_dpa_email_consent,
	T1.x_dpa_email_consent_flg	t1_x_dpa_email_consent_flag,
	T1.x_dpa_mail_consent	t1_x_dpa_mail_consent,
	T1.x_dpa_mail_consent_flg	t1_x_dpa_mail_consent_flag,
	T1.x_dpa_phone_consent	t1_x_dpa_phone_consent,
	T1.x_dpa_phone_consent_flg	t1_x_dpa_phone_consent_flag,
	T1.x_dpa_product_cat	t1_x_dpa_product_cat,
	T1.x_dpa_sms_consent	t1_x_dpa_sms_consent,
	T1.x_dpa_sms_consent_flg	t1_x_dpa_sms_consent_flag,
	T1.x_dpa_update_source	t1_x_dpa_modify_source,
	T1.x_emp_phone	t1_x_emp_phone,
	T1.x_emp_postal_code	t1_x_emp_postal_code,
	T1.x_exp_bu_id	t1_x_exp_bu_id,
	T1.x_fiscal_num	t1_x_fiscal_num,
	T1.x_flash_note	t1_x_flash_note,
	T1.x_freelancer_flg	t1_x_freelancer_flag,
	T1.x_fst_name_low	first_name_low,
	T1.x_fst_name_uk	first_name_uk,
	T1.x_fullscore	t1_x_fullscore,
	T1.x_gk_status	t1_x_gk_status,
	T1.x_ids_email	t1_x_ids_email_address,
	T1.x_indep_profession_flg	t1_x_indep_profession_flag,
	T1.x_initials	t1_x_initials,
	T1.x_initials_low	t1_x_initials_low,
	T1.x_insertion	t1_x_insertion,
	T1.x_insertion_proper	t1_x_insertion_proper,
	T1.x_last_name_low	last_name_low,
	case when T1.x_lst_main_addr_calc_dt > '1949-01-01' then T1.x_lst_main_addr_calc_dt end t1_x_lst_main_address_calc_date,
	T1.x_main_addr_upd_by_src	t1_x_main_address_modify_by_src,
	T1.x_main_addr_upd_src	t1_x_main_address_modify_src,
	T1.x_marketing_profiling_flg	t1_x_marketing_profiling_flag,
	T1.x_marketing_promotion_flg	t1_x_marketing_promotion_flag,
	T1.x_master_cust	t1_x_master_cust,
	T1.x_merged_to_con_id	t1_x_merged_to_con_id,
	T1.x_mini_club	t1_x_mini_club,
	T1.x_mini_mag_count_lst_upd	t1_x_mini_mag_count_lst_modify,
	T1.x_mitarbeiterstatus	t1_x_mitarbeiterstatus,
	T1.x_ml_code	t1_x_ml_code,
	T1.x_ml_name	t1_x_ml_name,
	T1.x_motor_club	t1_x_motor_club,
	T1.x_mybmwsf_reg_flg	t1_x_mybmwsf_reg_flag,
	case when T1.x_mybmwsf_last_login_dt > '1949-01-01' then T1.x_mybmwsf_last_login_dt end t1_x_mybmwsf_last_login_date,
	case when T1.x_mybmwsf_reg_date > '1949-01-01' then T1.x_mybmwsf_reg_date end t1_x_mybmwsf_reg_date,
	T1.x_nationality	t1_x_nationality,
	T1.x_no_conn_crm	t1_x_no_conn_crm,
	T1.x_num_children	t1_x_num_children,
	T1.x_num_per_hhold	t1_x_num_per_hhold,
	T1.x_num_veh_hhold	t1_x_num_veh_hhold,
	T1.x_passport_number	passport_number,
	T1.x_payment_code	t1_x_payment_code,
	T1.x_pay_reminder	t1_x_pay_reminder,
	T1.x_pref_comm_sf	t1_x_pref_comm_sf,
	T1.x_prefix	t1_x_prefix,
	T1.x_prefix2	t1_x_prefix2,
	T1.x_premium_flg	t1_x_premium_flag,
	T1.x_press_flg	t1_x_press_flag,
	T1.x_professional_flag	t1_x_professional_flag,
	T1.x_pr_agency_id	t1_x_pr_agency_id,
	T1.x_pr_per_addr_id_former	t1_x_pr_per_address_id_former,
	T1.x_pr_queue_id	t1_x_pr_queue_id,
	T1.x_rel_type_cd	t1_x_rel_type_cd,
	T1.x_residence_perm_type	t1_x_residence_perm_type,
	T1.x_rfe_visibility	t1_x_rfe_visibility,
	T1.x_sfi_dn_contact_flg	t1_x_sfi_dn_contact_flag,
	T1.x_siret_number	t1_x_siret_number,
	T1.x_sl_code	t1_x_sl_code,
	T1.x_sl_name	t1_x_sl_name,
	T1.x_stop_gcdm_upd_flg	t1_x_stop_gcdm_modify_flag,
	T1.x_stop_mini_mag_flg	t1_x_stop_mini_mag_flag,
	T1.x_stop_newsletter	t1_x_stop_newsletter,
	case when T1.x_stop_newsl_chngd_dt > '1949-01-01' then T1.x_stop_newsl_chngd_dt end t1_x_stop_newsl_chngd_date,
	T1.x_stop_newsl_chngd_src	t1_x_stop_newsl_chngd_src,
	T1.x_suppress_mms_flg	t1_x_suppress_mms_flag,
	T1.x_suppress_sms_flg	t1_x_suppress_sms_flag,
	T1.x_suppress_sms_sf	t1_x_suppress_sms_sf,
	T1.x_sys_id	t1_x_sys_id,
	T1.x_sys_id_switch	t1_x_sys_id_switch,
	T1.x_type_cd	t1_x_type_cd,
	T1.x_unpaid_level	t1_x_unpaid_level,
	T1.x_updated_by_source	t1_x_modified_by_source,
	case when T1.x_updated_source > '1949-01-01' then T1.x_updated_source end t1_x_modified_source_date,
	T1.x_upd_by_epa_transact	t1_x_modify_by_epa_transact,
	T1.x_usage_note	t1_x_usage_note,
	T1.x_validity	t1_x_validity,
	T1.x_vat_category	t1_x_vat_category,
	T1.x_vat_number	t1_x_vat_number,
	T1.x_vip_flg	t1_x_vip_flag,
	case	
		WHEN regexp_replace(T1.x_work_cell_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.x_work_cell_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.x_work_cell_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.x_work_cell_num,"[^+0-9]","")
		WHEN regexp_replace(T1.x_work_cell_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.x_work_cell_num,"[^+0-9]",""))
		when regexp_replace(T1.x_work_cell_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.x_work_cell_num,"[^+0-9]",""),2))
		when regexp_replace(T1.x_work_cell_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.x_work_cell_num,"[^+0-9]",""),2)
	end mobile_phone_number_business,
	case 
		when regexp_replace(T1.x_work_fax_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.x_work_fax_num,'[^-0-9]',''),instr(regexp_replace(T1.x_work_fax_num,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(T1.x_work_fax_num,'[^0-9]','')
		when regexp_replace(T1.x_work_fax_num,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(T1.x_work_fax_num,'[^-0-9]',''),instr(regexp_replace(T1.x_work_fax_num,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(T1.x_work_fax_num,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(T1.x_work_fax_num,"[^+0-9]",""),'+','')
		WHEN regexp_replace(T1.x_work_fax_num,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(T1.x_work_fax_num,"[^+0-9]","")
		WHEN regexp_replace(T1.x_work_fax_num,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(T1.x_work_fax_num,"[^+0-9]",""))
		when regexp_replace(T1.x_work_fax_num,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(T1.x_work_fax_num,"[^+0-9]",""),2))
		when regexp_replace(T1.x_work_fax_num,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(T1.x_work_fax_num,"[^+0-9]",""),2)
		when length(regexp_replace(T1.x_work_fax_num,"[^0-9]",""))>20 or length(regexp_replace(T1.x_work_fax_num,"[^0-9]",""))<7 then null
		else regexp_replace(T1.x_work_fax_num,'[^0-9]','')
	end fax_phone_number_business,
	T1.x_stop_online_survey_flg	t1_x_stop_online_survey_flag,
	T1.x_v_cust_deleted	t1_x_v_cust_deleted,
	--T1.annl_incm_amt	null_1,
	--T1.x_mybmwsf_email_addr	null_2,
	--T1.fday	null_3,						
	T1.x_linked_contact_id	t1_x_linked_contact_id,
	T1.x_uc_id	t1_x_uc_id,
	T1.x_gc_id	t1_x_gc_id,
	T2.attrib_01	t2_attrib_01,
	T2.attrib_02	involved_person,
	--T2.fday	null_4,
	T2.attrib_03	t2_attrib_03,
	T2.attrib_04	t2_attrib_04,
	T2.attrib_05	t2_attrib_05,
	T2.attrib_06	t2_attrib_06,
	T2.attrib_07	currency_cd,
	T2.attrib_08	t2_attrib_08,
	T2.attrib_09	bankrupt_flag,
	T2.attrib_10	t2_attrib_10,
	T2.attrib_11	new_record_flag,
	case when T2.attrib_12 > '1949-01-01' then T2.attrib_12 end verbal_agreement_date,
	T2.attrib_13	t2_attrib_13,
	T2.attrib_14	t2_attrib_14,
	T2.attrib_15	t2_attrib_15,
	T2.attrib_16	t2_attrib_16,
	T2.attrib_17	recvd_bmw_magazines,
	T2.attrib_18	send_bmw_magazines,
	T2.attrib_19	recvd_mini_magazines,
	T2.attrib_20	send_mini_magazines,
	T2.attrib_21	t2_attrib_21,
	T2.attrib_22	alphabet_region,
	T2.attrib_23	number_pers_in_household,
	T2.attrib_24	side_income,
	T2.attrib_25	income,
	T2.attrib_26	t2_attrib_26,
	case when T2.attrib_27 > '1949-01-01' then T2.attrib_27 end exchange_date,
	T2.attrib_28	t2_attrib_28,
	case when T2.attrib_29 > '1949-01-01' then T2.attrib_29 end customer_since_date,
	case when T2.attrib_30 > '1949-01-01' then T2.attrib_30 end valid_until_date,
	case when T2.attrib_31 > '1949-01-01' then T2.attrib_31 end resident_since_date,
	T2.attrib_32	t2_attrib_32,
	T2.attrib_33	t2_attrib_33,
	T2.attrib_34	occupation,
	T2.attrib_35	t2_attrib_35,
	T2.attrib_36	outbound_email_address,
	T2.attrib_37	driver_license,
	T2.attrib_38	outbound_fax,
	T2.attrib_39	outbound_phone,
	T2.attrib_40	comms_blocked_by_bmw,
	T2.attrib_41	stop_mini_magazine_flag,
	T2.attrib_42	stop_motorcycl_magazine_flag,
	T2.attrib_43	bmw_sf_flag,
	T2.attrib_44	customer_card_flag,
	T2.attrib_45	stop_magazine_flag,
	T2.attrib_46	stop_wcp_flag,
	T2.attrib_47	t2_attrib_47,
	T2.attrib_48	industry,
	T2.attrib_49	al_key_account_mgr,
	T2.attrib_50	stop_survey,
	T2.attrib_51	alphabet_status,
	T2.attrib_52	customer_type_sale,
	T2.attrib_53	gk_key_account_mgr,
	T2.attrib_54	company_name,
	T2.attrib_55	t2_attrib_55,
	T2.attrib_56	kids_number,
	T2.attrib_57	living_expenses,
	T2.attrib_58	t2_attrib_58,
	T2.attrib_59	t2_attrib_59,
	T2.attrib_60	t2_attrib_60,
	T2.attrib_61	t2_attrib_61,
	T2.attrib_62	t2_attrib_62,
	T2.attrib_63	t2_attrib_63,
	T2.attrib_64	t2_attrib_64,
	T2.conflict_id	t2_conflict_id,
	case when T2.created > '1949-01-01' then T2.created end t2_create_date,
	T2.created_by	t2_create_user_id,
	T2.dcking_num	t2_dcking_number,
	case when T2.last_upd > '1949-01-01' then T2.last_upd end t2_modify_date,
	T2.last_upd_by	t2_modify_user_id,
	T2.modification_num	t2_modification_number,
	T2.par_row_id	t2_par_row_id,
	T2.row_id	t2_row_id,
	T2.x_alphabet	t2_x_alphabet,
	T2.x_alphera	t2_x_alphera,
	T2.x_bmw_mtrbk_lst_upd	t2_x_bmw_mtrbk_lst_modify,
	T2.x_bmw_mtrbk_mag_recv	t2_x_bmw_mtrbk_mag_recv,
	T2.x_bmw_mtrbk_mag_sent	t2_x_bmw_mtrbk_mag_sent,
	T2.x_dealer_do_not_contact	t2_x_dealer_do_not_contact,
	case when T2.x_drv_lic_dt > '1949-01-01' then T2.x_drv_lic_dt end t2_x_drv_lic_date,
	T2.x_no_addr_fwd_to_dealer	t2_x_no_address_fwd_to_dealer,
	T2.x_no_addr_fwd_to_dlr_last_upd	x_no_address_fwd_to_dlr_last_u,
	T2.x_no_after_sales_contact	t2_x_no_after_sales_contact,
	T2.x_no_fwd_to_dealer	t2_x_no_fwd_to_dealer,
	T2.x_no_fwd_to_dealer_dea	t2_x_no_fwd_to_dealer_dea,
	T2.x_no_select_for_segment	t2_x_no_select_for_segment,
	T2.x_stop_advertisement	t2_x_stop_advertisement,
	T2.x_stop_dealer_kpp	t2_x_stop_dealer_kpp,
	T2.x_stop_fulfillment	t2_x_stop_fulfillment,
	T2.x_stop_kpp	t2_x_stop_kpp,
	T2.x_stop_mailings	t2_x_stop_mailings,
	T2.x_stop_market_research	t2_x_stop_market_research,
	T2.x_stop_mini_service_card	t2_x_stop_mini_service_card,
	T2.x_stop_moto_magazine	t2_x_stop_moto_magazine,
	T2.x_stop_moto_service_card	t2_x_stop_moto_service_card,
	T2.x_stop_sf_communication	t2_x_stop_sf_communication,
	T2.x_undeliverable_counter	t2_x_undeliverable_counter,
	T2.x_up_2_drive	t2_x_up_2_drive,
	T2.x_contact_sub_status	t2_x_contact_sub_status
from source_carmen.a_carmen_s_contact T1
left join source_carmen.a_carmen_S_CONTACT_X T2
on t1.row_id = t2.par_row_id
join source_carmen.a_carmen_s_bu b 
on t1.BU_ID = b.row_id
Where b.name = 'BMW-CN' and t1.emp_flg <> 'Y'
and t1.cust_stat_cd not like '%Inactive')a)b
union all
select 
	null	t1_active_cti_cfg_id,
	null	t1_active_flg,
	null	t1_active_teleset_id,
	null	age,
	null	t1_agent_flag,
	null	t1_alias_name,
	null	t1_alt_email_address,
	null	t1_alt_email_loc_cd,
	null	t1_alt_phone_number,
	null	t1_annl_incm_curcy_cd,
	null	t1_annl_incm_exch_date,
	null	t1_area_id,
	null	t1_asgn_date,
	null	t1_asgn_excld_flag2,
	null	t1_asgn_required_flag2,
	null	t1_asgn_usr_excld_flag,
	null	t1_asst_phone_number,
	null	birth_date,
	null	t1_bu_id,
	null	t1_call_flag,
	null	t1_call_frequency,
	null	mobile_phone_number,
	null	t1_citizenship_cd,
	null	t1_comments,
	null	t1_complexion_cd,
	null	t1_conflict_id,
	null	t1_consumer_flag,
	null	t1_con_asst_name,
	null	t1_con_asst_per_id,
	null	t1_con_cd,
	null	t1_con_create_date,
	null	t1_con_exper_cd,
	null	t1_con_image_id,
	null	t1_con_influnc_id,
	null	t1_con_manager_name,
	null	t1_con_manager_per_id,
	null	t1_court_pay_flag,
	null	create_date,
	null	create_user_id,
	null	t1_creator_login,
	null	t1_credit_agency,
	null	t1_credit_score,
	null	t1_csn,
	null	t1_cust_end_date,
	null	t1_cust_since_date,
	T1.cust_stat_cd	t1_cust_stat_cd,
	null	t1_cust_value_cd,
	null	t1_dcking_num,
	null	t1_decision_type_cd,
	null	t1_dedup_dataclnsd_date,
	null	t1_dedup_key_modify_date,
	null	t1_dedup_last_mtch_date,
	null	t1_dedup_token,
	null	t1_degree,
	null	t1_dflt_order_proc_cd,
	null	t1_disa_cleanse_flag,
	null	t1_disp_img_auth_flag,
	null	email_address,
	null	t1_email_loc_cd,
	null	t1_email_sr_modify_flag,
	null	t1_emplmnt_stat_cd,
	null	t1_emp_flag,
	null	t1_emp_id,
	null	t1_emp_number,
	null	t1_emp_work_loc_name,
	null	t1_enterprise_flag,
	null	t1_eye_color,
	null	fax_phone_number,
	null	first_name,
	null	t1_hair_color,
	null	t1_hard_to_reach,
	null	t1_height,
	null	t1_home_phone_number,
	null	t1_indust_id,
	null	t1_integration_id,
	null	t1_inves_start_date,
	null	t1_invstgtr_flag,
	null	t1_inv_org_st_date,
	null	job_title,
	null	t1_last_credit_date,
	null	last_name,
	case 
		when T1.created is not null and T1.last_upd BETWEEN T1.created and CURRENT_TIMESTAMP() then T1.created 
		when T1.created is null and T1.last_upd < CURRENT_TIMESTAMP() then T1.created
	end modify_date,
	null	modify_user_id,
	null	t1_latitude,
	null	t1_login,
	null	t1_longitude,
	null	maiden_name,
	null	marital_status,
	null	t1_med_spec_id,
	null	t1_member_flag,
	null	t1_mgmnt_flag,
	null	middle_name,
	null	t1_modification_number,
	null	t1_mother_maiden_name,
	null	nationality,
	null	t1_new_user_resp_name,
	null	nick_name,
	null	t1_occupation,
	null	t1_ok_to_sample_flag,
	null	t1_ou_id,
	null	t1_ou_mail_stop,
	null	t1_owner_login,
	null	t1_owner_per_id,
	null	t1_pager_company_id,
	null	t1_pager_num,
	null	t1_pager_phone_number,
	null	t1_pager_pin,
	null	t1_pager_type_cd,
	null	t1_par_row_id,
	null	t1_password,
	null	t1_person_uid,
	null	gender,
	null	per_title_suffix,
	null	t1_place_of_birth,
	null	t1_postn_cd,
	null	t1_po_pay_flag,
	null	t1_practice_type,
	null	t1_pref_comm_media_cd,
	null	t1_pref_comm_meth_cd,
	null	t1_pref_lang_id,
	null	t1_pref_locale_id,
	null	t1_pref_sale_dlr_id,
	null	t1_privacy_cd,
	null	t1_priv_flag,
	null	prospect_flag,
	null	t1_provider_flag,
	null	t1_pr_act_id,
	null	t1_pr_affl_id,
	null	t1_pr_alt_phone_number_id,
	null	t1_pr_asset_id,
	null	t1_pr_bl_per_address_id,
	null	t1_pr_client_ou_id,
	null	t1_pr_comm_lang_id,
	null	t1_pr_con_address_id,
	null	t1_pr_cst_accnt_id,
	null	t1_pr_cti_cfg_id,
	null	t1_pr_dept_ou_id,
	null	t1_pr_drvr_license_id,
	null	t1_pr_email_address_id,
	null	t1_pr_facility_id,
	null	t1_pr_grp_ou_id,
	null	t1_pr_held_postn_id,
	null	t1_pr_image_id,
	null	t1_pr_indust_id,
	null	t1_pr_mkt_seg_id,
	null	t1_pr_note_id,
	null	t1_pr_opty_id,
	null	t1_pr_ou_address_id,
	null	t1_pr_address_id,
	null	t1_pr_per_pay_prfl_id,
	null	t1_pr_phone_id,
	null	t1_pr_postn_id,
	null	t1_pr_prod_id,
	null	t1_pr_prod_ln_id,
	null	t1_pr_region_id,
	null	t1_pr_rep_dnrm_flag,
	null	t1_pr_rep_manl_flag,
	null	t1_pr_rep_sys_flag,
	null	t1_pr_resp_id,
	null	t1_pr_security_id,
	null	t1_pr_sh_per_address_id,
	null	t1_pr_specialty_id,
	null	t1_pr_state_lic_id,
	null	t1_pr_sync_user_id,
	null	t1_pr_terr_id,
	null	t1_pr_userrole_id,
	null	t1_ptshp_contact_flag,
	null	t1_ptshp_key_con_flag,
	null	t1_race,
	null	t1_rating,
	null	t1_region_id,
	null	t1_regl_stat_cd,
	null	t1_reliability_cd,
	null	t1_route,
	T1.row_id	customer_id,
	null	t1_sec_answr,
	null	t1_sec_quest_cd,
	null	t1_seminar_invit_flag,
	null	t1_send_fin_flag,
	null	t1_send_news_flag,
	null	t1_send_promotes_flag,
	null	t1_send_survey_flag,
	null	t1_sex_mf,
	null	id_number,
	null	t1_speaker_flag,
	null	t1_src_id,
	null	t1_status_cd,
	null	t1_stat_reason_cd,
	null	t1_stock_portfolio,
	null	t1_sub_spec_id,
	null	t1_suppress_call_flag,
	null	t1_suppress_email_flag,
	null	t1_suppress_fax_flag,
	null	t1_suppress_mail_flag,
	null	t1_suspect_flag,
	null	t1_svc_branch_id,
	null	t1_timezone_id,
	null	t1_tmzone_cd,
	null	t1_weathr_loc_pref,
	null	t1_web_region_id,
	null	t1_weight,
	null	phone_number_business,
	null	t1_x_academic_title,
	null	t1_x_accnt_name,
	null	t1_x_addressess_flag,
	null	t1_x_agreement_date_written,
	null	t1_x_alias_name_low,
	null	t1_x_alphabet_date_contact_flag,
	null	t1_x_annual_income_type,
	null	t1_x_arf_flag,
	null	t1_x_aux_income_type,
	null	province,
	null	t1_x_blocked_by_sf,
	null	t1_x_bmw_assoc_status,
	null	t1_x_bmw_mag_count_modify_date,
	null	t1_x_bmw_i_flag,
	null	t1_x_branche,
	null	t1_x_branche_subsidary,
	null	t1_x_business_code,
	null	t1_x_closing,
	null	t1_x_cl_code,
	null	t1_x_cl_name,
	null	t1_x_comm_cust,
	null	t1_x_comm_salutation,
	null	t1_x_comm_salutation_inf,
	null	t1_x_company_code,
	null	t1_x_contracting_party_id,
	null	t1_x_cont_loc_id,
	null	t1_x_con_acc_switch_count,
	null	t1_x_con_acc_switch_type,
	null	t1_x_created_by_epa_transact,
	null	t1_x_created_by_source,
	null	t1_x_csn,
	null	t1_x_csn_orig,
	null	t1_x_cust_category,
	null	t1_x_cust_class,
	null	t1_x_cust_num_fs,
	null	t1_x_diplomat_flag,
	null	t1_x_doc_type,
	null	t1_x_dor_date,
	null	t1_x_dpa_consents_date,
	null	t1_x_dpa_email_consent,
	null	t1_x_dpa_email_consent_flag,
	null	t1_x_dpa_mail_consent,
	null	t1_x_dpa_mail_consent_flag,
	null	t1_x_dpa_phone_consent,
	null	t1_x_dpa_phone_consent_flag,
	null	t1_x_dpa_product_cat,
	null	t1_x_dpa_sms_consent,
	null	t1_x_dpa_sms_consent_flag,
	null	t1_x_dpa_modify_source,
	null	t1_x_emp_phone,
	null	t1_x_emp_postal_code,
	null	t1_x_exp_bu_id,
	null	t1_x_fiscal_num,
	null	t1_x_flash_note,
	null	t1_x_freelancer_flag,
	null	first_name_low,
	null	first_name_uk,
	null	t1_x_fullscore,
	null	t1_x_gk_status,
	null	t1_x_ids_email_address,
	null	t1_x_indep_profession_flag,
	null	t1_x_initials,
	null	t1_x_initials_low,
	null	t1_x_insertion,
	null	t1_x_insertion_proper,
	null	last_name_low,
	null	t1_x_lst_main_address_calc_date,
	null	t1_x_main_address_modify_by_src,
	null	t1_x_main_address_modify_src,
	null	t1_x_marketing_profiling_flag,
	null	t1_x_marketing_promotion_flag,
	null	t1_x_master_cust,
	null	t1_x_merged_to_con_id,
	null	t1_x_mini_club,
	null	t1_x_mini_mag_count_lst_modify,
	null	t1_x_mitarbeiterstatus,
	null	t1_x_ml_code,
	null	t1_x_ml_name,
	null	t1_x_motor_club,
	null	t1_x_mybmwsf_reg_flag,
	null	t1_x_mybmwsf_last_login_date,
	null	t1_x_mybmwsf_reg_date,
	null	t1_x_nationality,
	null	t1_x_no_conn_crm,
	null	t1_x_num_children,
	null	t1_x_num_per_hhold,
	null	t1_x_num_veh_hhold,
	null	passport_number,
	null	t1_x_payment_code,
	null	t1_x_pay_reminder,
	null	t1_x_pref_comm_sf,
	null	t1_x_prefix,
	null	t1_x_prefix2,
	null	t1_x_premium_flag,
	null	t1_x_press_flag,
	null	t1_x_professional_flag,
	null	t1_x_pr_agency_id,
	null	t1_x_pr_per_address_id_former,
	null	t1_x_pr_queue_id,
	null	t1_x_rel_type_cd,
	null	t1_x_residence_perm_type,
	null	t1_x_rfe_visibility,
	null	t1_x_sfi_dn_contact_flag,
	null	t1_x_siret_number,
	null	t1_x_sl_code,
	null	t1_x_sl_name,
	null	t1_x_stop_gcdm_modify_flag,
	null	t1_x_stop_mini_mag_flag,
	null	t1_x_stop_newsletter,
	null	t1_x_stop_newsl_chngd_date,
	null	t1_x_stop_newsl_chngd_src,
	null	t1_x_suppress_mms_flag,
	null	t1_x_suppress_sms_flag,
	null	t1_x_suppress_sms_sf,
	T1.x_sys_id	t1_x_sys_id,
	null	t1_x_sys_id_switch,
	null	t1_x_type_cd,
	null	t1_x_unpaid_level,
	null	t1_x_modified_by_source,
	null	t1_x_modified_source_date,
	null	t1_x_modify_by_epa_transact,
	null	t1_x_usage_note,
	null	t1_x_validity,
	null	t1_x_vat_category,
	null	t1_x_vat_number,
	null	t1_x_vip_flag,
	null	mobile_phone_number_business,
	null	fax_phone_number_business,
	null	t1_x_stop_online_survey_flag,
	null	t1_x_v_cust_deleted,
	--null	——,
	--null	——,
	--null	——,
	null	t1_x_linked_contact_id,
	null	t1_x_uc_id,
	null	t1_x_gc_id,
	null	t2_attrib_01,
	null	involved_person,
	--null	——,
	null	t2_attrib_03,
	null	t2_attrib_04,
	null	t2_attrib_05,
	null	t2_attrib_06,
	null	currency_cd,
	null	t2_attrib_08,
	null	bankrupt_flag,
	null	t2_attrib_10,
	null	new_record_flag,
	null	verbal_agreement_date,
	null	t2_attrib_13,
	null	t2_attrib_14,
	null	t2_attrib_15,
	null	t2_attrib_16,
	null	recvd_bmw_magazines,
	null	send_bmw_magazines,
	null	recvd_mini_magazines,
	null	send_mini_magazines,
	null	t2_attrib_21,
	null	alphabet_region,
	null	number_pers_in_household,
	null	side_income,
	null	income,
	null	t2_attrib_26,
	null	exchange_date,
	null	t2_attrib_28,
	null	customer_since_date,
	null	valid_until_date,
	null	resident_since_date,
	null	t2_attrib_32,
	null	t2_attrib_33,
	null	occupation,
	null	t2_attrib_35,
	null	outbound_email_address,
	null	driver_license,
	null	outbound_fax,
	null	outbound_phone,
	null	comms_blocked_by_bmw,
	null	stop_mini_magazine_flag,
	null	stop_motorcycl_magazine_flag,
	null	bmw_sf_flag,
	null	customer_card_flag,
	null	stop_magazine_flag,
	null	stop_wcp_flag,
	null	t2_attrib_47,
	null	industry,
	null	al_key_account_mgr,
	null	stop_survey,
	null	alphabet_status,
	null	customer_type_sale,
	null	gk_key_account_mgr,
	null	company_name,
	null	t2_attrib_55,
	null	kids_number,
	null	living_expenses,
	null	t2_attrib_58,
	null	t2_attrib_59,
	null	t2_attrib_60,
	null	t2_attrib_61,
	null	t2_attrib_62,
	null	t2_attrib_63,
	null	t2_attrib_64,
	null	t2_conflict_id,
	null	t2_create_date,
	null	t2_create_user_id,
	null	t2_dcking_number,
	null	t2_modify_date,
	null	t2_modify_user_id,
	null	t2_modification_number,
	null	t2_par_row_id,
	null	t2_row_id,
	null	t2_x_alphabet,
	null	t2_x_alphera,
	null	t2_x_bmw_mtrbk_lst_modify,
	null	t2_x_bmw_mtrbk_mag_recv,
	null	t2_x_bmw_mtrbk_mag_sent,
	null	t2_x_dealer_do_not_contact,
	null	t2_x_drv_lic_date,
	null	t2_x_no_address_fwd_to_dealer,
	null	x_no_address_fwd_to_dlr_last_u,
	null	t2_x_no_after_sales_contact,
	null	t2_x_no_fwd_to_dealer,
	null	t2_x_no_fwd_to_dealer_dea,
	null	t2_x_no_select_for_segment,
	null	t2_x_stop_advertisement,
	null	t2_x_stop_dealer_kpp,
	null	t2_x_stop_fulfillment,
	null	t2_x_stop_kpp,
	null	t2_x_stop_mailings,
	null	t2_x_stop_market_research,
	null	t2_x_stop_mini_service_card,
	null	t2_x_stop_moto_magazine,
	null	t2_x_stop_moto_service_card,
	null	t2_x_stop_sf_communication,
	null	t2_x_undeliverable_counter,
	null	t2_x_up_2_drive,
	T2.x_contact_sub_status	t2_x_contact_sub_status
from source_carmen.a_carmen_s_contact T1
left join source_carmen.a_carmen_S_CONTACT_X T2
on t1.row_id = t2.par_row_id
join source_carmen.a_carmen_s_bu b 
on t1.BU_ID = b.row_id
Where b.name = 'BMW-CN' and t1.emp_flg <> 'Y'
and t1.cust_stat_cd like '%Inactive';



