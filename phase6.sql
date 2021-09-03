-- =========================================================================
-- Filename :phase6_test_clean.sql
-- Description : phase6的测试清洗
-- Author : shangliangliang joey
-- =========================================================================
--Change Log
--



--dwc_dim_cus_dmo2_customer_t
select
	case	
		WHEN regexp_replace(phone_number_sub1,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone_number_sub1,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phone_number_sub1,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone_number_sub1,"[^+0-9]","")
		WHEN regexp_replace(phone_number_sub1,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone_number_sub1,"[^+0-9]",""))
		when regexp_replace(phone_number_sub1,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone_number_sub1,"[^+0-9]",""),2))
		when regexp_replace(phone_number_sub1,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone_number_sub1,"[^+0-9]",""),2)
	end phone_number1,
	case	
		WHEN regexp_replace(phone_number_sub2,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone_number_sub2,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phone_number_sub2,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone_number_sub2,"[^+0-9]","")
		WHEN regexp_replace(phone_number_sub2,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone_number_sub2,"[^+0-9]",""))
		when regexp_replace(phone_number_sub2,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone_number_sub2,"[^+0-9]",""),2))
		when regexp_replace(phone_number_sub2,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone_number_sub2,"[^+0-9]",""),2)
	end phone_number2
from source_dmo_v2.dmo2__customer_db__customer;


--dwc_dim_cus_carmen_l_contact_cn_t
select
	x_emp_postal_code	t1_x_emp_postal_code
from source_carmen.a_carmen_s_contact;


--dwc_fact_sal_dmo2_t_opportunity_info_t
select
	t1.id	id,
	tenant_id	tenant_id,
	t2.company_code dealer_id,
	customer_id	customer_id,
 	t3.spark_id spark_id,
	main_leads_id	main_leads_id,
	biz_code	biz_code,
	priority_level_code	priority_level_code,
	star_level	star_level,
	channel_code	channel_code,
	t1.campaign_id	campaign_id,
	case when next_follow_time > '1949-01-01' then next_follow_time end next_follow_date,
	case when last_follow_time between '1949-01-01' and CURRENT_TIMESTAMP() then next_follow_time end last_follow_date,
	CASE
		WHEN UPPER(brand_code) IN ('B','BMW') THEN 'BMW'
		WHEN UPPER(brand_code) IN ('C') OR UPPER(brand_code) LIKE '%MOTOR%' THEN 'BMW Motorrad'
		WHEN UPPER(brand_code) IN ('M','MINI') THEN 'MINI'
		WHEN UPPER(brand_code) IN ('E','BMW I') THEN 'BMW i'
		WHEN UPPER(brand_code) IN ('N','ZINORO') THEN 'ZINORO'
		ELSE 'OTH'
	END brand_code,
	confirm_user_id	confirm_user_id,
	follow_user_id	follow_user_id,
	creator_id	create_user_id,
	case when opportunity_time between '1949-01-01' and CURRENT_TIMESTAMP() then opportunity_time end	opportunity_date,
	case when fresh_time > '1949-01-01' then fresh_time end	fresh_date,
	is_compet	is_compet,
	privacy_level_code	privacy_level_code,
	leads_source_code	leads_source_code,
	create_type_code	create_type_code,
	expected_buy_time_code	expected_buy_time_code,
	budget_floor	budget_floor,
	budget_ceiling	budget_ceiling,
	t1.first_name	first_name,
	t1.last_name	last_name,
	case	
		when regexp_replace(t1.phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(t1.phone,"[^+0-9]",""),'+','')
		when regexp_replace(t1.phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(t1.phone,"[^+0-9]","")
		when regexp_replace(t1.phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(t1.phone,"[^+0-9]",""))
		when regexp_replace(t1.phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(t1.phone,"[^+0-9]",""),2))
		when regexp_replace(t1.phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(t1.phone,"[^+0-9]",""),2)
	end	mobile_phone_number,
	case	
		when regexp_replace(second_phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(second_phone,"[^+0-9]",""),'+','')
		when regexp_replace(second_phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(second_phone,"[^+0-9]","")
		when regexp_replace(second_phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(second_phone,"[^+0-9]",""))
		when regexp_replace(second_phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(second_phone,"[^+0-9]",""),2))
		when regexp_replace(second_phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(second_phone,"[^+0-9]",""),2)
	end mobile_phone_number1,
	case	
		when regexp_replace(third_phone,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(third_phone,"[^+0-9]",""),'+','')
		when regexp_replace(third_phone,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(third_phone,"[^+0-9]","")
		when regexp_replace(third_phone,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(third_phone,"[^+0-9]",""))
		when regexp_replace(third_phone,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(third_phone,"[^+0-9]",""),2))
		when regexp_replace(third_phone,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(third_phone,"[^+0-9]",""),2)
	end mobile_phone_number2,
	avatar	avatar,
	case 
		when UPPER(trim(t1.gender_code)) like "先生|男|MALE|MR" OR UPPER(trim(t1.gender_code)) in ('M','M.') then 'M'
		when UPPER(trim(t1.gender_code)) like "女|FEMALE|MS" OR UPPER(trim(t1.gender_code)) in ('F','F.') then 'F'
		else 'U'
	end gender,
	province_code	province_id,
	city_code	city_id,
	area_code	region_id,
	t1.wechat_id	wechat_id,
	case 
		when length(REGEXP_REPLACE(t1.email,'[^@]',''))=0 or length(REGEXP_REPLACE(t1.email,'[^.]',''))=0 then null
		when length(REGEXP_REPLACE(substr(t1.email,instr(t1.email,'@')),'[^.]',''))=0 then null
		when length(substr(reverse(t1.email),1,instr(reverse(t1.email),'.')-1))<2 then null
		when t1.email rlike '\\.comcn$' then REGEXP_REPLACE(t1.email,'\\.comcn$','.com.cn') 
		else t1.email
	end email_address,
	address	address,
	comment	remarks,
	case when t1.create_date between '1949-01-01' and CURRENT_TIMESTAMP() then t1.create_date end	create_date,
	create_user_id	create_user_id,
	case
		when t1.create_date is not null and t1.modify_date between t1.create_date and CURRENT_TIMESTAMP() then t1.modify_date
		when t1.create_date is null and t1.modify_date <= CURRENT_TIMESTAMP() then t1.modify_date
	end modify_date,
	t1.modify_user_id	modify_user_id,
	leads_status	leads_status,
	opportunity_status	opportunity_status,
	take_status	take_status,
	recall_status	recall_status,
	leads_info_source_code	leads_info_source_code,
	company_id	company_id,
	sub_channel_code	sub_channel_code,
	rebuy	rebuy,
	priority_level_weights	priority_level_weights,
	opportunity_source_code	opportunity_source_code,
	opportunity_source_sub_code	opportunity_source_sub_code,
	hand_over_mark	handover_mark,
	lead_of_bdc	lead_of_bdc,
	case when t1.active in ('1','0') then t1.active end	deleted,
	order_refund_car	order_refund_car,
	t1.day	fday
