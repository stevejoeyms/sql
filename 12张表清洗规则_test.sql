
--dwc.dwc_dim_afs_spark_tm_afs_dealer_vehicle_t 清洗规则
with x as (select explode(split('114,246,247,248,259,600,700,E03,E09,E12,E21,E23,E24,E26,E28,E30,E31,E32,E34,E36,E38,E39,E46,E52,E53,E55,E59,E60,E61,E63,E64,E65,E66,E67,E68,E70,E71,E72,E81,E82,E83,E84,E85,E86,E87,E88,E89,E90,E91,E92,E93,EXX,F01,F02,F03,F04,F05,F06,F07,F10,F11,F12,F13,F15,F16,F18,F20,F21,F22,F23,F25,F26,F30,F31,F32,F33,F34,F35,F36,F39,F40,F44,F45,F46,F48,F49,F52,F54,F55,F56,F57,F60,F65,F66,F70,F74,F78,F80,F82,F83,F85,F86,F87,F90,F91,F92,F93,F95,F96,F97,F98,G01,G02,G05,G06,G07,G08,G08BEV,G09,G11,G12,G13,G14,G15,G16,G18,G20,G21,G22,G23,G26,G26BEV,G28,G28BEV,G29,G30,G31,G32,G38,G42,G60,G61,G68,G70,G73,G80,G82,G83,G87,I01,I12,I15,I20,K02,K03,K08,K09,K10,K14,K15,K16,K17,K18,K19,K21,K22,K23,K25,K26,K27,K28,K29,K30,K32,K33,K34,K35,K40,K41,K42,K43,K44,K45,K46,K47,K48,K49,K50,K51,K52,K53,K54,K60,K61,K63,K66,K67,K69,K70,K71,K72,K73,K75,K80,K81,K82,K83,K84,KXX,M12,M13,R13,R21,R22,R24,R25,R26,R27,R28,R50,R51,R52,R53,R55,R56,R57,R58,R59,R60,R61,R67,R68,R69,RXX,U06,U10,U11,U12,U25,VET',',')) as s_eseries_code)
select
	trim(dealer_vehicle_id)	dealer_vehicle_id,
	trim(vehicle_type)	vehicle_type,
	case when translate(lower(trim(vin)),'qwertyuioplkjhgfdsazxcvbnm0123456789','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')='aaaaaaaaaaaaaaaaa' then trim(vin) end as vin_17,
	case 
		when length(trim(license))<=8
		and substr(trim(license),1,1) in ('京','津','冀','晋','蒙','辽','吉','黑','沪','苏','浙','皖','闽','赣','鲁','豫','鄂','湘','粤','桂','琼','川','贵','云','渝','藏','陕','甘','青','宁','新','港','澳','台','军','空','海','北','沈','兰','济','南','广','成')
		and substr(trim(license),2,1) rlike '([a-z]|[A-Z])+' 
		and (substr(trim(license),length(trim(license))-5,6) rlike '^[A-Za-z0-9]+$' or substr(trim(license),length(trim(license))-4,5) rlike '^[A-Za-z0-9]+$' )
	then license end license_plate_number,
	case when mile < 0  then null else mile end as mileage,
	vehicle_source	vehicle_source,
	vehicle_purpose	vehicle_purpose,
	vehicle_status	vehicle_status,
	customer_type	customer_type,
	sales_dealer_code	sales_dealer_code,
	trim(sales_dealer_descr)	sales_dealer_descr,
	trim(last_sa_id)	last_sa_id,
	trim(last_sa_name)	last_sa_name,
	trim(special_sa_id)	special_sa_id,
	trim(special_sa_name)	special_sa_name,
	is_second_car	is_second_car,
	is_pass_car	is_pass_car,
	CASE
	 WHEN UPPER(trim(brand_code)) IN ('B','BMW') THEN 'BMW'
	 WHEN UPPER(trim(brand_code)) IN ('C') OR UPPER(trim(brand_code))  LIKE ('%MOTOR%') THEN 'BMW Motorrad'
	 WHEN UPPER(trim(brand_code)) IN ('M','MINI') THEN 'MINI'
	 WHEN UPPER(trim(brand_code)) IN ('E','BMW I') THEN 'BMW i'
	 WHEN UPPER(trim(brand_code)) IN ('N','ZINORO') THEN 'ZINORO'
	ELSE 'OTH' END brand_code,
	trim(brand_name)	brand_name,
	ckd_or_cbu	ckd_or_cbu,
	case 
		when x1.s_eseries_code is not null then x1.s_eseries_code
		when x1.s_eseries_code is null and x.s_eseries_code is not null then x.s_eseries_code
		else y.short_series_code
	end eseries_code,
	trim(series_code)	series_code,
	trim(series_name)	series_name,
	trim(model_code)	model_code,
	trim(sale_vehicle_descr)	sale_vehicle_descr,
	trim(body_color_code)	exterior_color_code,
	trim(body_color)	exterior_color,
	from_unixtime(unix_timestamp(product_date,'yyyyMM'), 'yyyy-MM-dd HH:mm:ss')	product_date,
	national_specification	national_specification,
	engine_model_code	engine_model_code,
	engine_type	engine_type,
	door_count	door_count,
	trim(displacement)	displacement,
	trim(emission)	emission,
	trim(inner_color_code)	interior_color_code,
	trim(inner_color)	interior_color,
	extend_wrt_begin_date extend_warranty_start_date,
	case 
		when extend_wrt_begin_date is not null and extend_wrt_end_date is not null and extend_wrt_begin_date<extend_wrt_end_date then extend_wrt_end_date
		when extend_wrt_begin_date is null and extend_wrt_end_date is not null then extend_wrt_end_date
	end extend_warranty_end_date,
	insurance_begin_date insurance_begin_date,
	case 
		when insurance_begin_date is not null and insurance_end_date is not null and insurance_begin_date<insurance_end_date then insurance_end_date 
		when insurance_begin_date is null and insurance_end_date is not null then insurance_end_date
	end insurance_end_date,
	trim(insuration_id)	insuration_id,
	trim(insuration_code)	insuration_code,
	trim(insuration_name)	insuration_name,
	case when last_repair_date is not null and last_repair_date<CURRENT_TIMESTAMP() then last_repair_date end  last_repair_date,
	case when last_local_mile<0 then null else last_local_mile end last_local_mile,
	case 
		when (created_at is not null and next_repair_date>=created_at and next_repair_date<CURRENT_TIMESTAMP()) or (created_at is null and next_repair_date<current_timestamp)
	then last_repair_date end next_repair_date,
	case when next_repair_mile<0 then null else next_repair_mile end next_repair_mile,
	trim(insurance_advisor_name)	insurance_advisor_name,
	trim(last_deliverer_id)	last_deliverer_id,
	trim(last_deliverer_name)	last_deliverer_name,
	inspection_expiry_date inspection_expiry_date,
	trim(remark)	remarks,
	trim(temp1)	temp1,
	trim(temp2)	temp2,
	trim(temp3)	temp3,
	trim(temp4)	temp4,
	trim(temp5)	temp5,
	trim(temp6)	temp6,
	trim(temp7)	temp7,
	trim(temp8)	temp8,
	trim(temp9)	temp9,
	trim(temp10)	temp10,
	trim(insurance_remark)	insurance_remarks,
	case when replace(translate(lower(trim(owner_code)),'qwertyuioplkjhgfdsazxcvbnm0123456789','111111111111111111111111111111111111'),'1','')='' then trim(owner_code) end dealer_code,
	trim(company_code)	company_code,
	trim(org_id)	organization_id,
	data_source	data_source,
	if(is_deleted in ('1','0'),is_deleted,'0')	deleted,
	is_valid	is_valid,
	trim(created_by)	created_by,
	trim(created_name)	created_name,
	created_at create_date,
	case when replace(translate(trim(updated_by),'0123456789','1111111111'),'1','')='' then trim(updated_by) end updated_by,
	trim(updated_name)	updated_name,
	case 
		when (created_at is not null and updated_at is not null and created_at<=updated_at and updated_name<=current_timestamp) 
		or (created_at is null and updated_at is not null and updated_name<=CURRENT_TIMESTAMP())
	then updated_at end modify_date,
	record_version version_number,
	trim(extend_database)	extend_database,
	case 
		when from_unixtime(cast(extend_record_timestamp/1000 as bigint),'yyyy-MM-dd HH:mm:ss')>'1949-01-01 00:00:00' and from_unixtime(cast(extend_record_timestamp/1000 as bigint),'yyyy-MM-dd HH:mm:ss')<=CURRENT_TIMESTAMP() 
	then extend_record_timestamp end extend_record_timestamp,
	extend_create_time	extend_create_date,
	case 
		when (extend_create_time is not null and extend_update_time is not null and extend_create_time<=extend_update_time and extend_update_time<=CURRENT_TIMESTAMP())
		or(extend_create_time is null and extend_update_time is not null and extend_update_time<=CURRENT_TIMESTAMP())
	then extend_update_time end extend_update_date,
	case when before_last_local_mile<0 then null else before_last_local_mile end before_last_local_mile,
	case
		when (last_repair_date is not null and before_last_repair_date is not null and last_repair_date>=before_last_repair_date) 
		or (last_repair_date is null and before_last_repair_date is not null and before_last_repair_date<=CURRENT_TIMESTAMP())
	then before_last_repair_date end before_last_repair_date,
	trim(extend_record_id)	extend_record_id
