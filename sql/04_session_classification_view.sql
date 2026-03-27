CREATE VIEW session_classification AS
SELECT
    user_id,
	session_end,
    total_views,
    total_carts,
    total_purchases,
    revenue,

    /* Session Type */
    CASE 
        WHEN total_purchases > 0 THEN 'Converting'
        WHEN total_carts > 0 AND total_purchases = 0 THEN 'Cart_Abandonment'
        WHEN total_views > 0 AND total_carts = 0 THEN 'Browsing'
        ELSE 'No_Activity'
    END AS session_type,

    /* Funnel Flags */
    CASE WHEN total_views > 0 THEN 1 ELSE 0 END AS viewed_flag,
    CASE WHEN total_carts > 0 THEN 1 ELSE 0 END AS cart_flag,
    CASE WHEN total_purchases > 0 THEN 1 ELSE 0 END AS purchase_flag

FROM session_fact;

select* from session_classification