from source_dmo_v2.dmo2__sales_bdc__t_opportunity_info t1
left join ods.ods_dmo2_user_t_company_t t2
on t1.dealership_id = t2.id
left join source_dmo_v2.dmo2__customer_db__customer t3
on t1.customer_id = t3.id
and nvl(t3.active,'1')=1;


--dwc_fact_sal_dmo2_t_opportunity_model_t清洗规则
select
    a.id id
    ,a.tenant_id tenant_id
    ,b.company_code dealer_id
    ,a.opportunity_id opportunity_id
    ,a.car_type_code car_type_code
    ,CASE 
        WHEN UPPER(trim(a.brand_code)) IN ('B','BMW') THEN 'BMW'
        WHEN UPPER(trim(a.brand_code)) IN ('C') OR UPPER(trim(a.brand_code)) LIKE '%MOTOR%' THEN 'BMW Motorrad'
        WHEN UPPER(trim(a.brand_code)) IN ('M','MINI') THEN 'MINI'
        WHEN UPPER(trim(a.brand_code)) IN ('E','BMW I') THEN 'BMW i'
        WHEN UPPER(trim(a.brand_code)) IN ('N','ZINORO') THEN 'ZINORO'
        WHEN c.brand_name is not null then c.brand_name
    end brand_code
    ,case 
        when a.brand_code like 'brand%' then d.max_name
        when a.brand_code not like 'brand%' and (a.serial_code rlike '.*[1-9].*(Series).*(phev).*' or a.serial_code rlike '.*[1-9].*[系].*[phev].*') then concat(regexp_extract(a.serial_code,'[1-9]',0),' Series Phev')
        when a.brand_code not like 'brand%' and (a.serial_code rlike '.*[1-9].*(Series).*' or a.serial_code rlike '.*[1-9].*[系].*') then concat(regexp_extract(a.serial_code,'[1-9]',0),' Series')
        when a.brand_code not like 'brand%' and a.serial_code rlike '.*[X].*[1-7].*(phev).*' then concat('X',regexp_extract(a.serial_code,'[1-7]',0),' Phev')
        when a.brand_code not like 'brand%' and a.serial_code rlike '.*[X].*[1-7].*[M]].*' then concat('X',regexp_extract(a.serial_code,'[1-7]',0),' M')
        when a.brand_code not like 'brand%' and a.serial_code rlike '.*[X].*[1-7].*' then concat('X',regexp_extract(a.serial_code,'[1-7]',0))
        when a.brand_code not like 'brand%' and a.serial_code rlike '(MINI 三门版)' then '3-doors'
        when a.brand_code not like 'brand%' and a.serial_code rlike '(MINI 五门版)' then '5-doors'
        when a.brand_code not like 'brand%' and a.serial_code rlike '.*[M].*[1-8].*' then concat('M',regexp_extract(a.serial_code,'[1-8]',0))
        when a.brand_code not like 'brand%' and a.serial_code rlike '(iX3)' then 'iX3'
        when a.brand_code not like 'brand%' and a.serial_code rlike '(iX)' then 'iX'
        when a.brand_code not like 'brand%' and a.serial_code rlike '.*[i].*[348].*' then concat('i',regexp_extract(a.serial_code,'[348]',0))
        when a.brand_code not like 'brand%' and a.serial_code rlike '(BMW i)|(BMWi)|(I)|(i)' then 'I'
        when a.brand_code not like 'brand%' and a.serial_code='MINI' THEN 'MINI'
        when a.brand_code not like 'brand%' and a.serial_code rlike '(Countryman|Clubman|Cabrio|ZINORO)' then regexp_extract(a.serial_code,'(Countryman|Clubman|Cabrio|ZINORO)',0)
        when a.brand_code not like 'brand%' and a.serial_code rlike '(Z4 M)|(Z4M)' THEN 'Z4M'
        when a.brand_code not like 'brand%' and a.serial_code rlike '.*Z.*[1348].*' then concat('Z',regexp_extract(a.serial_code,'[1348]',0))
        when a.brand_code not like 'brand%' and a.serial_code rlike '[1-9].*' THEN CONCAT(regexp_extract(a.serial_code,'[1-9]',0),' Series')
        when a.brand_code not like 'brand%' and a.serial_code rlike '(ZER|Zer|zer|zER)' then 'Z' 
        else a.serial_code
    end series_code
    ,case 
        when a.model_code rlike '(series-)' and e.model_name is not null then e.model_name
        when a.model_code rlike '(series-)' and e.model_name is null then a.model_code
        when a.model_code not rlike '(series-)' and a.model_code rlike '^[a-zA-Z]\\d{2}' then a.model_code
        else null
    end eseries_code
    ,case 
        when a.variant_code rlike '(-n)' then f.variant_name
        when a.variant_code not rlike '(-n)' and g.variant_code is not null then rpad(g.variant_code,9,'0')
        when a.variant_code not rlike '(-n)' and g.variant_code is null then a.variant_code
    end variant_code
    ,a.color_code exterior_color
    ,a.inner_color_code interior_color
    ,case when a.is_active=0 then 1 when a.is_active=1 then 0 end deleted
    ,case when a.create_date between '1949-01-01' and current_timestamp() then a.create_date end create_date
    ,case 
        when a.create_date is not null and a.modify_date between a.create_date and current_timestamp() then a.modify_date 
        when a.create_date is null and a.modify_date < current_timestamp() then a.modify_date 
    end modify_date
    ,a.modify_user_id modify_user_id
    ,a.day fday
