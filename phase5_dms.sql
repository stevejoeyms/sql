-- =========================================================================
-- Filename        : phase5 clean for dms test
-- Description     : the sql of phase5 clean for dms test
-- Author          : shangliangliang
-- =========================================================================
-- modify time: 2021-08-24 by joey


--dwc_fact_afs_dms_aftersales_invoice_t,
select
    case when trim(a.customerid) rlike "^[0-9A-Za-z]+$" then trim(a.customerid) end cutsomter_id,
    case 
        when a.invoicetype = '0' then concat('I',a.invoiceid)
        when a.invoicetype = '1' then concat('C',a.invoiceid)
        else a.invoiceid
    end invoice_id,
    case
        when trim(a.salespostcode) in ('GBP','DEM','RMB','USD','EUR','NAF','AWG') then null
        else SUBSTRING(trim(a.salespostcode),1,1) 
    end sale_post_code,
    '0' afs_customer_type,
    case
        when a.invoicetype = 0 then '80621001'
        when a.invoicetype = 1 then '80621002'
        else null
    end invoice_type,
    case when b.departcode is not null then '80531002' else '80531001' end as order_type,
    case 
        when trim(a.pass_order) = '1' then '10041001'
        when trim(a.pass_order) = '0' then '10041002'
        else '10041002'
    end	pass_order,
    case 
        when trim(a.three_r_status) = 'Y' then '10041001'
        when trim(a.three_r_status) = 'N' then '10041002'
        when trim(a.three_r_status) = '' then null
        when trim(a.three_r_status) is null then null
        else '10041002'
    end three_r_status,
    a.paymenttype	payment_type,
    a.camp_popups camp_popups,
    a.invoiceno	invoice_no,
    a.camp_done camp_done,
    case WHEN a.invoicetype = 1 then a.totalvaluegross/-1 else a.totalvaluegross end total_value_gross,
    case WHEN a.invoicetype = 1 then a.totalvaluenet/-1 else a.totalvaluenet end total_value_net,
    case 
        when b.departcode is not null then  replace(substr(a.orderdate,1,10),'-','')||'P'||a.orderno
        else replace(substr(a.orderdate,1,10),'-','')||'S'||a.orderno
    end order_no,
    a.servicecode3	service_code3,
    a.finishedby	finished_by_user_name,
    a.startedby	started_by_user_name,
    a.servicecode1	service_code1,
    a.customername	customer_name,
    a.serviceadvisor	service_advisor,
    a.servicecode2	service_code2,
    a.delayreason	delay_reason,
    a.cashier	cashier,
    a.three_r_repair_days	three_r_repair_days,
    case when a.invoicedate between '1949-01-01' and CURRENT_TIMESTAMP() then a.invoicedate end invoice_date,
    case when a.orderdate between '1949-01-01' and CURRENT_TIMESTAMP() then a.orderdate end order_date,
    case 
        when a.startdate is not null and a.finishdate between a.startdate and CURRENT_TIMESTAMP() then a.finishdate
        when a.startdate is  null and a.finishdate between '1949-01-01' and CURRENT_TIMESTAMP() then a.finishdate
    end finshdate_date,
    a.startdate	start_date,
    a.three_r_start_date	three_r_start_date,
    case 
        when a.three_r_start_date is not null and a.three_r_end_date between a.three_r_start_date and CURRENT_TIMESTAMP() then a.three_r_end_date
        when a.three_r_start_date is  null and a.three_r_end_date between '1949-01-01' and CURRENT_TIMESTAMP() then a.three_r_end_date
    end three_r_end_date,
    case when a.mileage >=0 then a.mileage end mileage,
    case when trim(a.chassisno) rlike "^[0-9a-zA-z]{17}$" then trim(a.chassisno) end chassis_no,
    CASE 
        WHEN a.make = 1 THEN  'BMW'
        WHEN a.make = 2 THEN  'BMW Motorrad'
        WHEN a.make = 7 THEN  'BMW I'
        WHEN a.make = 8 THEN  'MINI'
        WHEN a.make = 6 THEN  'ZINORO'
        WHEN a.make is null THEN null
        ELSE  'OTH' 
    END brand_code,
    a.parts_lead_time parts_lead_time,
    case
        when regexp_replace(front_right_brake_disc,'[^0-9.]','') = '' or REGEXP_REPLACE(front_right_brake_disc,'[0-9.]','') <> '' or front_right_brake_disc is null  then null
        when front_right_brake_disc rlike '\\.' then rpad(substr(front_right_brake_disc,1,instr(front_right_brake_disc,'.')+4),instr(front_right_brake_disc,'.')+4,'0')
        when front_right_brake_disc not rlike '\\.' then concat(front_right_brake_disc,'.0000')
    end front_right_brake_disc,
    case
        when regexp_replace(front_right_brake_pad,'[^0-9.]','') = '' or REGEXP_REPLACE(front_right_brake_pad,'[0-9.]','') <> '' or front_right_brake_pad is null  then null
        when front_right_brake_pad rlike '\\.' then rpad(substr(front_right_brake_pad,1,instr(front_right_brake_pad,'.')+4),instr(front_right_brake_pad,'.')+4,'0')
        when front_right_brake_pad not rlike '\\.' then concat(front_right_brake_pad,'.0000')
    end front_right_brake_pad,
    case
        when from_unixtime(cast(a.time_stamp/1000 as bigint),'yyyy-MM-dd HH:mm:ss') between '1949-01-01' and CURRENT_TIMESTAMP() then a.time_stamp
    end time_stamp,
    a.invoicemonth	invoice_month,
    case
        when regexp_replace(a.rear_right_brake_disc,'[^0-9.]','') = '' or REGEXP_REPLACE(a.rear_right_brake_disc,'[0-9.]','') <> '' or a.rear_right_brake_disc is null  then null
        when a.rear_right_brake_disc rlike '\\.' then rpad(substr(a.rear_right_brake_disc,1,instr(a.rear_right_brake_disc,'.')+4),instr(a.rear_right_brake_disc,'.')+4,'0')
        when a.rear_right_brake_disc not rlike '\\.' then concat(a.rear_right_brake_disc,'.0000')
    end rear_right_brake_disc,
    CASE 
        WHEN trim(a.update_flag)= 'Y' THEN '10041001' 
        WHEN trim(a.update_flag)= 'N' THEN '10041002'
        ELSE null 
    END update_flag,
    case when trim(invoiceyear) rlike '^\\d+$' then trim(invoiceyear) end invoice_year,
    case when trim(old_vin) rlike '^[0-9a-zA-Z]{17}$' then trim(old_vin) end old_vin,
    case when trim(a.dealerid) rlike '^[0-9]{5}$' then trim(a.dealerid) end dealer_id,
    case
        when regexp_replace(front_left_tyre,'[^0-9.]','') = '' or REGEXP_REPLACE(front_left_tyre,'[0-9.]','') <> '' or front_left_tyre is null  then null
        when front_left_tyre rlike '\\.' then rpad(substr(front_left_tyre,1,instr(front_left_tyre,'.')+4),instr(front_left_tyre,'.')+4,'0')
        when front_left_tyre not rlike '\\.' then concat(front_left_tyre,'.0000')
    end front_left_tyre,
    case
        when trim(currencycode) in ('GBP','DEM','RMB','USD','EUR','NAF','AWG') then trim(currencycode)
        else null
    end currency_code,
    case
        when regexp_replace(a.rear_left_brake_pad,'[^0-9.]','') = '' or REGEXP_REPLACE(a.rear_left_brake_pad,'[0-9.]','') <> '' or a.rear_left_brake_pad is null  then null
        when a.rear_left_brake_pad rlike '\\.' then rpad(substr(a.rear_left_brake_pad,1,instr(a.rear_left_brake_pad,'.')+4),instr(a.rear_left_brake_pad,'.')+4,'0')
        when a.rear_left_brake_pad not rlike '\\.' then concat(a.rear_left_brake_pad,'.0000')
    end rear_left_brake_pad,
    case
        when regexp_replace(a.front_left_brake_pad,'[^0-9.]','') = '' or REGEXP_REPLACE(a.front_left_brake_pad,'[0-9.]','') <> '' or a.front_left_brake_pad is null  then null
        when a.front_left_brake_pad rlike '\\.' then rpad(substr(a.front_left_brake_pad,1,instr(a.front_left_brake_pad,'.')+4),instr(a.front_left_brake_pad,'.')+4,'0')
        when a.front_left_brake_pad not rlike '\\.' then concat(a.front_left_brake_pad,'.0000')
    end front_left_brake_pad,
    case
        when regexp_replace(a.rear_right_tyre,'[^0-9.]','') = '' or REGEXP_REPLACE(a.rear_right_tyre,'[0-9.]','') <> '' or a.rear_right_tyre is null  then null
        when a.rear_right_tyre rlike '\\.' then rpad(substr(a.rear_right_tyre,1,instr(a.rear_right_tyre,'.')+4),instr(a.rear_right_tyre,'.')+4,'0')
        when a.rear_right_tyre not rlike '\\.' then concat(a.rear_right_tyre,'.0000')
    end rear_right_tyre,
    a.check_in_date	check_in_date,
    a.traffic_comp	traffic_comp,
    case
        when regexp_replace(front_left_brake_disc,'[^0-9.]','') = '' or REGEXP_REPLACE(front_left_brake_disc,'[0-9.]','') <> '' or front_left_brake_disc is null  then null
        when front_left_brake_disc rlike '\\.' then rpad(substr(front_left_brake_disc,1,instr(front_left_brake_disc,'.')+4),instr(front_left_brake_disc,'.')+4,'0')
        when front_left_brake_disc not rlike '\\.' then concat(front_left_brake_disc,'.0000')
    end front_left_brake_disc,
    a.three_r_end_time	three_r_end_time,
    a.starttime	start_time,
    case
        when regexp_replace(a.front_right_brake_pad,'[^0-9.]','') = '' or REGEXP_REPLACE(a.front_right_brake_pad,'[0-9.]','') <> '' or a.front_right_brake_pad is null  then null
        when a.front_right_brake_pad rlike '\\.' then rpad(substr(a.front_right_brake_pad,1,instr(a.front_right_brake_pad,'.')+4),instr(a.front_right_brake_pad,'.')+4,'0')
        when a.front_right_brake_pad not rlike '\\.' then concat(a.front_right_brake_pad,'.0000')
    end front_right_brake_pad,
    a.warr_invoice_date	warranty_invoice_date,
    a.finishtime	finish_time,
    case
        when regexp_replace(a.front_right_tyre,'[^0-9.]','') = '' or REGEXP_REPLACE(a.front_right_tyre,'[0-9.]','') <> '' or a.front_right_tyre is null  then null
        when a.front_right_tyre rlike '\\.' then rpad(substr(a.front_right_tyre,1,instr(a.front_right_tyre,'.')+4),instr(a.front_right_tyre,'.')+4,'0')
        when a.front_right_tyre not rlike '\\.' then concat(a.front_right_tyre,'.0000')
    end front_right_tyre,
    case when old_mileage >= 0 then old_mileage end old_mileage,
    a.packageno	package_no,
    a.import_id	import_id,
    a.fcs_id	fcs_id,
    a.three_r_start_time	three_r_start_time,
    case
        when regexp_replace(a.rear_left_tyre,'[^0-9.]','') = '' or REGEXP_REPLACE(a.rear_left_tyre,'[0-9.]','') <> '' or a.rear_left_tyre is null  then null
        when a.rear_left_tyre rlike '\\.' then rpad(substr(a.rear_left_tyre,1,instr(a.rear_left_tyre,'.')+4),instr(a.rear_left_tyre,'.')+4,'0')
        when a.rear_left_tyre not rlike '\\.' then concat(a.rear_left_tyre,'.0000')
    end rear_left_tyre,
    case when trim(a.vin_17) rlike '^[0-9A-Za-z]{17}$' then trim(a.vin_17) end	vin_17,
    case
        when regexp_replace(a.rear_left_brake_disc,'[^0-9.]','') = '' or REGEXP_REPLACE(a.rear_left_brake_disc,'[0-9.]','') <> '' or a.rear_left_brake_disc is null  then null
        when a.rear_left_brake_disc rlike '\\.' then rpad(substr(a.rear_left_brake_disc,1,instr(a.rear_left_brake_disc,'.')+4),instr(a.rear_left_brake_disc,'.')+4,'0')
        when a.rear_left_brake_disc not rlike '\\.' then concat(a.rear_left_brake_disc,'.0000')
    end rear_left_brake_disc,
    a.redempcode	redemp_code,
    a.invoice_time	invoice_time,
    a.create_time	create_time,
    a.correction_date	correction_date,
    case when a.deleted ='1' then '1' else '0' end deleted,
    a.sentflag	sent_flag,
    a.loyaltyid	loyalty_membership_id,
    a.warranty_invoiced_datetime	warranty_invoiced_date,
    a.creation_time	create_time1,
    a.traffic_compensation	traffic_compensation,
    a.fday	fday
