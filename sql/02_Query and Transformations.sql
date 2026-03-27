
--CHAPTER 1
---------- 1) Revenue integrity
				 /*Checking for revenue credibility to see if all tables confirm the same amount*/
				--Daily_Metrics table
					select
						SUM(revenue) as Daily_metrics_Total_revenue
					from daily_metrics; 
				--Product_fact Table
					select
						SUM(revenue) as product_fact_Total_revenue
					from product_fact; 
				--Session_fact Table
					select
						SUM(revenue) as session_fact_Total_revenue
					from session_fact;

---------- 2)Traffic growth
				/*Checking to see the trend of growth*/
					select 
						MONTH(date)as 'Date',
						SUM(total_events)as total_events,
						SUM(total_views)as total_views,
						SUM(total_carts)as total_carts,
						SUM(total_purchases)as total_purchases,
						SUM(revenue)as 'Total revenue'
					from daily_metrics
					group by MONTH(date);

---------- 3)Overall funnel efficiency level
				--Overall View → Purchase conversion rate.
				/*looking to see how big a difference there is betwwen the view and purchases and if the is a significant difference*/
					SELECT 
						SUM(total_views) as total_view,
						SUM(total_purchases) as total_purchases,
						SUM(total_views-total_purchases)as diffremce,
						SUM(total_purchases)*100/SUM(total_views) as percentage_rate_purchases_to_Views
					FROM session_fact;

				--Cart → Purchase conversion rate.
				/*looking to see how big a difference there is betwwen the cart and purchase and if the is a significant difference  */
					SELECT 
						SUM(total_carts) as total_carts,
						SUM(total_purchases) as total_purchases,
						SUM(total_carts-total_purchases)as diffremce,
						SUM(total_purchases)*100/SUM(total_carts) as percentage_rate_purchases_to_cart
					FROM session_fact;

---------- 4)Monetization:
				--Revenue per View (RPV).
						/*Revenue_per_View where view sessions had purchases*/
						select
						SUM(total_views) as Total_Views,
						SUM(revenue) as Total_Revenue,
						SUM(revenue)/SUM(total_views) as Revenue_per_View
						from session_fact
						where total_purchases>0;

						/*Revenue_per_View where views are for entire period regardless of leading to purchase*/
						select
						SUM(total_views) as Total_Views,
						SUM(revenue) as Total_Revenue,
						SUM(revenue)/SUM(total_views) as Revenue_per_View
						from session_fact;

				--Average Order Value (AOV).
					select
						SUM(revenue)/SUM(total_purchases) as Avg_Order_Value
					from product_fact
					where total_purchases > 0

--CHAPTER 2
---------- Category-Level Funnel Efficiency
				SELECT 
					category_id,
					SUM(total_views) AS total_views,
					SUM(total_carts) AS total_carts,
					SUM(total_purchases) AS total_purchases,
					SUM(revenue) AS total_revenue,
					ISNULL(SUM(total_purchases) * 100.0 / NULLIF(SUM(total_views), 0), 0) AS view_to_purchase_rate,
					ISNULL(SUM(total_purchases) * 100.0  / NULLIF(SUM(total_carts), 0), 0) AS cart_to_purchase_rate,
					ISNULL(SUM(revenue)/NULLIF(SUM(total_views), 0), 0) as Revenue_per_View,
					ISNULL(SUM(revenue)/NULLIF(SUM(total_purchases), 0), 0) as Avg_Order_Value
				FROM session_fact
				GROUP BY category_id
				order by category_id;