from source_dmo_v2.dmo2__sales_bdc__t_opportunity_model a
left join ods.ods_dmo2_user_t_company_t b
on a.dealership_id=b.id
left join (select distinct upper(trim(brand_code))brand_code,brand_name from ods.ods_dmo2_vehicle_t_second_car_model_info_t) c
on upper(trim(a.brand_code))=c.brand_code
left join (select trim(series_code)series_code,max(series_name)max_name from ods.ods_dmo2_vehicle_t_second_car_model_info_t group by trim(series_code))d
on trim(a.serial_code)=d.max_name
left join (select distinct trim(model_code)model_code,model_name from ods.ods_dmo2_vehicle_t_second_car_model_info_t)e
on trim(a.model_code)=e.model_code
left join (select distinct trim(variant_code)variant_code,variant_name from ods.ods_dmo2_vehicle_t_second_car_model_info_t)f
on trim(a.variant_code)=f.variant_code
left join (select distinct trim(id)id,trim(variant_code)variant_code from ods.ods_dmo2_vehicle_t_second_car_model_info_t)g
on trim(a.variant_code)=g.id;


--dwc_fact_com_dmo2_test_drive_t
select
	t1.id	id,
	t2.company_code dealer_id,
	customer_id	customer_id,
	t3.spark_id spark_id,
	opportunity_id	opportunity_id,
	customer_contact_id	customer_contact_id,
	snpsht_document_id	snpsht_document_id,
	snpsht_agreement_id	snpsht_agreement_id,
	case when is_customer_driver in (0,1) then is_customer_driver end	is_customer_driver,
	executive_user_id	executive_user_id,
	from_mileage	from_mileage,
	to_mileage	to_mileage,
	driving_mileage	driving_mileage,
	case when start_time between '1949-01-01' and CURRENT_TIMESTAMP() then start_time end	start_date,
	case
		when start_time is not null and end_time between start_time and CURRENT_TIMESTAMP() then end_time
		when start_time is null and end_time <= CURRENT_TIMESTAMP() then end_time
	end end_date,
	driving_time	driving_time,
	avg_speed	avg_speed,
	t1.remark	remarks,
	agreement_file_id	agreement_file_id,
	survey_filled_id	survey_filled_id,
	case when t1.active in (1,0) then t1.active end	deleted,
	t1.user_created_id	create_user_id,
	case when t1.time_created between '1949-01-01' and CURRENT_TIMESTAMP() then t1.time_created end	create_date,
	t1.user_modified_id	modify_user_id,
	case
		when t1.time_created is not null and t1.time_modified between t1.time_created and CURRENT_TIMESTAMP() then t1.time_modified
		when t1.time_created is null and t1.time_modified <= CURRENT_TIMESTAMP() then t1.time_modified
	end	modify_date,
	t1.version_no	version_number,
	t1.test_drive_status	test_drive_status,
	t1.day	fday
