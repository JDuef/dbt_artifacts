with
    base as (select * from {{ ref("sources") }}),
    enhanced as (

        select
            {{ dbt_artifacts.generate_surrogate_key(["command_invocation_id", "node_id"]) }}
            as source_execution_id,
            command_invocation_id,
            node_id,
            run_started_at,
            {% if target.type in ("sqlserver","fabric") %} "database"
            {% else %} database
            {% endif %},
            {% if target.type in ("sqlserver","fabric") %} "schema"
            {% else %} schema
            {% endif %},
            source_name,
            loader,
            name,
            identifier,
            loaded_at_field,
            freshness
        from base

    )

select *
from enhanced

