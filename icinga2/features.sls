{% from "icinga2/map.jinja" import icinga2 with context %}
{% from "icinga2/map.jinja" import feature with context %}

{%- if icinga2.features != None %}
{%- for name, enable in icinga2.features.items() %}
{{ feature(name, enable) }}
{%  endfor %}

{% if icinga2.features.get("api", False) %}
iciniga2_feature_api_initial:
  cmd.run:
    - name: icinga2 api setup
    - require:
      - cmd: icinga2_feature_api
    - onchanges:
      - cmd: icinga2_feature_api
{%- endif %}
{%- endif %}