from source_dmo_v2.dmo2__contact_db__test_drive t1
left join  ods.ods_dmo2_user_t_company_t t2
on t1.dealership_id = t2.id
left join source_dmo_v2.dmo2__customer_db__customer t3
on t1.customer_id = t3.id
and nvl(t3.active,'1')=1;


--dwc_fact_com_dmo2_test_drive_snpsht_doc_t 清洗规则
select
    id
    ,dealer_id
    ,sales_consultant
    ,spark_route_id
    ,route_name
    ,route_describe
    ,spark_vehicle_id
    ,vin_17
    ,license_plate_number
    ,brand_name
    ,series_name
    ,model_name
    ,variant_name
    ,driver_id
    ,driver_cert_type
    ,driver_cert_number
    ,driver_front_picture_id
    ,driver_back_picture_id
    ,driver_cert_valid_start_date
    ,driver_cert_valid_end_date
    ,driver_address
	,case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else first_name_1 end first_name
    ,case when nvl(last_name_1,'') in ('无','无无') and nvl(first_name_1,'') in ('无','无无')  then null else last_name_1 end last_name
    ,gender
    ,mobile_phone_number
    ,birth_date
    ,nationality
    ,driver_license_class
    ,driver_first_issue_date
    ,language
    ,create_user_id
    ,create_date
    ,route_urls
    ,route_time
    ,route_mileage
    ,test_drive_total_mileage
    ,brand_code
    ,new_series_code series_code
    ,eseries_code
    ,variant_code
    ,eseries_name
    ,model_code
    ,fday
