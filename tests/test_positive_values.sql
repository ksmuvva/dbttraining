-- Example custom test: Test that order totals are positive
-- This file demonstrates a custom generic test

{% test positive_values(model, column_name) %}

select count(*)
from {{ model }}
where {{ column_name }} <= 0

{% endtest %}