from source_spark.spark__public__tm_afs_dealer_vehicle y
left join x
on substr(y.short_series_code,1,3)=x.s_eseries_code
left join x x1
on y.short_series_code=x1.s_eseries_code
limit 1000
;


--dwc.dwc_fact_cus_membership2_dealer_relation_info_history_t 清洗规则
select
	gcid	gcid,
	copid	cop_id,
	case when trim(dealer_cbu) in ('BMW','MINI') or trim(dealer_cbu) rlike '^\\d{5}$' then trim(dealer_cbu) end dealer_id,
	dealer_name	dealer_name,
	event_type	event_type,
	joy_cion	joy_cion,
	tierid	tier_id,
	tier_name	tier_name,
	tier_level	tier_level,
	case when event_date >= '1949-01-01 00:00:00' and event_date<CURRENT_TIMESTAMP() then event_date end event_date,
	customer_tier_id	customer_tier_id,
	case when cdp_create_date >= '1949-01-01 00:00:00' and cdp_create_date<CURRENT_TIMESTAMP() then cdp_create_date end	cdp_create_date,
	day	fday
from source_membership2.member_dealer_relation_info_history
--limit 1000
;


--dwc.dwc_fact_cus_membership2_dealer_relation_info_t 清洗规则
select
	gcid	gcid,
	copid	cop_id,
	case when trim(dealer_cbu) in ('BMW','MINI') or trim(dealer_cbu) rlike '^\\d{5}$' then trim(dealer_cbu) end dealer_id,
	dealer_name	dealer_name,
	event_type	event_type,
	joy_cion	joy_cion,
	tierid	tier_id,
	tier_name	tier_name,
	tier_level	tier_level,
	case when event_date >= '1949-01-01 00:00:00' and event_date<CURRENT_TIMESTAMP() then event_date end event_date,
	customer_tier_id	customer_tier_id,
	case when cdp_create_date >= '1949-01-01 00:00:00' and cdp_create_date<CURRENT_TIMESTAMP() then cdp_create_date end	cdp_create_date,
	day	fday