from(
select
    x.*
    ,case when first_name is not null and last_name is not null and first_name<>last_name then replace(first_name,last_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(first_name as string),2)	else first_name end first_name_1
	,case when first_name is not null and last_name is not null and first_name<>last_name then replace(last_name,first_name,'') when first_name is not null and last_name is not null and first_name=last_name then SUBSTRING(cast(last_name as string),1,1) when  first_name is null then last_name end last_name_1
    ,case 
        when series_code rlike '.*[1-9].*(Series).*(phev).*' or series_code rlike '.*[1-9].*[系].*[phev].*' then concat(regexp_extract(series_code,'[1-9]',0),' Series Phev')
        when series_code rlike '.*[1-9].*(Series).*' or series_code rlike '.*[1-9].*[系].*' then concat(regexp_extract(series_code,'[1-9]',0),' Series')
        when series_code rlike '.*[X].*[1-7].*(phev).*' then concat('X',regexp_extract(series_code,'[1-7]',0),' Phev')
        when series_code rlike '.*[X].*[1-7].*[M]].*' then concat('X',regexp_extract(series_code,'[1-7]',0),' M')
        when series_code rlike '.*[X].*[1-7].*' then concat('X',regexp_extract(series_code,'[1-7]',0))
        when series_code rlike '(MINI 三门版)' then '3-doors'
        when series_code rlike '(MINI 五门版)' then '5-doors'
        when series_code rlike '.*[M].*[1-8].*' then concat('M',regexp_extract(series_code,'[1-8]',0))
        when series_code rlike '(iX3)' then 'iX3'
        when series_code rlike '(iX)' then 'iX'
        when series_code rlike '.*[i].*[348].*' then concat('i',regexp_extract(series_code,'[348]',0))
        when series_code rlike '(BMW i)|(BMWi)|(I)|(i)' then 'I'
        when series_code='MINI' THEN 'MINI'
        when series_code rlike '(Countryman|Clubman|Cabrio|ZINORO)' then regexp_extract(series_code,'(Countryman|Clubman|Cabrio|ZINORO)',0)
        when series_code rlike '(Z4 M)|(Z4M)' THEN 'Z4M'
        when series_code rlike '.*Z.*[1348].*' then concat('Z',regexp_extract(series_code,'[1348]',0))
        when series_code rlike '[1-9].*' THEN CONCAT(regexp_extract(series_code,'[1-9]',0),' Series')
        when series_code rlike '(ZER|Zer|zer|zER)' then 'Z' 
        else series_code
    end new_series_code
from (
select
    a.id id
    ,b.company_code dealer_id
    ,a.sales_consultant sales_consultant
    ,a.spark_route_id spark_route_id
    ,a.route_name route_name
    ,a.route_describe route_describe
    ,a.spark_vehicle_id spark_vehicle_id
    ,case when trim(a.vehicle_vin) rlike '^[a-zA-Z0-9]{17}$' then trim(a.vehicle_vin) end vin_17
    ,case 
		when length(trim(a.vehicle_plate_number))<=8
		and substr(trim(a.vehicle_plate_number),1,1) in ('京','津','冀','晋','蒙','辽','吉','黑','沪','苏','浙','皖','闽','赣','鲁','豫','鄂','湘','粤','桂','琼','川','贵','云','渝','藏','陕','甘','青','宁','新','港','澳','台','军','空','海','北','沈','兰','济','南','广','成')
		and substr(trim(a.vehicle_plate_number),2,1) rlike '([a-z]|[A-Z])+' 
		and (substr(trim(a.vehicle_plate_number),length(trim(a.vehicle_plate_number))-5,6) rlike '^[A-Za-z0-9]+$' or substr(trim(a.vehicle_plate_number),length(trim(a.vehicle_plate_number))-4,5) rlike '^[A-Za-z0-9]+$' ) then trim(a.vehicle_plate_number) 
    end license_plate_number
    ,a.vehicle_brand_name brand_name
    ,a.vehicle_series_name series_name
    ,a.vehicle_model_name model_name
    ,a.vehicle_package_name variant_name
    ,a.driver_id driver_id
    ,a.driver_cert_type driver_cert_type
    ,a.driver_cert_number driver_cert_number
    ,a.driver_front_picture_id driver_front_picture_id
    ,a.driver_back_picture_id driver_back_picture_id
    ,case when a.driver_cert_valid_from between '1949-01-01' and current_timestamp() then a.driver_cert_valid_from end driver_cert_valid_start_date
    ,case 
        when a.driver_cert_valid_from is not null and a.driver_cert_valid_to between a.driver_cert_valid_from and current_timestamp() then a.driver_cert_valid_to 
        when a.driver_cert_valid_from is null and a.driver_cert_valid_to > '1949-01-01' then a.driver_cert_valid_to 
    end driver_cert_valid_end_date
    ,a.driver_address driver_address
    ,REGEXP_REPLACE(a.driver_first_name,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	first_name
	,REGEXP_REPLACE(a.driver_last_name,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") last_name
    ,case 
		when trim(a.driver_gender_code) ='Company' then 'U'
		when trim(a.driver_gender_code) in ('0','else') then 'U'
		when trim(a.driver_gender_code) in ('1','先生','M 先生','M','MR.','M.','Male') then 'M'
		when trim(a.driver_gender_code) in ('2','女士','F 女士','F 小姐','MS','Ms','MS.','Ms.','Female') then 'F'
		when trim(a.driver_gender_code) is null or a.driver_gender_code='' then null
		else 'U'
	end gender
    ,case	
        WHEN regexp_replace(a.driver_phone_number,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(a.driver_phone_number,"[^+0-9]",""),'+','')
        WHEN regexp_replace(a.driver_phone_number,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(a.driver_phone_number,"[^+0-9]","")
        WHEN regexp_replace(a.driver_phone_number,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(a.driver_phone_number,"[^+0-9]",""))
        when regexp_replace(a.driver_phone_number,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(a.driver_phone_number,"[^+0-9]",""),2))
        when regexp_replace(a.driver_phone_number,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(a.driver_phone_number,"[^+0-9]",""),2)
    end mobile_phone_number
    ,case when a.driver_birth_date>'1900-01-01' then concat(a.driver_birth_date,' 08:00:00') end birth_date
    ,case when c.code is not null then c.code end nationality
    ,a.driver_license_class driver_license_class
    ,case when a.driver_first_issue_date between '1949-01-01' and current_timestamp() then a.driver_first_issue_date end driver_first_issue_date
    ,a.locale language
    ,a.user_created_id create_user_id
    ,case when a.time_created between '1949-01-01' and current_timestamp() then a.time_created end create_date
    ,a.route_urls route_urls
    ,a.route_time route_time
    ,a.route_mileage route_mileage
    ,a.test_drive_total_mileage test_drive_total_mileage
    ,CASE 
        WHEN UPPER(a.vehicle_brand_code) IN ('1','B','BMW') THEN 'BMW'
        WHEN UPPER(a.vehicle_brand_code) IN ('3','C') OR UPPER(a.vehicle_brand_code) LIKE '%MOTOR%' THEN 'BMW Motorrad'
        WHEN UPPER(a.vehicle_brand_code) IN ('2','M','MINI') THEN 'MINI'
        WHEN UPPER(a.vehicle_brand_code) IN ('E','BMW I') THEN 'BMW i'
        WHEN UPPER(a.vehicle_brand_code) IN ('N','ZINORO') THEN 'ZINORO'
        ELSE 'OTH'
    END brand_code
    ,case when trim(a.vehicle_series_code) rlike '^[0-9]{4}$' then d.series_code else a.vehicle_series_code end series_code
    ,case when a.vehicle_eseries_code rlike '^[0-9]{4}$' and e.body_group_id is not null then e.body_group_id else a.vehicle_eseries_code end eseries_code 
    ,case when f.variant_code is not null then rpad(f.variant_code,9,'0') else rpad(a.vehicle_package_code,9,'0') end variant_code
    ,a.vehicle_eseries_name eseries_name
    ,case when g.model_code is not null then g.model_code else a.vehicle_model_code end model_code
    ,a.day fday
from source_dmo_v2.dmo2__contact_db__test_drive_snpsht_doc a
left join ods.ods_dmo2_user_t_company_t b
on a.dealership_id=b.id
left join ods.ods_upload_country_map_f c
on (upper(a.driver_nationality) = c.code or a.driver_nationality = c.value_zh)
left join (select series_id,series_code,row_number()over(partition by series_id order by id desc)rn from ods.ods_dmo2_vehicle_t_new_car_model_info_t) d 
on a.vehicle_series_code=d.series_id and d.rn=1
left join (select distinct body_group_id,body_group_code from ods.ods_dmo2_vehicle_t_new_car_model_info_t)e
on a.vehicle_eseries_code=e.body_group_id
left join (select distinct variant_code,variant_id from ods.ods_dmo2_vehicle_t_new_car_model_info_t)f
on a.vehicle_package_code=f.variant_id
left join (select distinct model_id,model_code from ods.ods_dmo2_vehicle_t_new_car_model_info_t)g
on a.vehicle_model_code=g.model_id
)x)y;


--dwc_fact_com_dmo2_test_drive_snpsht_ag_t
select
	t1.id	id,
	t2.company_code dealer_id,
	common_agreement_id	common_agreement_id,
	common_agreement_content	common_agreement_content,
	dealership_agreement_id	dealership_agreement_id,
	dealership_agreement_content	dealership_agreement_content,
	signature_file_id	signature_file_id,
	user_created_id	create_user_id,
	case when time_created between '1949-01-01' and CURRENT_TIMESTAMP() then time_created end	create_date,
	t1.day	fday
from source_dmo_v2.dmo2__contact_db__test_drive_snpsht_ag t1
left join ods.ods_dmo2_user_t_company_t t2
ON T1.dealership_id=T2.id
;


--dwc_fact_afs_tsp_v_cn_dwh_key_data_cbs_t
select
	remaining_time_unit	remaining_time_unit,
	identifier	identifier,
	description	description,
	remaining_distance_unit	remaining_distance_unit,
	description_lang	description_language,
	cbs_state	cbs_state,
	remaining_time	remaining_time,
	id	id,
	key_data_id	key_data_id,
	remaining_distance	remaining_distance,
	case
		when create_time is not null and update_time between create_time and update_time then update_time
		when create_time is null and update_time <= CURRENT_TIMESTAMP() then update_time
	end modify_date,
	day	day,
	case when create_time between '1949-01-01' and CURRENT_TIMESTAMP() then create_time end	create_date,
	fday	fday
from source_tssb.a_tsp_v_cn_dwh_key_data_cbs;


--dwc_fact_afs_tsp_v_cn_dwh_ticket_info_t
select
	a.ticket_id	ticket_id,
	a.ticket_state_tssb	ticket_state_tssb,
	b.dealerid	dealer_id,
	case when a.ticket_creation_date between '1949-01-01' and CURRENT_TIMESTAMP() then a.ticket_creation_date end	ticket_create_date,
	a.ticket_state	ticket_state,
	a.escalated_ticket	escalated_ticket,
	case when a.ticket_escalation_date between '1949-01-01' and CURRENT_TIMESTAMP() then a.ticket_escalation_date end	ticket_escalation_date,
	a.average_distance	average_distance,
	a.e_series	eseries_code,
	case 
		when e.eseries_code is not null then e.eseries_code
		when e.eseries_code is null and d.eseries_code is not null then d.eseries_code
		else a.e_series
	end eseries_code,
	a.ticket_state_reason	ticket_state_reason,
	a.average_distance_unit	average_distance_unit,
	CASE 
        WHEN UPPER(a.brand) IN ('1','B','BMW') THEN 'BMW'
        WHEN UPPER(a.brand) IN ('3','C') OR UPPER(a.brand) LIKE '%MOTOR%' THEN 'BMW Motorrad'
        WHEN UPPER(a.brand) IN ('2','M','MINI') THEN 'MINI'
        WHEN UPPER(a.brand) IN ('E','BMW I') THEN 'BMW i'
        WHEN UPPER(a.brand) IN ('N','ZINORO') THEN 'ZINORO'
        ELSE 'OTH'
    END brand_code,
	a.ticket_type	ticket_type,
	case when a.ticket_acceptance_date between '1949-01-01' and CURRENT_TIMESTAMP() then a.ticket_acceptance_date end	ticket_acceptance_date,
    case when c.code is not null then c.code end country,
	a.call_data_id	call_data_id,
	a.total_distance	total_distance,
	a.key_data_id	key_data_id,
	case when trim(a.vin) rlike '^[a-zA-Z0-9]{7}$' then trim(a.vin) end vin_7,
	a.i_level_plant	i_level_plant,
	substr(trim(a.model_code),-4)	model_code,
	substr(trim(a.model_code),-5,1)	model_name,
	a.average_distance_display	average_distance_display,
	a.total_distance_unit	total_distance_unit,
	a.vin_17	vin_17,
	a.day	day,
	a.i_level_ho	i_level_ho,
	a.fday	fday
from source_tssb.a_tsp_v_cn_dwh_ticket_info a
left join ods.ods_cdp_db_afs_tssb_dealer_mapping_f b
on a.dealer=b.tssb_dealer
left join ods.ods_upload_country_map_f c
on (upper(a.country_code) like '%'||c.code||'%' or upper(a.country_code) like '%'||c.value_zh||'%')
left join ods.ods_cdp_upload_eseries_code_map_t d
on substr(a.e_series,1,3)=d.eseries_code
left join ods.ods_cdp_upload_eseries_code_map_t e
on a.e_series=e.eseries_code;


--dwc_dim_com_membership2_coupon_template_t
select
	voucher_id
	,voucher_name
	,voucher_code
	,voucher_type
	,business_purpose
	,brand_code
	,claim_method
	,if_reserve
	,tier_limit
	,tier_limit_name
	,series_limit
	,voucher_status
	,approval_status
	,if_voucher_center
	,voucher_source
	,voucher_issuer_type
	,voucher_issuer_dealer
	,voucher_type_content
	,start_date
	,end_date
	,use_terms
	,service_content
	,create_date
	,modify_date
	,fday
from(
select
	voucherid	voucher_id,
	vouchername	voucher_name,
	vouchercode	voucher_code,
	vouchertype	voucher_type,
	businesspurpose	business_purpose,
	brand	brand_code,
	claimmethod	claim_method,
	ifreserve	if_reserve,
	tierlimit	tier_limit,
	tierlimitname	tier_limit_name,
	serieslimit	series_limit,
	voucherstatus	voucher_status,
	approvalstatus	approval_status,
	ifvouchercenter	if_voucher_center,
	vouchersource	voucher_source,
	voucherissuertype	voucher_issuer_type,
	voucherissuerdealer	voucher_issuer_dealer,
	vouchertypecontent	voucher_type_content,
	startdate	start_date,
	enddate	end_date,
	useterms	use_terms,
	servicecontent	service_content,
	createdate	create_date,
	updatedate	modify_date,
	day	fday,
	row_number()over(partition by voucherid order by day desc ,updatedate desc)rn
from source_membership2.member_coupon_template
)x where rn=1;

--dwc_dim_cus_membership2_basic_info_t
select
	gcid
	,cop_id
	,mobile_phone_number
	,customer_number
	,activation_date
	,activation_status
	,client_type
	,client_type_cn
	,mini_activation_date
	,mini_activation_status
	,mini_client_type
	,mini_client_type_cn
	,event_date
	,union_id
	,cdp_create_date
	,fday
from(
select
	gcid	gcid,
	copid	cop_id,
	case	
		when regexp_replace(phone_number,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phone_number,"[^+0-9]",""),'+','')
		when regexp_replace(phone_number,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phone_number,"[^+0-9]","")
		when regexp_replace(phone_number,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phone_number,"[^+0-9]",""))
		when regexp_replace(phone_number,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phone_number,"[^+0-9]",""),2))
		when regexp_replace(phone_number,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phone_number,"[^+0-9]",""),2)
	end mobile_phone_number,
	customerno	customer_number,
	case when activation_date between '1949-01-01' and CURRENT_TIMESTAMP() then activation_date end	activation_date,
	activation_status	activation_status,
	client_type	client_type,
	case when clienttypecn = 'NULL' then null end	client_type_cn,
	mini_activation_date	mini_activation_date,
	mini_activation_status	mini_activation_status,
	mini_client_type	mini_client_type,
	case when miniclienttypecn = 'NULL' then null end	mini_client_type_cn,
	event_date	event_date,
	union_id	union_id,
	cdp_create_date	cdp_create_date,
	day	fday,
	row_number()over(partition by nvl(copid,gcid) order by day desc,event_date desc,cdp_create_date desc)rn