from source_dms.a_dms_aftersales_invoice a
left join (select distinct dealerid,invoiceid,departcode from source_dms.a_dms_aftersales_invoice_items where departcode rlike 'P') b
on a.invoiceid=b.invoiceid
and a.dealerid=b.dealerid;


--dwc_fact_afs_dms_aftersales_invoice_items_t
select
    case
        when trim(a.flag) = 'I' then '80391009'
        when trim(a.flag) = 'A' then '80391004'
        when trim(a.flag) = 'D' then '80391008'
        else '80391001'
    end flag,
    CASE
        WHEN trim(a.DEPARTCODE)= 'A' THEN  '80031004'
        WHEN trim(a.DEPARTCODE)= 'B' THEN  '80031004'
        WHEN trim(a.DEPARTCODE)= 'M' THEN  '80031003'
        WHEN trim(a.DEPARTCODE)= 'P' THEN  'P'
        WHEN trim(a.DEPARTCODE)= 'E' THEN  '80031001'
        ELSE  '80031003'
    END depart_code,
    CASE
        WHEN trim(a.LINETYPE) = '4' and a.make in ('1','2','7','8','6') THEN '80001001'
        WHEN trim(a.LINETYPE) = '4' and a.make not in ('1','2','7','8','6') THEN '80001003'
        WHEN trim(a.LINETYPE) != '4' and trim(a.LABORSOURCE) = 'BM' THEN '80001001'
        WHEN trim(a.LINETYPE) != '4' and trim(a.LABORSOURCE) != 'BM'THEN '80001003'
        ELSE  NULL
    END labor_source,
    CASE
        WHEN trim(a.LINETYPE) = '3'  THEN '80641001'
        WHEN trim(a.LINETYPE) = '4'  THEN '80641002'
        WHEN trim(a.LINETYPE) = '5'  and trim(a.typecode)= 'V' THEN '80641004'
        WHEN trim(a.LINETYPE) = '5'  and trim(a.typecode)= 'S' THEN '80641005'
        WHEN trim(a.LINETYPE) = '6'  THEN '80641006'
        ELSE '80641003'
    END line_type,
    CASE
        WHEN trim(a.ceflag)= '1' THEN '10041001' 
        WHEN trim(a.ceflag)= '0'  THEN  '10041002' 
        ELSE '10041002' 
    END ce_flag,
    CASE
        WHEN trim(a.typecode)= 'A' THEN '10'
        WHEN trim(a.typecode)= 'B' THEN '20'
        WHEN trim(a.typecode)= 'C' THEN '30'
        WHEN trim(a.typecode)= 'D' THEN '10'
        WHEN trim(a.typecode)= 'E' THEN '40'
        WHEN trim(a.typecode)= 'H' THEN '40'
        WHEN trim(a.typecode)= 'G' THEN '50'
        WHEN trim(a.typecode)= 'I' THEN '60'
        WHEN trim(a.typecode)= 'F' THEN '45'
        ELSE NULL
    END type_code,
    a.taxcode	tax_code,
    a.stockleftqty	stock_left_qty,
    a.warrantyclaim	warranty_claim,
    a.retailprice	retail_price,
    a.stickerprice	sticker_price,
    a.cost	cost,
    a.ceqty	ceqty,
    a.technician	technician,
    case WHEN b.invoicetype = 1 then a.qty/-1 else a.qty end qty,
    a.contribution contribution,
    a.discount	discount,
    a.lineno	line_number,
    case WHEN b.invoicetype = 1 then a.totalamount/-1 else a.totalamount end totalatotal_amountmount,
    case 
        when b.invoicetype='0' then  'I'||a.invoiceid
        else 'C'||a.invoiceid
    end invoice_id,
    case when trim(a.lastinvoiceid) rlike '^[0-9a-zA-Z]+$' then trim(a.lastinvoiceid) end last_invoice_id,
    a.accountdesc	account_description,
    a.supplier	supplier,
    a.itemdescription	item_description,
    a.abccode	stock_assortment_classification,
    CASE
        WHEN make = '1' THEN  'BMW'
        WHEN make = '2' THEN  'BMW Motorrad'
        WHEN make = '7' THEN  'BMW I'
        WHEN make = '8' THEN  'MINI'
        WHEN make = '6' THEN  'ZINORO'
        WHEN make is null THEN null
        ELSE 'OTH' 
    END brand_code,
    a.grn	sublet_grn_number,
    a.itemtype	item_type,
    a.accountcode	account_code,
    case
        WHEN a.LINETYPE= '4' and SUBSTR(a.itemcode,1,1) not in ('Z') then regexp_replace(SUBSTR(trim(a.itemcode),1,100),'[.-/_ ]','')
        when a.LINETYPE= '4' and length(regexp_replace(trim(a.itemcode),'[.-/_ ]',''))<5 then rpad(regexp_replace(trim(a.itemcode),'[.-/_ ]',''),5,'0')
        when a.LINETYPE not in ('3','4') and typecode in ('Y','S' )and SUBSTR(a.itemcode,1,1) in ('S') then SUBSTR(a.itemcode,2,100)
        ELSE a.itemcode
    end item_code,
    a.decarded_time	decarded_time,
    CASE
        WHEN trim(a.LOAD_SKILL)= 'A' THEN  '80031004'
        WHEN trim(a.LOAD_SKILL)= 'B' THEN  '80031004'
        WHEN trim(a.LOAD_SKILL)= 'M' THEN  '80031003'
        WHEN trim(a.LOAD_SKILL)= 'P' THEN  'P'
        WHEN trim(a.LOAD_SKILL)= 'E' THEN  '80031001'
        ELSE  '80031003'
    END load_skill,
    a.clock_on_time	clock_on_time,
    a.familycode	family_code,
    a.insert_date	insert_date,
    case when trim(a.dealerid) rlike '^[0-9]{5}$' then trim(a.dealerid) end	dealer_id,
    v_invoice_year	v_invoice_year,
    case when a.clock_time < 0 then null else a.clock_time end clock_time,
    case
        when a.clock_on_date is not null and a.clock_off_date < a.clock_on_date then null
        else a.clock_off_date
    end clock_off_date,
    a.menu_code	menu_code,
    a.clock_off_time	clock_off_time,
    a.clock_on_date	clock_on_date,
    a.packageno	package_no,
    a.import_id	import_id,
    a.audit_num	audit_num,
    a.decarded_date	decarded_date,
    case when a.deleted in (0,1) then a.deleted end	deleted,
    a.sentflag	sent_flag,
    a.fday	fday