from source_membership2.member_dealer_relation_info
--limit 1000
;


--dwc.dwc_fact_com_membership2_vehicle_relation_info_history_t 清洗规则
select
	gcid	gcid,
	copid	cop_id,
	case when trim(vin17) rlike "^[A-Za-z0-9]{17}$" then trim(vin17) end vin_17,
	identity	cvr_type,
	full_name	full_name,
	CASE
		WHEN UPPER(trim(brand)) IN ('B','BMW') THEN 'BMW'
		WHEN UPPER(trim(brand)) IN ('C') OR UPPER(trim(brand))  LIKE ('%MOTOR%') THEN 'BMW Motorrad'
		WHEN UPPER(trim(brand)) IN ('M','MINI') THEN 'MINI'
		WHEN UPPER(trim(brand)) IN ('E','BMW I') THEN 'BMW i'
		WHEN UPPER(trim(brand)) IN ('N','ZINORO') THEN 'ZINORO'
	ELSE 'OTH' END brand_code,
	case
	    when TRIM(series) rlike '.*[1-9]{1}.*Series.*phev.*' or TRIM(series) rlike '.*[1-9]{1}.*系.*phev.*' then concat(regexp_replace(series,"[^1-9]",""),' Series Phev')
	    when TRIM(series) rlike '.*[1-9]{1}.*Series.*' or TRIM(series) rlike '.*[1-9]{1}.*系.*' then concat(regexp_replace(series,"[^1-9]",""),' Series')
	    when TRIM(series) rlike '.*X.*[1-7]{1}.*phev.*' then concat('X',regexp_replace(series,"[^1-7]",""),' Phev')
	    when TRIM(series) rlike '.*X.*[1-7]{1}.*M.*' then concat('X',regexp_replace(series,"[^1-7]",""),' M')
	    when TRIM(series) rlike '.*X.*[1-7]{1}' then concat('X',regexp_replace(series,"[^1-7]",""))
	    when TRIM(series) like '%MINI%三门版%' then 'MINI 三门版'
	    when TRIM(series) like '%MINI%五门版%' then 'MINI 五门版'
	    when TRIM(series) rlike '.*M.*[1-8]{1}.*' then concat('M',regexp_replace(series,"[^1-8]",""))
	    when TRIM(series) like '%iX%' then 'iX'
	    when TRIM(series) rlike '.*i.*[348]{1}.*' then concat('i',regexp_replace(series,"[^348]",""))
	    when TRIM(series) in ('BMW i','BMWi','I','i') then 'I'
	    when TRIM(series) like '%Countryman%' then 'Countryman'
	    when TRIM(series) like '%Clubman%' then 'Clubman'
	    when TRIM(series) like '%Cabrio%' then 'Cabrio'
	    when TRIM(series) like '%ZINORO%' then 'ZINORO'
	    when TRIM(series) in ('Z4 M','Z4M') then 'Z4 M'
	    when TRIM(series) rlike '.*Z.*[1348]{1}.*' then concat('Z',regexp_replace(series,"[^1348]",""))
	    else TRIM(series)
	end series_code,
	model_name	model_name,
	model_code	model_code,
	event_type	event_type,
	verify_status	verify_status,
	verify_sub_status	verify_sub_status,
	case when event_date >= '1949-01-01 00:00:00' and event_date<CURRENT_TIMESTAMP() then event_date end event_date,	--need confirm the type of date
	link_id	link_id,
	case when cdp_create_date >= '1949-01-01 00:00:00' and cdp_create_date<CURRENT_TIMESTAMP() then cdp_create_date end	cdp_create_date,	--need confirm the type of date
	day	fday
from source_membership2.member_vehicle_relation_info_history
--limit 1000
;


--dwc.dwc_fact_com_membership2_vehicle_relation_info_t 清洗规则
select
	gcid	gcid,
	copid	cop_id,
	case when trim(vin17) rlike "^[A-Za-z0-9]{17}$" then trim(vin17) end vin_17,
	identity	cvr_type,
	full_name	full_name,
	CASE
		WHEN UPPER(trim(brand)) IN ('B','BMW') THEN 'BMW'
		WHEN UPPER(trim(brand)) IN ('C') OR UPPER(trim(brand))  LIKE ('%MOTOR%') THEN 'BMW Motorrad'
		WHEN UPPER(trim(brand)) IN ('M','MINI') THEN 'MINI'
		WHEN UPPER(trim(brand)) IN ('E','BMW I') THEN 'BMW i'
		WHEN UPPER(trim(brand)) IN ('N','ZINORO') THEN 'ZINORO'
	ELSE 'OTH' END brand_code,
	case
	    when TRIM(series) rlike '.*[1-9]{1}.*Series.*phev.*' or TRIM(series) rlike '.*[1-9]{1}.*系.*phev.*' then concat(regexp_replace(series,"[^1-9]",""),' Series Phev')
	    when TRIM(series) rlike '.*[1-9]{1}.*Series.*' or TRIM(series) rlike '.*[1-9]{1}.*系.*' then concat(regexp_replace(series,"[^1-9]",""),' Series')
	    when TRIM(series) rlike '.*X.*[1-7]{1}.*phev.*' then concat('X',regexp_replace(series,"[^1-7]",""),' Phev')
	    when TRIM(series) rlike '.*X.*[1-7]{1}.*M.*' then concat('X',regexp_replace(series,"[^1-7]",""),' M')
	    when TRIM(series) rlike '.*X.*[1-7]{1}' then concat('X',regexp_replace(series,"[^1-7]",""))
	    when TRIM(series) like '%MINI%三门版%' then 'MINI 三门版'
	    when TRIM(series) like '%MINI%五门版%' then 'MINI 五门版'
	    when TRIM(series) rlike '.*M.*[1-8]{1}.*' then concat('M',regexp_replace(series,"[^1-8]",""))
	    when TRIM(series) like '%iX%' then 'iX'
	    when TRIM(series) rlike '.*i.*[348]{1}.*' then concat('i',regexp_replace(series,"[^348]",""))
	    when TRIM(series) in ('BMW i','BMWi','I','i') then 'I'
	    when TRIM(series) like '%Countryman%' then 'Countryman'
	    when TRIM(series) like '%Clubman%' then 'Clubman'
	    when TRIM(series) like '%Cabrio%' then 'Cabrio'
	    when TRIM(series) like '%ZINORO%' then 'ZINORO'
	    when TRIM(series) in ('Z4 M','Z4M') then 'Z4 M'
	    when TRIM(series) rlike '.*Z.*[1348]{1}.*' then concat('Z',regexp_replace(series,"[^1348]",""))
	    else TRIM(series)
	end series_code,
	model_name	model_name,
	model_code	model_code,
	event_type	event_type,
	verify_status	verify_status,
	verify_sub_status	verify_sub_status,
	case when event_date >= '1949-01-01 00:00:00' and event_date<CURRENT_TIMESTAMP() then event_date end event_date,	--need confirm the type of date
	link_id	link_id,
	case when cdp_create_date >= '1949-01-01 00:00:00' and cdp_create_date<CURRENT_TIMESTAMP() then cdp_create_date end	cdp_create_date,	--need confirm the type of date
	day	fday