from source_membership2.member_basic_info
)x where rn=1;


/* 改为phase8上线
--dwc_dim_cus_cms_user_points_t
select
	copid	cop_id,
	level	level,
	points	points,
	pushtime	push_time,
	newtime	new_time
from source_cms.user_points;
*/


--dwc_fact_com_casa_contract_data_t
select
	product_id	product_id,
	contract_type	contract_type,
	sales_type	sales_type,
	customer_id	customer_id,
	default_person	default_person,
	global_contract_id	global_contract_id,
	case when trim(vin_17) rlike '^[0-9A-Za-z]{17}$' then trim(vin_17) end	vin_17,
	global_offer_id	global_offer_id,
	master_offer_id	master_offer_id,
	case when start_date > '1949-01-01' then start_date end	start_date,
	case
		when start_date is not null and end_date between start_date and CURRENT_TIMESTAMP() then end_date
		when start_date is null and end_date > '1949-01-01' then end_date
	end end_date,
	status	status,
	case when create_time between '1949-01-01' and CURRENT_TIMESTAMP() then create_time end	create_date,
	case
		when create_time is not null and update_time between create_time and CURRENT_TIMESTAMP() then update_time
		when create_time is null and update_time <= CURRENT_TIMESTAMP() then update_time
	end modify_date