from source_dms.a_dms_aftersales_invoice_items a
left join (select distinct dealerid,invoiceid,invoicetype from source_dms.a_dms_aftersales_invoice) b
on a.invoiceid=b.invoiceid
and a.dealerid=b.dealerid;


--dwc_fact_sal_dms_handover_t
select
     customer_id
    ,connected_drive
    ,trade_vehicle_brand
    ,id_type
    ,contact_method
    ,pay_mode
    ,replace_information
    ,prospect_flag
    ,trade_type
    ,e_call_contact1_relationship
    ,e_call_contact1_last_name
	,case when nvl(new_e_call_contact1_last_name,'') in ('无','无无') and nvl(new_e_call_contact1_first_name,'') in ('无','无无')  then null else new_e_call_contact1_last_name end e_call_contact1_last_name
    ,e_call_contact2_relationship
	,case when nvl(new_e_call_contact3_last_name,'') in ('无','无无') and nvl(new_e_call_contact3_first_name,'') in ('无','无无')  then null else new_e_call_contact3_last_name end e_call_contact3_last_name
	,case when nvl(new_e_call_contact2_last_name,'') in ('无','无无') and nvl(new_e_call_contact2_first_name,'') in ('无','无无')  then null else new_e_call_contact2_last_name end e_call_contact2_last_name
    ,e_call_contact3_relationship
    ,retail_price
    ,case when nvl(new_e_call_contact1_last_name,'') in ('无','无无') and nvl(new_e_call_contact1_first_name,'') in ('无','无无')  then null else new_e_call_contact1_first_name end e_call_contact1_first_name
    ,case when nvl(new_e_call_contact3_last_name,'') in ('无','无无') and nvl(new_e_call_contact3_first_name,'') in ('无','无无')  then null else new_e_call_contact3_first_name end e_call_contact3_first_name
    ,case when nvl(new_e_call_contact2_last_name,'') in ('无','无无') and nvl(new_e_call_contact2_first_name,'') in ('无','无无')  then null else new_e_call_contact2_first_name end e_call_contact2_first_name
    ,term_service_expires_date
    ,uc_replace_model
    ,navigation_code
    ,uc_first_reg_date
    ,salesman_id
    ,contract_no
    ,uc_same_custom
    ,eseries_code
    ,item_code
    ,so_no
    ,invoice_no
    ,salesman_name
    ,remote_services_pin
    ,uc_replace_brand
    ,trade_in_flag
    ,contract_status
    ,uc_mileage
    ,purchase_date
    ,cancel_date
    ,create_date
    ,id_cert_expiration_d
    ,intended_purchase_date
    ,handover_date
    ,chassis_no
    ,e_call_contact2_phone
    ,e_call_contact3_phone
    ,e_call_contact1_phone
    ,id_number
    ,term_service_begins_date
    ,uch_warr_start_mileage
    ,uch_retail_rice
    ,time_stamp
    ,uch_retail_invoice_date
    ,dealer_id
    ,private_customer_id
    ,uch_warranty_end_date
    ,uch_warranty_end_mileage
    ,cd_communication_channel
    ,cd_home_region
    ,cust_stat
    ,uch_purchase_price
    ,uc_vin
    ,package_no
    ,uch_warranty_start_date
    ,import_id
    ,vehicle_source
    ,vin_17
    ,uch_stock_star_date
    ,uch_first_reg_date
    ,deleted
    ,sent_flag
    ,loyalty_id
    ,loyalty_card_id
    ,third_party_bank
    ,fday
