--dwc_dim_cus_dmo2_customer_company_t
select
 t1.id customer_company_id,
 t2.company_code dealer_id,
 t1.customer_id customer_id,
 t1.company_id company_id,
 t1.customer_company_role_code customer_company_role_code,
 t1.primary_flag primary_flag,
 case when trim(t1.user_created_id) rlike '^\\d+$' then trim(t1.user_created_id) end create_user_id,
 case when t1.time_created between '1949-01-01' and CURRENT_TIMESTAMP() then t1.time_created end create_date,
 t1.user_modified_id modify_user_id,
 case
     when t1.time_created is not null and t1.time_modified >= t1.time_created then t1.time_modified
     when t1.time_created is null and t1.time_modified <= CURRENT_TIMESTAMP() then t1.time_modified
 end modify_date,
 t1.version_no version_number,
 t1.day fday
from  source_dmo_v2.dmo2__customer_db__customer_company t1
left join source_dmo_v2.dmo2__user__t_company t2
on t1.dealership_id = t2.id;