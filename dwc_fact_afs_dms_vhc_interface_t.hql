--dwc_fact_afs_dms_vhc_interface_t
select	
    case when trim(dealer_no) rlike '^[0-9]{5}$' then trim(dealer_no) end dealer_id,
    concat(regexp_replace(wip_create_date,'[^0-9]',''),'S',nvl(wipno,'')) order_no,
    vhccode	vhc_code,
    vhcdesc	vhc_desc,
    account	account_code,
    case when invoicedate between '1949-01-01' and CURRENT_TIMESTAMP() then concat(invoicedate,' 00:00:00') end	invoice_date,
    CASE
        WHEN vhctext in ('紧急','Red') THEN '80501001'
        WHEN vhctext in ('警示','Amber') THEN '80501002'
        WHEN vhctext = '线索' THEN '80501003'
        WHEN vhctext = '' THEN null
        WHEN vhctext is null THEN null
        ELSE '80501002'
    END vhc_text,
    CASE
        WHEN trim(REQLSTAT) IS NULL THEN NULL
        WHEN trim(REQLSTAT) = '' THEN null
        WHEN trim(REQLSTAT) = 'N' THEN '80571004'
        WHEN trim(REQLSTAT) = 'L' THEN '80571005'
        WHEN trim(REQLSTAT) = 'D' THEN '80571006'
        ELSE '80571001'
    END vhc_status,
    lostdesc	lost_sale_reasons,
    wlclockr	wl_clockr,
    wipoper	wip_creator,
    case when folldate > '1949-01-01' then concat(folldate,' 00:00:00') end	follow_up_date,
    case when vhccrete between '1949-01-01' and CURRENT_TIMESTAMP() then concat(vhccrete,' 00:00:00') end	vhc_create_date ,
    menucode	menu_code,
    actline	line_number ,
    itemcode	item_code,
    itemdesc	item_description,
    qty	qty,
    cost	cost,
    CASE 
        WHEN trim(invstat) in ('I','H') THEN '80471001'
        WHEN trim(invstat) = 'X' THEN '80471004'
        WHEN trim(invstat) = 'C' THEN '80471006'
        WHEN trim(invstat) = 'D' THEN '80471007'
        WHEN trim(invstat) = '' THEN NULL
        WHEN trim(invstat) is NULL THEN NULL
        ELSE '80471001'
    END invoice_status,
    case when trim(chassisno) rlike '^[0-9A-Za-z]{17}$' then trim(chassisno) end	vin_17,
    model	model_name,
    case when mileage >= 0 then mileage end	mileage,
    case 
		when length(trim(regno))<=8
		and substr(trim(regno),1,1) in ('京','津','冀','晋','蒙','辽','吉','黑','沪','苏','浙','皖','闽','赣','鲁','豫','鄂','湘','粤','桂','琼','川','贵','云','渝','藏','陕','甘','青','宁','新','港','澳','台','军','空','海','北','沈','兰','济','南','广','成')
		and substr(trim(regno),2,1) rlike '([a-z]|[A-Z])+' 
		and (substr(trim(regno),length(trim(regno))-5,6) rlike '^[A-Za-z0-9]+$' or substr(trim(regno),length(trim(regno))-4,5) rlike '^[A-Za-z0-9]+$' )
	then trim(regno) end license_plate_number,
    case when warrstart between '1949-01-01' and current_timestamp() then concat(warrstart,' 00:00:00') end warranty_start_date,
    name	customer_name,
    case	
		WHEN regexp_replace(phone,'[^+0-9]','') REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone,'[^+0-9]',''),'+','')
		WHEN regexp_replace(phone,'[^+0-9]','') REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone,'[^+0-9]','')
		WHEN regexp_replace(phone,'[^+0-9]','') REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone,'[^+0-9]',''))
		when regexp_replace(phone,'[^+0-9]','') REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone,'[^+0-9]',''),2))
		when regexp_replace(phone,'[^+0-9]','') REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone,'[^+0-9]',''),2)
	end mobile_phone_number,
	case
		when b.province is not null then b.province
		when b.province is null and c.province is not null then c.province
	end province,
    case 
		when b.city is not null then b.city
		when b.city is null and e.new_city is not null then e.new_city
		when b.city is null and REGEXP_REPLACE(a.town,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区",'')='' then null
		when a.town is null or trim(a.town) ='' then null
		else REGEXP_REPLACE(a.town,'[^\u4e00-\u9fa5]','')
	end city,
    po_no	po_no,
    case when trim(type) in ('L','P') then trim(type) end	type,
    front_left_value	front_left_value,
    rear_left_value	rear_left_value,
    front_right_value	front_right_value,
    rear_right_value	rear_right_value,
    case when wip_create_date between '1949-01-01' and CURRENT_TIMESTAMP() then concat(wip_create_date,' 00:00:00') end	order_date,
    day	day,
    CASE
        WHEN TYPE = 'L' and (LOAD_STATUS not in ('B','W','P','L','A','D','C','X','') or LOAD_STATUS IS NULL) THEN 80331001
        WHEN TYPE = 'L' and LOAD_STATUS in ('B') THEN 80331002
        WHEN TYPE = 'L' and LOAD_STATUS in ('W') THEN 80331003
        WHEN TYPE = 'L' and LOAD_STATUS in ('P') THEN 80331005
        WHEN TYPE = 'L' and LOAD_STATUS in ('L') THEN 80331004
        WHEN TYPE = 'L' and LOAD_STATUS in ('A') THEN 80331006
        WHEN TYPE = 'L' and LOAD_STATUS in ('D') THEN 80331010
        WHEN TYPE = 'L' and LOAD_STATUS in ('C','X') THEN 80331009
        WHEN TYPE = 'L' and LOAD_STATUS in ('') THEN NULL
        WHEN TYPE = 'L' and LOAD_STATUS IS NULL THEN NULL
        WHEN TYPE = 'P' and LOAD_STATUS not in ('V','E','S','X','D') THEN 50281001
        WHEN TYPE = 'P' and LOAD_STATUS in ('V') THEN 50281008
        WHEN TYPE = 'P' and LOAD_STATUS in ('E') THEN 50281007
        WHEN TYPE = 'P' and LOAD_STATUS in ('S') THEN 50281006
        WHEN TYPE = 'P' and LOAD_STATUS in ('X') THEN 50281005
        WHEN TYPE = 'P' and LOAD_STATUS in ('D') THEN 50281009
    END load_status,
    case when last_edit_date between '1949-01-01' and CURRENT_TIMESTAMP() then concat(added_wip,' 00:00:00') end	last_edit_date,
    round(cast(added_wip as NUMERIC),0)	added_order_no,
    case when arrived_date between '1949-01-01' and CURRENT_TIMESTAMP() then concat(arrived_date,' 00:00:00') end arrived_date,
    parts_available	parts_available,
    round(cast(invoice_number as NUMERIC),0)	invoice_no,
    CASE
        WHEN UPPER(brand) IN ('B','BMW') THEN 'BMW'
        WHEN UPPER(brand) IN ('C') OR UPPER(brand) LIKE '%MOTOR%' THEN 'BMW Motorrad'
        WHEN UPPER(brand) IN ('M','MINI') THEN 'MINI'
        WHEN UPPER(brand) IN ('E','BMW I') THEN 'BMW i'
        WHEN UPPER(brand) IN ('N','ZINORO') THEN 'ZINORO'
        ELSE 'OTH'
    END brand_code, 
    fday	fday
from source_dms.a_dms_vhc_interface a
left join (select distinct province,city from raw.raw_upload_province_city_district_map_t where city is not null )b
on REGEXP_REPLACE(a.town,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")=regexp_replace(b.city,"新区|区|市|自治州|地区","")
and REGEXP_REPLACE(a.town,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and a.town is not null
and b.province not in ('北京市','上海市','重庆市')
and a.town not in ('朝阳区')
left join (select distinct province from raw.raw_upload_province_city_district_map_t where city is not null )c
on REGEXP_REPLACE(a.dic,"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")=regexp_replace(c.province,"省|市|自治区|特别行政区","")
and REGEXP_REPLACE(a.dic,"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")<>''
and a.dic is not null
left join (select  '塘沽' old_city,  '滨海新区' new_city union all select  '崇文' old_city,  '东城区' new_city union all select  '宣武' old_city,  '西城区' new_city union all select  '巢湖' old_city,  '合肥市' new_city union all select  '永康' old_city,  '金华市' new_city union all select  '三河' old_city,  '廊坊市' new_city union all select  '江阴' old_city,  '无锡市' new_city union all select  '莱芜' old_city,  '济南市' new_city union all select  '闸北' old_city,  '静安区' new_city union all select  '任丘' old_city,  '沧州市' new_city union all select  '慈溪' old_city,  '宁波市' new_city union all select  '襄樊' old_city,  '襄阳市' new_city union all select  '大港' old_city,  '滨海新区' new_city union all select  '迁安' old_city,  '唐山市' new_city union all select  '思茅' old_city,  '普洱市' new_city union all select  '静海县' old_city,  '静海区' new_city union all select  '晋州' old_city,  '石家庄市' new_city union all select  '密云县' old_city,  '密云区' new_city union all select  '卢湾' old_city,  '黄浦区' new_city union all select  '余姚' old_city,  '宁波市' new_city union all select  '蓟县' old_city,  '蓟州区' new_city union all select  '太仓' old_city,  '苏州市' new_city union all select  '崇明县' old_city,  '崇明区' new_city union all select  '开县' old_city,  '开州区' new_city union all select  '汉沽' old_city,  '滨海新区' new_city union all select  '大足县' old_city,  '大足区' new_city union all select  '璧山县' old_city,  '璧山区' new_city)e
on REGEXP_REPLACE(a.town,"[^\u4e00-\u9fa5]|市|区","")=e.old_city
and REGEXP_REPLACE(a.town,"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and a.town is not null;