from source_casa.a_casa_contract_data;

--dwc_fact_com_miaozhen_mybmw_tracking_log_t
select
	log_type	log_type,
	request_type	request_type,
	site_id	site_id,
	uuid	uuid,
	visitor_id	visitor_id,
	title	title,
	event_category	event_category,
	event_label	event_label,
	event_action	event_action,
	event_value	event_value,
	custom_action_id	custom_action_id,
	custom_action_label	custom_action_label,
	custom_action_value	custom_action_value,
	custom_dimension	custom_dimension,
	custom_metric	custom_metric,
	is_first_start_up	is_first_start_up,
	dpl_event	dpl_event,
	raw_idfa	raw_idfa,
	raw_oaid	raw_oa_id,
	raw_adid	raw_ad_id,
	md5_imei	md5_imei,
	md5_mac	md5_mac,
	promotion_name	promotion_name,
	sdk_version	sdk_version_number,
	device_model	device_model,
	device_brand	device_brand,
	app_version	app_version_number,
	os_type	os_type,
	ios_version	ios_version_number,
	network_type	network_type,
	mz_campaign_id	mz_campaign_id,
	mz_spot_id	mz_spot_id,
	ip	ip,
	`timestamps` `timestamp`,
	dt	data_date
from ods.ods_miaozhen_mybmw_tracking_log_t;


--dwc_dim_com_cdp_gpf_vin_list_t
select
	case when vin_17 rlike '^[0-9A-Za-z]{17}$' then vin_17 end	vin_17,
	attribute1	attribute1,
	attribute2	attribute2
from ods.ods_upload_gpf_vin_list_f;
