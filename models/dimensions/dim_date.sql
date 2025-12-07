with date_range as (
    select
        day as full_date
    from unnest(generate_date_array(date '2005-01-01', date '2030-12-31')) as day
),
dim as (
    select
        full_date,
        cast(format_date('%Y%m%d', full_date) as int64) as date_id,
        extract(day from full_date) as day,
        extract(month from full_date) as month,
        extract(year from full_date) as year,
        extract(week from full_date) as week,
        case when extract(dayofweek from full_date) in (1,7) then true else false end as is_weekend,
        format_date('%B', full_date) as month_name,
        concat('Q', cast(extract(quarter from full_date) as string)) as quarter
    from date_range
)
select * from dim
