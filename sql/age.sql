create or replace view CANNABIS_DATA.PUBLIC.AGE(
	"year",
	"age",
	"requested",
	"pct_approved_from_all_requests"
) as

select
    "year",
    "age",
    "requested",
     ROUND("requested" / "all_requests", 2) as "pct_approved_from_all_requests"
from
    (select
        r."year",
        r."reason" as "age",
        r."request amount for renewal and new approved" as "requested",
        s."sum_requests",
        SUM(r."request amount for renewal and new approved") OVER (partition by r."year") as "all_requests"
    from
        CANNABIS_DATA.RAW.AGE as r
        left join
        (select
            "year",
            sum ("request amount for renewal and new approved") as "sum_requests"
        from CANNABIS_DATA.RAW.AGE
        group by "year"
        ) as s
        on r."year" = s."year"
    order by r."year" asc, "requested" desc);