---------- Category-Level Funnel Efficiency
				SELECT 
					category_id,
					SUM(total_views) AS total_views,
					SUM(total_carts) AS total_carts,
					SUM(total_purchases) AS total_purchases,
					SUM(revenue) AS total_revenue,
					ISNULL(SUM(total_purchases) * 100.0 / NULLIF(SUM(total_views), 0), 0) AS view_to_purchase_rate,
					ISNULL(SUM(total_purchases) * 100.0  / NULLIF(SUM(total_carts), 0), 0) AS cart_to_purchase_rate,
					ISNULL(SUM(revenue)/NULLIF(SUM(total_views), 0), 0) as Revenue_per_View,
					ISNULL(SUM(revenue)/NULLIF(SUM(total_purchases), 0), 0) as Avg_Order_Value
				FROM session_fact
				GROUP BY category_id
				order by category_id;

---------- Revenue vs Traffic Imbalance
				WITH category_totals AS (
					SELECT 
						category_id,
						SUM(total_views) AS category_views,
						SUM(revenue) AS category_revenue
					FROM session_fact
					GROUP BY category_id
				)

				SELECT
					category_id,
					category_views,
					category_revenue,
					category_views * 1.0 / SUM(category_views) OVER () AS '% Traffic',
					category_revenue * 1.0 / SUM(category_revenue) OVER () AS '% Revenue',
					(category_revenue * 1.0 / SUM(category_revenue) OVER ()) -
					(category_views * 1.0 / SUM(category_views) OVER ()) AS gap
				FROM category_totals
				ORDER BY gap;

--CHAPTER 3
/*User & Session Behavior Analysis*/
---------- Session Classification
			WITH SessionClassification AS (
				SELECT
					CASE 
						WHEN total_views > 0 AND total_carts = 0 AND total_purchases = 0 THEN 'Browsing'
						WHEN total_carts > 0 AND total_purchases = 0 THEN 'Cart_Abandonment'
						WHEN total_purchases > 0 THEN 'Converting'
						ELSE 'Other'
					END AS session_type,
					total_views,
					total_carts,
					total_purchases,
					revenue
				FROM session_fact
				)
			SELECT
			session_type,
			count(*)as total_sessions,
			SUM(revenue) as total_revenue,
			SUM(revenue) / COUNT(*) as avg_revenue_per_session,
			COUNT(session_type)*100.0 / sum(COUNT(session_type)) over ()as '% of sessions',
			SUM(total_views)/count(*) as avg_views_per_session,
			SUM(total_carts)/COUNT(*) as avg_carts_per_session,
			SUM(total_purchases)/COUNT(*) as avg_purchases_per_session
			FROM SessionClassification
			group by session_type;

---CHAPTER 4 
---------- Revenue Concentration & Transactional Distribution
				SELECT
					user_id,
					SUM(revenue) AS total_user_revenue,
					SUM(total_purchases) AS total_user_purchases,
					COUNT(user_session) AS total_sessions
				FROM session_fact
				GROUP BY user_id;

---------- Revenue Distribution Analysis
				WITH user_revenue AS (
				SELECT
					user_id,
					SUM(revenue) AS total_user_revenue
				FROM session_fact
				GROUP BY user_id
					),
				ranked_users AS (
					SELECT
						*,
						NTILE(10) OVER (ORDER BY total_user_revenue DESC) AS revenue_decile
					FROM user_revenue
				)
				SELECT
					revenue_decile,
					COUNT(*) AS users,
					SUM(total_user_revenue) AS revenue_generated
				FROM ranked_users
				GROUP BY revenue_decile
				ORDER BY revenue_decile;

---------- Session Funnel Analysis		
				select
				SUM(total_views) as viewed_prdct,
				SUM(total_carts) as added_to_cart,
				SUM(total_purchases) as purchased,
				(SUM(total_carts)*100.00)/SUM(total_views)as view_to_cart_conversion,
				(SUM(total_purchases)*100.00)/SUM(total_carts) as cart_to_purchase_conversion,
				(SUM(total_purchases)*100.00)/SUM(total_views) as view_to_purchase_conversion
				from session_fact;
	
