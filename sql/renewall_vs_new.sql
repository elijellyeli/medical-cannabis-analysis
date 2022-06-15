create or replace view CANNABIS_DATA.PUBLIC.RENEWALL_VS_NEW_VIEW(
	"year",
	"status",
	"request amount for renewal and new",
	"approved",
	"percentage_approved",
	"not_approved",
	"percentage_not_approved"
) as
select 
    "year",
    "status", 
    "request amount for renewal and new",
    "approved",
    "approved" / "request amount for renewal and new" as "percentage_approved",
    "request amount for renewal and new" - "approved" as "not_approved",
    1 - "approved" / "request amount for renewal and new" as "percentage_not_approved"
    
from 
    CANNABIS_DATA.RAW.RENEWALL_VS_NEW;