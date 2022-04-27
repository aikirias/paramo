

-- 1ST 
WITH ingredients AS (
SELECT 
	a.order_id,
	a.pizza_id, 
	c.value as ingredients
FROM [dbo].[Orders] a
INNER JOIN [dbo].[Pizza] b ON a.pizza_id=b.id
CROSS APPLY STRING_SPLIT(TRIM(b.ingredients), ',') c

--where order_time >= dateadd(month, -6, getdate())
where a.order_time >= '2021-03-11 19:45:29.000' -- In production we should use the previous line, but because this dataset has no data at that time im using the last 6 months since the last order
),
extras as (
SELECT 
	a.order_id,
	a.pizza_id,
	CAST(
		CASE b.value 
			WHEN '' THEN NULL 
			WHEN 'null' THEN NULL
		ELSE b.value END 
	AS INT) as ingredients
FROM [dbo].[Orders] a
CROSS APPLY STRING_SPLIT(TRIM(a.extras),',') b
WHERE 
	b.value not in ('','null') and b.value is not null
	--and order_time >= dateadd(month, -6, getdate())
	and a.order_time >= '2021-03-11 19:45:29.000' -- In production we should use the previous line, but because this dataset has no data at that time im using the last 6 months since the last order
),
exclusions as (
SELECT 
	a.order_id,
	a.pizza_id,
	-CAST(
		CASE b.value 
			WHEN '' THEN NULL 
			WHEN 'null' THEN NULL
		ELSE b.value END 
	AS INT) as ingredients
FROM [dbo].[Orders] a
CROSS APPLY STRING_SPLIT(TRIM(a.exclusions),',') b
WHERE 
	b.value not in ('','null') and b.value is not null
	--and order_time >= dateadd(month, -6, getdate())
	and a.order_time >= '2021-03-11 19:45:29.000' -- In production we should use the previous line, but because this dataset has no data at that time im using the last 6 months since the last order
),
union_all as (
SELECT * FROM ingredients
UNION ALL
SELECT * FROM extras
UNION ALL
SELECT * FROM exclusions
) 

SELECT 
	'New_pizza_name' as name,
	string_agg(ingredients, ',') 
		within group (order by ingredients asc) ingredients
FROM 
(
	SELECT TOP 5
		ABS(ingredients) as ingredients, 
		sum(CASE WHEN ingredients < 0 THEN -1 ELSE 1 END) total
	FROM union_all
	GROUP BY ABS(ingredients)
	ORDER BY total DESC
) final






-- 2ND
WITH ingredients AS (
SELECT 
	a.ordered_pizza,
	a.order_id,
	a.pizza_id, 
	c.value as ingredients
FROM (SELECT ROW_NUMBER() over(order by order_id, pizza_id, exclusions, extras, order_time) as ordered_pizza, orders.* FROM [dbo].[Orders] as orders) a
INNER JOIN [dbo].[Pizza] b ON a.pizza_id=b.id
CROSS APPLY STRING_SPLIT(TRIM(b.ingredients), ',') c

),
extras as (
SELECT 
	a.ordered_pizza,
	a.order_id,
	a.pizza_id,
	CAST(
		CASE b.value 
			WHEN '' THEN NULL 
			WHEN 'null' THEN NULL
		ELSE b.value END 
	AS INT) as ingredients
FROM (SELECT ROW_NUMBER() over(order by order_id, pizza_id, exclusions, extras, order_time) as ordered_pizza, orders.* FROM [dbo].[Orders] as orders) a
CROSS APPLY STRING_SPLIT(TRIM(a.extras),',') b
WHERE 
	b.value not in ('','null') and b.value is not null
),
exclusions as (
SELECT 
	a.ordered_pizza,
	a.order_id,
	a.pizza_id,
	-CAST(
		CASE b.value 
			WHEN '' THEN NULL 
			WHEN 'null' THEN NULL
		ELSE b.value END 
	AS INT) as ingredients
FROM (SELECT ROW_NUMBER() over(order by order_id, pizza_id, exclusions, extras, order_time) as ordered_pizza, orders.* FROM [dbo].[Orders] as orders) a
CROSS APPLY STRING_SPLIT(TRIM(a.exclusions),',') b
WHERE 
	b.value not in ('','null') and b.value is not null
),
union_all as (
SELECT * FROM ingredients
UNION ALL
SELECT * FROM extras
UNION ALL
SELECT * FROM exclusions
) ,
ingredients_by_pizza as (
	SELECT 
		ordered_pizza,
		order_id,
		pizza_id,
		ABS(ingredients) as ingredients, 
		sum(CASE WHEN ingredients < 0 THEN -1 ELSE 1 END) total
	FROM union_all a
	GROUP BY 
		ABS(ingredients),
		ordered_pizza,
		order_id,
		pizza_id
	--ORDER BY total DESC
)

SELECT  
	a.order_id, 
	a.pizza_id, 
	STRING_AGG(concat(case when a.total > 1 then concat(a.total, 'x') else null end , i.name), ',') within group (order by i.name) ingredients

FROM ingredients_by_pizza a
	left join [dbo].[Ingredients] i on i.id = a.ingredients
WHERE a.total > 0
group by 
	 a.order_id,
	 a.pizza_id,
	 ordered_pizza
order by order_id