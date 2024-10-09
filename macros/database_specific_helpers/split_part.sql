{% macro split_part(string_text, delimiter_text, part_number)  -%}
  {{ return(adapter.dispatch('split_part')(string_text, delimiter_text, part_number) ) }}
{%- endmacro %}

{% macro fabric__split_part(string_text, delimiter_text, part_number) -%}
    (
        SELECT max(value)
        FROM STRING_SPLIT({{string_text}},{{delimiter_text}},1)
        WHERE ordinal = {{part_number}}
    )
{%- endmacro %}