from(
select
    a.*,
    case when e_call_contact1_first_name is not null and e_call_contact1_last_name is not null and e_call_contact1_first_name<>e_call_contact1_last_name then replace(e_call_contact1_first_name,e_call_contact1_last_name,'') when e_call_contact1_first_name is not null and e_call_contact1_last_name is not null and e_call_contact1_first_name=e_call_contact1_last_name then SUBSTRING(cast(e_call_contact1_first_name as string),2)	else e_call_contact1_first_name end new_e_call_contact1_first_name,
    case when e_call_contact3_first_name is not null and e_call_contact3_last_name is not null and e_call_contact3_first_name<>e_call_contact3_last_name then replace(e_call_contact3_first_name,e_call_contact3_last_name,'') when e_call_contact3_first_name is not null and e_call_contact3_last_name is not null and e_call_contact3_first_name=e_call_contact3_last_name then SUBSTRING(cast(e_call_contact3_first_name as string),2)	else e_call_contact3_first_name end new_e_call_contact3_first_name,
    case when e_call_contact2_first_name is not null and e_call_contact2_last_name is not null and e_call_contact2_first_name<>e_call_contact2_last_name then replace(e_call_contact2_first_name,e_call_contact2_last_name,'') when e_call_contact2_first_name is not null and e_call_contact2_last_name is not null and e_call_contact2_first_name=e_call_contact2_last_name then SUBSTRING(cast(e_call_contact2_first_name as string),2)	else e_call_contact2_first_name end new_e_call_contact2_first_name,
	case when e_call_contact1_first_name is not null and e_call_contact1_last_name is not null and e_call_contact1_first_name<>e_call_contact1_last_name then replace(e_call_contact1_last_name,e_call_contact1_first_name,'') when e_call_contact1_first_name is not null and e_call_contact1_last_name is not null and e_call_contact1_first_name=e_call_contact1_last_name then SUBSTRING(cast(e_call_contact1_last_name as string),1,1) when  e_call_contact1_first_name is null then e_call_contact1_last_name end new_e_call_contact1_last_name,
	case when e_call_contact3_first_name is not null and e_call_contact3_last_name is not null and e_call_contact3_first_name<>e_call_contact3_last_name then replace(e_call_contact3_last_name,e_call_contact3_first_name,'') when e_call_contact3_first_name is not null and e_call_contact3_last_name is not null and e_call_contact3_first_name=e_call_contact3_last_name then SUBSTRING(cast(e_call_contact3_last_name as string),1,1) when  e_call_contact3_first_name is null then e_call_contact3_last_name end new_e_call_contact3_last_name,
	case when e_call_contact2_first_name is not null and e_call_contact2_last_name is not null and e_call_contact2_first_name<>e_call_contact2_last_name then replace(e_call_contact2_last_name,e_call_contact2_first_name,'') when e_call_contact2_first_name is not null and e_call_contact2_last_name is not null and e_call_contact2_first_name=e_call_contact2_last_name then SUBSTRING(cast(e_call_contact2_last_name as string),1,1) when  e_call_contact2_first_name is null then e_call_contact2_last_name end new_e_call_contact2_last_name
from(
select
    case when trim(klantnr) rlike '^[0-9]+$' then trim(klantnr) end	customer_id,
    case when trim(connecteddrive) in ('Y','N') then trim(connecteddrive) end connected_drive,
    tradeveh	trade_vehicle_brand,
    id_cert_type	id_type,
    extn1	contact_method,
    case when paym in ('0','1','3','4','5','6','7','8','9') then paym end	pay_mode,
    rep_int	replace_information,
    pros_flag	prospect_flag,
    trim(new_used)	trade_type,
    relsecallp1	e_call_contact1_relationship,
	REGEXP_REPLACE(name1ecallp1,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") e_call_contact1_last_name,
    relsecallp2	e_call_contact2_relationship,
	REGEXP_REPLACE(name1ecallp3,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") e_call_contact3_last_name,
	REGEXP_REPLACE(name1ecallp2,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","") e_call_contact2_last_name,
    relsecallp3	e_call_contact3_relationship,
    cast(trim(ret_price) as bigint)/100 retail_price,
	REGEXP_REPLACE(name2ecallp1,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	e_call_contact1_first_name,
	REGEXP_REPLACE(name2ecallp3,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	e_call_contact3_first_name,
	REGEXP_REPLACE(name2ecallp2,"[^\u4e00-\u9fa5a-zA-Z]|先生|女士|教授|经理|副经理|总经理|经理|总监|老师|小姐|姐|太太|大哥|哥|兄|总|夫人|科长|司机|贵宾|朋友|大爷|老公|老婆|丈夫|儿子|老爸|包工头|地址|客户不留","")	e_call_contact2_first_name,
    case 
        when term_service_begins is not null and term_service_expires >= term_service_begins then term_service_expires 
        when term_service_begins is null and term_service_expires between '1949-01-01' and current_timestamp() then term_service_expires 
        end term_service_expires_date,
    uc_replacemodel	uc_replace_model,
    extn2	navigation_code,
    uc_firstreg	uc_first_reg_date,
    soldby_dms_id	salesman_id,
    contractno	contract_no,
    uc_samecustom	uc_same_custom,
    eser	eseries_code,
    itemcode	item_code,
    order_no	so_no,
    invoice_no	invoice_no,
    soldby	salesman_name,
    pin_cd	remote_services_pin,
    uc_replacebrand	uc_replace_brand,
    tradein	trade_in_flag,
    contract_status	contract_status,
    case when uc_mileage >= 0 then uc_mileage end	uc_mileage,
    case when purchase_d between '1949-01-01' and CURRENT_TIMESTAMP() then purchase_d end	purchase_date,
    case when cancel_d is not null and cancel_d <>'' then cancel_d end cancel_date,
    case when cre_date between '1949-01-01' and CURRENT_TIMESTAMP() then cre_date end	create_date,
    case when id_cert_expiration_d between '1949-01-01' and CURRENT_TIMESTAMP() then id_cert_expiration_d end	id_cert_expiration_d,
    case when int_purch between '1949-01-01' and CURRENT_TIMESTAMP() then int_purch end intended_purchase_date,
    case when handover_d is not null and handover_d <>'' then handover_d end handover_date,
    case when trim(chassis) rlike '^[0-9A-Za-z]{17}$' then trim(chassis) end	chassis_no,
	case 
		when regexp_replace(phoneecallp2,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phoneecallp2,'[^-0-9]',''),instr(regexp_replace(phoneecallp2,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(phoneecallp2,'[^0-9]','')
		when regexp_replace(phoneecallp2,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phoneecallp2,'[^-0-9]',''),instr(regexp_replace(phoneecallp2,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(phoneecallp2,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phoneecallp2,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phoneecallp2,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phoneecallp2,"[^+0-9]","")
		WHEN regexp_replace(phoneecallp2,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phoneecallp2,"[^+0-9]",""))
		when regexp_replace(phoneecallp2,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phoneecallp2,"[^+0-9]",""),2))
		when regexp_replace(phoneecallp2,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phoneecallp2,"[^+0-9]",""),2)
		when length(regexp_replace(phoneecallp2,"[^0-9]",""))>20 or length(regexp_replace(phoneecallp2,"[^0-9]",""))<7 then null
		else regexp_replace(phoneecallp2,'[^0-9]','')
	end e_call_contact2_phone,
	case 
		when regexp_replace(phoneecallp3,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phoneecallp3,'[^-0-9]',''),instr(regexp_replace(phoneecallp3,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(phoneecallp3,'[^0-9]','')
		when regexp_replace(phoneecallp3,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phoneecallp3,'[^-0-9]',''),instr(regexp_replace(phoneecallp3,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(phoneecallp3,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phoneecallp3,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phoneecallp3,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phoneecallp3,"[^+0-9]","")
		WHEN regexp_replace(phoneecallp3,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phoneecallp3,"[^+0-9]",""))
		when regexp_replace(phoneecallp3,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phoneecallp3,"[^+0-9]",""),2))
		when regexp_replace(phoneecallp3,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phoneecallp3,"[^+0-9]",""),2)
		when length(regexp_replace(phoneecallp3,"[^0-9]",""))>20 or length(regexp_replace(phoneecallp3,"[^0-9]",""))<7 then null
		else regexp_replace(phoneecallp3,'[^0-9]','')
	end e_call_contact3_phone,
	case 
		when regexp_replace(phoneecallp1,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phoneecallp1,'[^-0-9]',''),instr(regexp_replace(phoneecallp1,'[^-0-9]',''),'-')+1))<=8 then regexp_replace(phoneecallp1,'[^0-9]','')
		when regexp_replace(phoneecallp1,'[^-0-9]','') rlike '-' and length(substr(regexp_replace(phoneecallp1,'[^-0-9]',''),instr(regexp_replace(phoneecallp1,'[^-0-9]',''),'-')+1))>8 then null
		WHEN regexp_replace(phoneecallp1,"[^+0-9]","") REGEXP '^\\+861[3-9][0-9]{9}$' THEN REPLACE(regexp_replace(phoneecallp1,"[^+0-9]",""),'+','')
		WHEN regexp_replace(phoneecallp1,"[^+0-9]","") REGEXP '^861[3-9][0-9]{9}$' THEN regexp_replace(phoneecallp1,"[^+0-9]","")
		WHEN regexp_replace(phoneecallp1,"[^+0-9]","") REGEXP '^1[3-9][0-9]{9}$' THEN CONCAT('86',regexp_replace(phoneecallp1,"[^+0-9]",""))
		when regexp_replace(phoneecallp1,"[^+0-9]","") REGEXP '^01[3-9][0-9]{9}$' THEN CONCAT('86',substr(regexp_replace(phoneecallp1,"[^+0-9]",""),2))
		when regexp_replace(phoneecallp1,"[^+0-9]","") REGEXP '^0861[3-9][0-9]{9}$' THEN substr(regexp_replace(phoneecallp1,"[^+0-9]",""),2)
		when length(regexp_replace(phoneecallp1,"[^0-9]",""))>20 or length(regexp_replace(phoneecallp1,"[^0-9]",""))<7 then null
		else regexp_replace(phoneecallp1,'[^0-9]','')
	end e_call_contact1_phone,    
	case 
		when trim(id_cert_number) rlike '^\\d{17}[0-9Xx]$' and concat(substr(trim(id_cert_number),7,4),'-',substr(trim(id_cert_number),11,2),'-',substr(trim(id_cert_number),13,2)) between '1900-01-01' and CURRENT_DATE() 
		then concat(substr(trim(id_cert_number),1,17),upper(substr(trim(id_cert_number),-1,1)))
	end id_number,
    case when term_service_begins is not null and term_service_begins <>'' then term_service_begins end term_service_begins_date,
    uch_warrstartmileage	uch_warr_start_mileage,
    uch_retailprice	uch_retail_rice,
    time_stamp	time_stamp,
    case when uch_retailinvoicedate is not null and uch_retailinvoicedate <>'' then uch_retailinvoicedate end uch_retail_invoice_date,
    case when trim(dealerid) rlike '^[0-9]{5}$' then trim(dealerid) end	dealer_id,
	private_customer_id private_customer_id,
    case 
        when uch_warrstartdate is not null and uch_warrenddate >= uch_warrstartdate then uch_warrenddate 
        when uch_warrstartdate is null and uch_warrenddate between '1949-01-01' and current_timestamp() then uch_warrenddate 
    end uch_warranty_end_date,
    uch_warrendmileage	uch_warranty_end_mileage,
    cd_communication_channel	cd_communication_channel,
    cd_home_region	cd_home_region,
    cust_stat	cust_stat,
    uch_purchaseprice	uch_purchase_price,
    case when uc_vin rlike '^[0-9A-Za-z]{17}$' then uc_vin end	uc_vin,
    packageno	package_no,
    case when uch_warrstartdate is not null and uch_warrstartdate <>'' then uch_warrstartdate end uch_warranty_start_date,
    import_id	import_id,
    vehiclesource	vehicle_source,
    case when vin_17 rlike '^[0-9A-Za-z]{17}$' then vin_17 end	vin_17,
    case when uch_stockstartdate is not null and uch_stockstartdate <>'' then uch_stockstartdate end uch_stock_star_date,
    case when uch_firstregdate is not null and uch_firstregdate <>'' then uch_firstregdate end uch_first_reg_date,
    deleted	deleted,
    sentflag	sent_flag,
    loyaltyid	loyalty_id,
    loyalty_card_id	loyalty_card_id,
    three_r_party_bank	third_party_bank,
    fday	fday
from source_dms.a_dms_handover
)a)b;


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