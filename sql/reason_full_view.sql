create or replace view CANNABIS_DATA.PUBLIC.REASON_FULL(
	"year",
	"reason",
	"requested",
	"approved",
	"pct_approved_from_requested",
	"pct_approved_from_all_requests",
	"pct_approved_from_all_approved"
) as
select 
    "year",
    "reason",
    "requested",
    "approved",
     ROUND("approved" / "requested", 2) as "pct_approved_from_requested",
     ROUND("approved" / "all_requests", 2) as "pct_approved_from_all_requests",
     ROUND("approved" / "all_approved", 2) as "pct_approved_from_all_approved"
from 
    (select
        r."year",
        r."reason",
        r."request amount for renewal and new approved" as "requested",
        r."approved",
        s."sum_requests",
        s."sum_approved",
        SUM(r."request amount for renewal and new approved") OVER (partition by r."year") as "all_requests",
        SUM(r."approved") OVER (partition by r."year") as "all_approved"

        -- (select sum("request amount for renewal and new approved") from CANNABIS_DATA.RAW.REASON) 
        -- (select sum("") from CANNABIS_DATA.RAW.REASON) as "all_approved"

    from 
        CANNABIS_DATA.RAW.REASON as r

        left join 

        (select 
            "year",
            sum ("request amount for renewal and new approved") as "sum_requests",
            sum ("approved") as "sum_approved"
        from CANNABIS_DATA.RAW.REASON
        group by "year"
        ) as s

        on r."year" = s."year"
     
    order by r."year" asc, "requested" desc);