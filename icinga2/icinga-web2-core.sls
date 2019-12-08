{% from "icinga2/map.jinja" import icinga2 with context %}
{% from "icinga2/map.jinja" import feature with context %}

include:
  - icinga2

icinga2-web2-required-packages:
  pkg.installed:
    - pkgs: {{ icinga2.icinga_web2.required_pkgs | json }}

icinga2-web2:
  pkg.installed:
    - pkgs: {{ icinga2.icinga_web2.pkgs | json }}

icingaweb2-group:
  group.present:
    - name: {{ icinga2.icinga_web2.group }}

#Configure automatically Icinga web, avoiding the use of the php wizard
icinga2web-autoconfigure:
  file.recurse:
    - name: "{{ icinga2.icinga_web2.config_dir }}"
    - source: salt://icinga2/files/etc.icingaweb2/
    - template: jinja
    - makedirs: True
    - user: {{ icinga2.icinga_web2.user }}
    - group: {{ icinga2.icinga_web2.group }}
    - dir_mode: 750
    - file_mode: 644
    - require:
      - group: icingaweb2-group

icinga2web-autoconfigure-finalize:
  file.symlink:
    - name: "{{ icinga2.icinga_web2.config_dir }}/enabledModules/monitoring"
    - target: "{{ icinga2.icinga_web2.modules_dir }}/monitoring"
    - makedirs: True
    - user: {{ icinga2.icinga_web2.user }}
    - group: {{ icinga2.icinga_web2.group }}
    - require:
      - group: icingaweb2-group

{% if icinga2.features.get("api", False) %}
is-icinga2web-api-password-set:
  test.check_pillar:
    - present:
      - 'icinga2:lookup:icinga_web2:api:password'
    - string:
      - 'icinga2:lookup:icinga_web2:api:password'

icinga2web_api_user:
  file.blockreplace:
    - name: /etc/icinga2/conf.d/api-users.conf
    - marker_start: "#-- start api user for icingaweb2 --#"
    - marker_end: "#-- end api user for icingaweb2 --#"
    - append_if_not_found: True
    - content: |
        object ApiUser "{{ icinga2.icinga_web2.api.user }}" {
          password = "{{ icinga2.icinga_web2.api.password }}"
          permissions = [ "*" ]
        }
    - require:
      - test: is-icinga2web-api-password-set
      - cmd: iciniga2_feature_api_initial
    - require_in:
      - service: icinga2_service_restart
{%- endif %}
