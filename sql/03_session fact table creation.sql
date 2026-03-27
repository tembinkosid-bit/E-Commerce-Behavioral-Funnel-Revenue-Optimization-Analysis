CREATE TABLE session_fact (
    user_session NVARCHAR(100) NOT NULL,
    user_id BIGINT NOT NULL,
    category_id NVARCHAR(MAX),
    session_start DATETIME2,
    session_end DATETIME2,
    total_events BIGINT,
    total_views BIGINT,
    total_carts BIGINT,
    total_purchases BIGINT,
    revenue DECIMAL(18,2),
    session_duration_minutes FLOAT
);



select*
from session_fact