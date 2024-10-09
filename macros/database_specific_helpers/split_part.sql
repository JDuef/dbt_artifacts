{% macro column_identifier(column_index) -%}
  {{ return(adapter.dispatch('split_part')(column_index)) }}
{%- endmacro %}

{% macro fabric__split_part(string_text, delimiter_text, part_number) -%}
    (
        SELECT max(value)
        FROM STRING_SPLIT({{string_text}},{{delimiter_text}},1)
        WHERE ordinal = {{part_number}}
    )
{%- endmacro %}