---------- Session Engagement Analysis
			WITH SessionClassification AS (
			SELECT
				CASE 
					WHEN total_views > 0 AND total_carts = 0 AND total_purchases = 0 THEN 'Browsing'
					WHEN total_carts > 0 AND total_purchases = 0 THEN 'Cart_Abandonment'
					WHEN total_purchases > 0 THEN 'Converting'
					ELSE 'Other'
				END AS session_type,
				total_views,
				total_carts,
				total_purchases,
				revenue
			FROM session_fact
			)
			select
			session_type,
			AVG(total_views) as Avg_views,
			AVG(total_carts) as Avg_carts,
			AVG(revenue)as Avg_revenue
			from SessionClassification
			group by session_type;

--CHAPTER 5
/*Cart Abandonment Opportunity*/

----------How many sessions add items to cart but do not purchase?
			SELECT
				COUNT(user_session) AS abandoned_sessions,
				SUM(total_carts) AS cart_items,
				SUM(total_carts) - SUM(total_purchases) AS abandoned_items
			FROM session_fact
			WHERE total_carts > 0
			AND total_purchases = 0;

----------What is the average cart value of those sessions?
			SELECT 
				AVG(CAST(avg_price AS DECIMAL(18,2))) AS avg_product_price
			FROM product_fact;
---------- potential revenue exists if 10% of cart abandonments convert?
			WITH abandoned AS (
								SELECT
									SUM(CAST(total_carts - total_purchases AS BIGINT)) AS abandoned_items
								FROM session_fact
								WHERE total_carts > 0
								AND total_purchases = 0
							),
							price AS (
								SELECT 
									AVG(CAST(avg_price AS DECIMAL(18,2))) AS avg_product_price
								FROM product_fact
							)
							SELECT
								abandoned_items,
								avg_product_price,
								abandoned_items * avg_product_price AS total_abandoned_value,
								(abandoned_items * avg_product_price) * 0.10 AS potential_revenue_if_10pct_convert
							FROM abandoned
							CROSS JOIN price;

/*Category Revenue Opportunity*/
---------- Which categories generate the most views?
			select
			category_id,
			SUM(total_views) as views
			from session_fact
			group by category_id
			order by SUM(total_views)desc;

---------- Which categories generate the most revenue?
			select
			category_id,
			SUM(revenue) as revenue
			from session_fact
			group by category_id
			order by SUM(revenue)desc;

---------- Which categories have the lowest revenue per view?
			select
			category_id,
			SUM(total_views) as views,
			SUM(revenue) as revenue
			from session_fact
			group by category_id
			order by revenue;

/*Product Revenue Concentration*/
---------- Which products generate the most revenue?
			select
			product_id,
			revenue
			from product_fact
			group by product_id,revenue
			order by revenue desc;

---------- What percentage of revenue comes from the top 10 products?
			WITH products AS (
								SELECT 
									product_id,
									SUM(CAST(revenue AS BIGINT)) AS revenue
								FROM product_fact
								GROUP BY product_id
							),
							ranked_products AS (
								SELECT
									product_id,
									revenue,
									NTILE(10) OVER (ORDER BY revenue DESC) AS revenue_decile
								FROM products
							)
							SELECT TOP 10
								revenue_decile,
								product_id,
								revenue
							FROM ranked_products
							ORDER BY revenue DESC;
			
---------- How many products generate 80% of revenue?
			WITH product_revenue AS (
										SELECT 
											product_id,
											SUM(CAST(revenue AS BIGINT)) AS revenue
										FROM product_fact
										GROUP BY product_id
									),
									revenue_ranked AS (
										SELECT
											product_id,
											revenue,
											SUM(revenue) OVER (ORDER BY revenue DESC) AS cumulative_revenue,
											SUM(revenue) OVER () AS total_revenue
										FROM product_revenue
									)
									SELECT
										product_id,
										revenue,
										cumulative_revenue,
										total_revenue,
										cumulative_revenue * 1.0 / total_revenue AS cumulative_pct
									FROM revenue_ranked
									WHERE cumulative_revenue <= total_revenue * 0.8
									ORDER BY revenue DESC;