from source_membership2.member_vehicle_relation_info
--limit 1000
;


--dwc_fact_com_membership2_coupon_event_info_t 清洗规则
select 
	case when trim(vin) rlike "^[A-Za-z0-9]{17}$" then trim(vin) end vin_17,
	subchannelid	sub_channel_id,
	mediaid	media_id,
	vouchernum	voucher_number,
	CASE WHEN regexp_replace(mobilephone,"[^ 0-9]+","") REGEXP '^\\+861[3-9][0-9]{9}$' AND LENGTH(regexp_replace(mobilephone,"[^ 0-9]+",""))=14 THEN REPLACE(regexp_replace(mobilephone,"[^ 0-9]+",""),'+','')
			 WHEN regexp_replace(mobilephone,"[^ 0-9]+","") REGEXP '^861[3-9][0-9]{9}$' AND LENGTH(regexp_replace(mobilephone,"[^ 0-9]+",""))=13 THEN regexp_replace(mobilephone,"[^ 0-9]+","")
			 WHEN regexp_replace(mobilephone,"[^ 0-9]+","") REGEXP '^1[3-9][0-9]{9}$' AND LENGTH(regexp_replace(mobilephone,"[^ 0-9]+",""))=11 THEN CONCAT('86',regexp_replace(mobilephone,"[^ 0-9]+",""))
			 when regexp_replace(mobilephone,"[^ 0-9]+","") REGEXP '^01[3-9][0-9]{9}$' AND LENGTH(regexp_replace(mobilephone,"[^ 0-9]+",""))=12 THEN CONCAT('86',substr(regexp_replace(mobilephone,"[^ 0-9]+",""),2))
	END mobile_phone_number,
	secondtime	second_time,
	wcode	w_code,
	id	id,
	cdpid	cdp_id,
	cdpidtype	cdp_id_type,
	userid	user_id,
	useridtype	user_id_type,
	case 
	when from_unixtime(cast(event_ts as bigint),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(cast(event_ts as bigint),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() 
	then from_unixtime(cast(event_ts as bigint),'yyyy-MM-dd HH:mm:ss') 
	end event_times,
	objectid	object_id,
	objecttype	object_type,
	placeid	place_id,
	placetype	place_type,
	eventid	event_id,
	gcid	gcid,
	voucherid	voucher_id,
	eventdealercbu	event_dealer_cbu,
	eventdealername	event_dealer_name,
	case when starttime >= '1949-01-01 00:00:00' and starttime<CURRENT_TIMESTAMP() then starttime end start_date,
	case when endtime >= '1949-01-01 00:00:00' and endtime<CURRENT_TIMESTAMP() then endtime end end_date,
	campaignid	campaign_id,
	channelid	channel_id,
	extent	extent,
	label	label,
	case
	when from_unixtime(cast(publish_ts as bigint),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(cast(publish_ts as bigint),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() 
	then from_unixtime(cast(publish_ts as bigint),'yyyy-MM-dd HH:mm:ss') 
	end publish_date,
	case
	when from_unixtime(cast(collect_ts as bigint),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(cast(collect_ts as bigint),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() 
	then from_unixtime(cast(collect_ts as bigint),'yyyy-MM-dd HH:mm:ss') 
	end collect_date,
	publisher	publisher,
	version version_number,
	source	source,
	pday	pday,
	day	fday
from source_membership2.member_coupon_event_info
--limit 1000
;


--dwc.dwc_dim_com_membership2_coupon_template_t 清洗规则
SELECT 
	voucherid	voucher_id,
	vouchername	voucher_name,
	vouchertype voucher_type,
	vouchersource	voucher_source,
	voucherissuertype	voucher_issuer_type,
	voucherissuerdealer	voucher_issuer_dealer_id,
	--case when trim(voucherissuerdealer) rlike '^[0-9]{2}$|^[0-9]{5}$' or trim(voucherissuerdealer) like '%BWM%'	then trim(voucherissuerdealer) end voucher_issuer_dealer_id,
	vouchertypecontent	voucher_type_content,
	case when startdate >= '1949-01-01 00:00:00' and startdate<CURRENT_TIMESTAMP() then startdate end start_date,
	case when enddate >= '1949-01-01 00:00:00' and enddate<CURRENT_TIMESTAMP() then enddate end end_date,
	useterms	use_terms,
	servicecontent	service_content,
	case when createdate >= '1949-01-01 00:00:00' and createdate<CURRENT_TIMESTAMP() then createdate end create_date,
	day	fday
from source_membership2.member_coupon_template
--limit 1000
;


--dwc.dwc_fact_com_membership2_joy_coin_event_info_t 清洗规则
select
	id	id,
	cdpid	cdp_id,
	cdpidtype	cdp_id_type,
	userid	cop_id,
	useridtype	customer_id_type,
	case 
	when from_unixtime(cast(event_ts as bigint),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(cast(event_ts as bigint),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() 
	then from_unixtime(cast(event_ts as bigint),'yyyy-MM-dd HH:mm:ss') 
	end event_date,
	objectid	object_id,
	objecttype	object_type,
	placeid	place_id,
	placetype	place_type,
	eventid	event_id,
	gcid	gcid,
	startvalue	start_value,
	endvalue	end_value,
	changevalue	change_value,
	changetype	change_type,
	eventgroupcode	event_group_code,
	eventtypecode	event_type_code,
	eventgroup	event_group,
	eventtype	event_type,
	campaignid	campaign_id,
	channelid	channel_id,
	extent	extent,
	label	label,
	case
	when from_unixtime(cast(publish_ts as bigint),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(cast(publish_ts as bigint),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() 
	then from_unixtime(cast(publish_ts as bigint),'yyyy-MM-dd HH:mm:ss') 
	end publish_date,
	case
	when from_unixtime(cast(collect_ts as bigint),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(cast(collect_ts as bigint),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() 
	then from_unixtime(cast(collect_ts as bigint),'yyyy-MM-dd HH:mm:ss') 
	end collect_date,
	publisher	publisher,
	version	version_number,
	source	source,
	pday	pday,
	day	fday
from source_membership2.member_joy_coin_event_info
--limit 1000
;


--dwc.dwc_fact_cus_lp_downstream_form_useful_t 清洗规则
select
	interested_eseries_code,
	interested_eseries_name,
	address,
	answered_questionnaire,
	api_type,
	brand_code,
	campaign_id,
	campaign_name,
	channel_id,
	city,
	comment,
	create_date,
	customer_keyword,
	dealer_id,
	fday,
	first_contact_date,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else first_name_1 end first_name,
	channel_id1,
	campaign_id1,
	dealer_id1,
	w_code1,
	full_name,
	gender,
	policy_consents_interface_schema_version,
	case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else last_name_1 end last_name,
	lead_context,
	lead_source,
	leads_registration_date,
	leads_time,
	policy_consents_major_version,
	media_data_source,
	policy_consents_minor_version,
	mobile_phone_number,
	policy_id,
	province,
	rcid,
	region,
	text,
	policy_consents_timestamp,
	type,
	w_code
from (
select 
	z.*,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(first_name,last_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(first_name as string),2)	else first_name end first_name_1,
	case when first_name is not null and last_name is not null and first_name<>last_name then replace(last_name,first_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(last_name as string),1,1) when  first_name is null then last_name end last_name_1
from(
select 
	case 
		when x1.eseries_code is not null then x1.eseries_code
		when x1.eseries_code is null and x.eseries_code is not null then x.eseries_code
		else get_json_object(y.form_content,'$.formData.interestedModel') 
	end interested_eseries_code,
	get_json_object(form_content,'$.formData.interestedSeries')	interested_eseries_name,
	get_json_object(form_content,'$.formData.address')	address,
	get_json_object(form_content,'$.answeredQuestionnaire')	answered_questionnaire,
	api_type	api_type,
	CASE
		WHEN UPPER(trim(get_json_object(form_content,'$.request.brand'))) IN ('B','BMW') THEN 'BMW'
		WHEN UPPER(trim(get_json_object(form_content,'$.request.brand'))) IN ('C') OR UPPER(trim(get_json_object(form_content,'$.request.brand')))  LIKE ('%MOTOR%') THEN 'BMW Motorrad'
		WHEN UPPER(trim(get_json_object(form_content,'$.request.brand'))) IN ('M','MINI') THEN 'MINI'
		WHEN UPPER(trim(get_json_object(form_content,'$.request.brand'))) IN ('E','BMW I') THEN 'BMW i'
		WHEN UPPER(trim(get_json_object(form_content,'$.request.brand'))) IN ('N','ZINORO') THEN 'ZINORO'
	ELSE 'OTH' END brand_code,
	campaign_id	campaign_id,
	get_json_object(form_content,'$.campaignResponse.campaignName')	campaign_name,
	channel	channel_id,
	case 
		when b.city is not null then b.city
		when b.city is null and e.new_city is not null then e.new_city
		when b.city is null and REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.city'),"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")='' then null
		when get_json_object(y.form_content,'$.formData.city') is null then null
		else REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.city'),'[^\u4e00-\u9fa5]','')
	end city,
	get_json_object(form_content,'$.request.comment')	comment,
	case when create_time >= '1949-01-01 00:00:00' and create_time<CURRENT_TIMESTAMP() then create_time end create_date,
	get_json_object(form_content,'$.formData.customerKeyword')	customer_keyword,
	case when trim(dealer) rlike '^[0-9]{5}$' then trim(dealer) end dealer_id,
	day	fday,
	case 
		when length(get_json_object(form_content,'$.formData.firstContactDate'))=10 and get_json_object(form_content,'$.formData.firstContactDate') >= '1949-01-01 00:00:00' and get_json_object(form_content,'$.formData.firstContactDate')<CURRENT_TIMESTAMP() then concat(get_json_object(form_content,'$.formData.firstContactDate'),' 00:00:00')
		when length(get_json_object(form_content,'$.formData.firstContactDate'))=19 and get_json_object(form_content,'$.formData.firstContactDate') >= '1949-01-01 00:00:00' and get_json_object(form_content,'$.formData.firstContactDate')<CURRENT_TIMESTAMP() then get_json_object(form_content,'$.formData.firstContactDate')
		when length(get_json_object(form_content,'$.formData.firstContactDate'))=24 and get_json_object(form_content,'$.formData.firstContactDate') >= '1949-01-01 00:00:00' and get_json_object(form_content,'$.formData.firstContactDate')<CURRENT_TIMESTAMP() then from_unixtime(unix_timestamp(get_json_object(form_content,'$.formData.firstContactDate'), "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss')
	end first_contact_date,	
	REGEXP_REPLACE(trim(get_json_object(form_content,'$.formData.firstName')),"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	first_name,
	get_json_object(form_content,'$.channel')	channel_id1,
	get_json_object(form_content,'$.campaignResponse.campaignId')	campaign_id1,	
	case when trim(get_json_object(form_content,'$.formData.dealer')) rlike '^[0-9]{5}$' then trim(get_json_object(form_content,'$.formData.dealer')) end dealer_id1,
	get_json_object(form_content,'$.formData.wCode')	w_code1,
	get_json_object(form_content,'$.formData.fullName')	full_name,
	case 
		when trim(get_json_object(form_content,'$.formData.gender')) ='Company' then 'U'
		when trim(get_json_object(form_content,'$.formData.gender')) in ('0','else') then 'U'
		when trim(get_json_object(form_content,'$.formData.gender')) in ('1','先生','M 先生','M','MR.','M.','Male') then 'M'
		when trim(get_json_object(form_content,'$.formData.gender')) in ('2','女士','F 女士','F 小姐','MS','Ms','MS.','Ms.','Female') then 'F'
		when trim(get_json_object(form_content,'$.formData.gender')) is null or trim(get_json_object(form_content,'$.formData.gender'))='' then null
		else 'U'
	end gender,
	case
		when trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.interfaceSchemaVersion[0]')) <>'' and get_json_object(form_content,'$.request.policyConsents.policyConsents.interfaceSchemaVersion[0]') is not null 
		and trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.interfaceSchemaVersion[0]')) rlike '^[0-9]+$' then trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.interfaceSchemaVersion[0]'))
	end policy_consents_interface_schema_version,
	REGEXP_REPLACE(get_json_object(form_content,'$.formData.lastName'),"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") last_name,
	get_json_object(form_content,'$.campaignResponse.leadContext')	lead_context,
	get_json_object(form_content,'$.campaignResponse.leadSource')	lead_source,
	case when get_json_object(form_content,'$.formData.leadsRegistrationTime') >= '1949-01-01 00:00:00' and get_json_object(form_content,'$.formData.leadsRegistrationTime')<CURRENT_TIMESTAMP() then get_json_object(form_content,'$.formData.leadsRegistrationTime') end leads_registration_date,
	case when leads_time >= '1949-01-01 00:00:00' and leads_time<CURRENT_TIMESTAMP() then leads_time end leads_time,
	case
		when trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.majorVersion[0]')) <>'' and get_json_object(form_content,'$.request.policyConsents.policyConsents.majorVersion[0]') is not null and trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.majorVersion[0]')) rlike '^[0-9]+$' 
		then trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.majorVersion[0]'))
	end policy_consents_major_version,	
	get_json_object(form_content,'$.formData.mediaDataSource')	media_data_source,	
	case
		when trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.minorVersion[0]')) <>'' and get_json_object(form_content,'$.request.policyConsents.policyConsents.minorVersion[0]') is not null and trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.minorVersion[0]')) rlike '^[0-9]+$' 
		then trim(get_json_object(form_content,'$.request.policyConsents.policyConsents.minorVersion[0]'))
	end policy_consents_minor_version,	
	CASE 
		WHEN regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^\\+861[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=14 THEN REPLACE(regexp_replace(phone_number,"[^ 0-9]+",""),'+','')
		WHEN regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^861[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=13 THEN regexp_replace(phone_number,"[^ 0-9]+","")
		WHEN regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^1[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=11 THEN CONCAT('86',regexp_replace(phone_number,"[^ 0-9]+",""))
		when regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^01[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=12 THEN CONCAT('86',substr(regexp_replace(phone_number,"[^ 0-9]+",""),2))
	END mobile_phone_number,
	get_json_object(form_content,'$.request.policyConsents.policyConsents.policyId[0]')	policy_id,
	case
		when b.province is not null then b.province
		when b.province is null and c.province is not null then c.province
		when b.province is null and c.province is null and get_json_object(form_content,'$.formData.province') is null then NULL
		--else REGEXP_REPLACE(get_json_object(form_content,'$.formData.province'),'[^\u4e00-\u9fa5]','')
	end province,
	rcid	rcid,
	get_json_object(form_content,'$.formData.region')	region,
	get_json_object(form_content,'$.text')	text,
	case when from_unixtime(unix_timestamp(get_json_object(form_content,'$.request.policyConsents.policyConsents.timeStamp[0]'), "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') >= '1949-01-01 00:00:00' and from_unixtime(unix_timestamp(get_json_object(form_content,'$.request.policyConsents.policyConsents.timeStamp[0]'), "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss')<CURRENT_TIMESTAMP() then from_unixtime(unix_timestamp(get_json_object(form_content,'$.request.policyConsents.policyConsents.timeStamp[0]'), "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),'yyyy-MM-dd HH:mm:ss') end policy_consents_timestamp,
	type	type,
	wid	w_code
from source_lp.lp__formx__downstream_form_useful y
left join ods.ods_cdp_upload_eseries_code_map_t x
on substr(get_json_object(y.form_content,'$.formData.interestedModel'),1,3)=x.eseries_code
left join ods.ods_cdp_upload_eseries_code_map_t x1
on get_json_object(y.form_content,'$.formData.interestedModel')=x1.eseries_code
left join (select distinct province,city from raw.raw_upload_province_city_district_map_t where city is not null )b
on REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.city'),"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")=regexp_replace(b.city,"新区|区|市|自治州|地区","")
and REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.city'),"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and get_json_object(y.form_content,'$.formData.city') is not null
left join (select distinct province from raw.raw_upload_province_city_district_map_t where city is not null )c
on REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.province'),"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")=regexp_replace(c.province,"省|市|自治区|特别行政区","")
and get_json_object(y.form_content,'$.formData.province') is not null
and REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.province'),"[^\u4e00-\u9fa5]|省|市|自治区|特别行政区","")<>''
left join (select '塘沽' old_city,'滨海新区' new_city union all	select '崇文' old_city,'东城区' new_city union all	select '宣武' old_city,'西城区' new_city union all	select '巢湖' old_city,'合肥市' new_city union all	select '永康' old_city,'金华市' new_city union all	select '三河' old_city,'廊坊市' new_city union all	select '江阴' old_city,'无锡市' new_city union all	select '莱芜' old_city,'济南市' new_city union all	select '闸北' old_city,'静安区' new_city union all	select '任丘' old_city,'沧州市' new_city union all	select '慈溪' old_city,'宁波市' new_city union all	select '襄樊' old_city,'襄阳市' new_city union all	select '大港' old_city,'滨海新区' new_city union all	select '迁安' old_city,'唐山市' new_city union all	select '思茅' old_city,'普洱市' new_city union all	select '静海县' old_city,'静海区' new_city union all	select '晋州' old_city,'石家庄市' new_city union all	select '密云县' old_city,'密云区' new_city union all	select '莱芜' old_city,'济南市' new_city union all	select '卢湾' old_city,'黄浦区' new_city union all	select '余姚' old_city,'宁波市' new_city union all	select '蓟县' old_city,'蓟州区' new_city union all	select '太仓' old_city,'苏州市' new_city union all	select '崇明县' old_city,'崇明区' new_city union all	select '开县' old_city,'开州区' new_city union all	select '汉沽' old_city,'滨海新区' new_city union all	select '大足县' old_city,'大足区' new_city union all	select '思茅' old_city,'普洱市' new_city union all	select '璧山县' old_city,'璧山区' new_city)e
on REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.city'),"[^\u4e00-\u9fa5]|市|区","")=e.old_city
and REGEXP_REPLACE(get_json_object(y.form_content,'$.formData.city'),"[^\u4e00-\u9fa5]|新区|区|市|自治州|地区","")<>''
and get_json_object(y.form_content,'$.formData.city') is not null
)z)m;


--dwc.dwc_dim_cus_membership2_basic_info_t 清洗规则
select 
	gcid	gcid,
	copid	cop_id,
	CASE WHEN regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^\\+861[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=14 THEN REPLACE(regexp_replace(phone_number,"[^ 0-9]+",""),'+','')
		 WHEN regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^861[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=13 THEN regexp_replace(phone_number,"[^ 0-9]+","")
		 WHEN regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^1[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=11 THEN CONCAT('86',regexp_replace(phone_number,"[^ 0-9]+",""))
		 when regexp_replace(phone_number,"[^ 0-9]+","") REGEXP '^01[3-9][0-9]{9}$' AND LENGTH(regexp_replace(phone_number,"[^ 0-9]+",""))=12 THEN CONCAT('86',substr(regexp_replace(phone_number,"[^ 0-9]+",""),2))
	END mobile_phone_number,
	customerno	customer_number,
	case when activation_date >= '1949-01-01 00:00:00' and activation_date<CURRENT_TIMESTAMP() then activation_date end activation_date,
	--case when activation_status in('1','0') then activation_status end activation_status,
	activation_status	activation_status,
	client_type	client_type,
	case when mini_activation_date >= '1949-01-01 00:00:00' and mini_activation_date<CURRENT_TIMESTAMP() then mini_activation_date end mini_activation_date,
	--case when mini_activation_status in('1','0') then mini_activation_status end mini_activation_status,
	mini_activation_status	mini_activation_status,
	mini_client_type	mini_client_type,
	case when event_date >= '1949-01-01 00:00:00' and event_date<CURRENT_TIMESTAMP() then event_date end event_date,
	union_id	union_id,
	case when cdp_create_date >= '1949-01-01 00:00:00' and cdp_create_date<CURRENT_TIMESTAMP() then cdp_create_date end cdp_create_date,
	day	fday
from source_membership2.member_basic_info
--limit 1000
;


--dwc.dwc_dim_cus_cop_policy_t 清洗规则
SELECT
	id	id,
	policy_id	policy_id,
	version	version_number,
	zh_text	text,
	en_text	text_en,
	case when create_time >= '1949-01-01 00:00:00' and create_time<CURRENT_TIMESTAMP() then create_time end create_date,	--need confirm the type of date
	case 
		when create_time is not null and update_time is not null and create_time<=update_time and update_time<CURRENT_TIMESTAMP() then update_time
		when create_time is null and update_time is not null and update_time<CURRENT_TIMESTAMP() then update_time
	end modify_date,
	day	fday
from source_cop.cop__cop_db__policy
--limit 1000
;


--dwc_dim_com_dwh_tblcar_park_bas_t 清洗规则
with x as (select explode(split('114,246,247,248,259,600,700,E03,E09,E12,E21,E23,E24,E26,E28,E30,E31,E32,E34,E36,E38,E39,E46,E52,E53,E55,E59,E60,E61,E63,E64,E65,E66,E67,E68,E70,E71,E72,E81,E82,E83,E84,E85,E86,E87,E88,E89,E90,E91,E92,E93,EXX,F01,F02,F03,F04,F05,F06,F07,F10,F11,F12,F13,F15,F16,F18,F20,F21,F22,F23,F25,F26,F30,F31,F32,F33,F34,F35,F36,F39,F40,F44,F45,F46,F48,F49,F52,F54,F55,F56,F57,F60,F65,F66,F70,F74,F78,F80,F82,F83,F85,F86,F87,F90,F91,F92,F93,F95,F96,F97,F98,G01,G02,G05,G06,G07,G08,G08BEV,G09,G11,G12,G13,G14,G15,G16,G18,G20,G21,G22,G23,G26,G26BEV,G28,G28BEV,G29,G30,G31,G32,G38,G42,G60,G61,G68,G70,G73,G80,G82,G83,G87,I01,I12,I15,I20,K02,K03,K08,K09,K10,K14,K15,K16,K17,K18,K19,K21,K22,K23,K25,K26,K27,K28,K29,K30,K32,K33,K34,K35,K40,K41,K42,K43,K44,K45,K46,K47,K48,K49,K50,K51,K52,K53,K54,K60,K61,K63,K66,K67,K69,K70,K71,K72,K73,K75,K80,K81,K82,K83,K84,KXX,M12,M13,R13,R21,R22,R24,R25,R26,R27,R28,R50,R51,R52,R53,R55,R56,R57,R58,R59,R60,R61,R67,R68,R69,RXX,U06,U10,U11,U12,U25,VET',',')) as s_eseries_code)
select
	case when trim(chassisno) rlike "^[A-Za-z0-9]{17}$" then trim(chassisno) end vin_17,
	case when last_mileage<0 then null else last_mileage end last_mileage,
	case when car_age<0 then null else car_age end car_age,
	case 
		when x1.s_eseries_code is not null then x1.s_eseries_code
		when x1.s_eseries_code is null and x.s_eseries_code is not null then x.s_eseries_code
		else y.series
	end eseries_code,
	ckdcbu	ckd_cbu,
	start_warrq	warranty_start_quarter,
	max_series	max_eseries_code,
	last_invoiceid	last_invoice_id,
	veh_category	vehicle_category,
	start_warr_type	warranty_start_type,
	gray_market	gray_market,
	case
	    when TRIM(series_group) rlike '.*[1-9]{1}.*Series.*phev.*' or TRIM(series_group) rlike '.*[1-9]{1}.*系.*phev.*' then concat(regexp_replace(series_group,"[^1-9]",""),' Series Phev')
	    when TRIM(series_group) rlike '.*[1-9]{1}.*Series.*' or TRIM(series_group) rlike '.*[1-9]{1}.*系.*' then concat(regexp_replace(series_group,"[^1-9]",""),' Series')
	    when TRIM(series_group) rlike '.*X.*[1-7]{1}.*phev.*' then concat('X',regexp_replace(series_group,"[^1-7]",""),' Phev')
	    when TRIM(series_group) rlike '.*X.*[1-7]{1}.*M.*' then concat('X',regexp_replace(series_group,"[^1-7]",""),' M')
	    when TRIM(series_group) rlike '.*X.*[1-7]{1}' then concat('X',regexp_replace(series_group,"[^1-7]",""))
	    when TRIM(series_group) like '%MINI%三门版%' then 'MINI 三门版'
	    when TRIM(series_group) like '%MINI%五门版%' then 'MINI 五门版'
	    when TRIM(series_group) rlike '.*M.*[1-8]{1}.*' then concat('M',regexp_replace(series_group,"[^1-8]",""))
	    when TRIM(series_group) like '%iX%' then 'iX'
	    when TRIM(series_group) rlike '.*i.*[348]{1}.*' then concat('i',regexp_replace(series_group,"[^348]",""))
	    when TRIM(series_group) in ('BMW i','BMWi','I','i') then 'I'
	    when TRIM(series_group) like '%Countryman%' then 'Countryman'
	    when TRIM(series_group) like '%Clubman%' then 'Clubman'
	    when TRIM(series_group) like '%Cabrio%' then 'Cabrio'
	    when TRIM(series_group) like '%ZINORO%' then 'ZINORO'
	    when TRIM(series_group) in ('Z4 M','Z4M') then 'Z4 M'
	    when TRIM(series_group) rlike '.*Z.*[1348]{1}.*' then concat('Z',regexp_replace(series_group,"[^1348]",""))
	    else TRIM(series_group)
	end series_code,
	model_code	model_code,
	model_description	model_name,
	segments_of_car_age	segments_of_car_age,
	distribution	distribution_channel,
	case when start_warr >= '1949-01-01 00:00:00' and start_warr<CURRENT_TIMESTAMP() then start_warr end warranty_start_date,
	case when max_warr >= '1949-01-01 00:00:00' and max_warr<CURRENT_TIMESTAMP() then max_warr end warranty_end_date,
	case when last_visit_date >= '1949-01-01 00:00:00' and last_visit_date<CURRENT_TIMESTAMP() then last_visit_date end last_visit_date,
	case when prod_date >= '1949-01-01 00:00:00' and prod_date<CURRENT_TIMESTAMP() then prod_date end production_date,
	case when trim(dealerid) rlike '^[0-9]{5}$' then trim(dealerid) end dealer_id,
	case when trim(last_dealerid) rlike '^[0-9]{5}$' then trim(last_dealerid) end last_dealer_id,
	case when trim(retailed_dealer_id) rlike '^[0-9]{5}$' then trim(retailed_dealer_id) end retail_dealer_id
from source_dwh.a_tblcar_park_bas y
left join x
on substr(y.series,1,3)=x.s_eseries_code
left join x x1
on y.series=x1.s_eseries_code
--limit 1000
;




