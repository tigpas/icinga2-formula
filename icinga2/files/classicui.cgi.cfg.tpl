{% from "icinga2/map.jinja" import icinga2 with context %}
# Icinga 2 Classic UI configuration
#
# requires icinga-gui package
# check http://docs.icinga.org for option details
standalone_installation=1
physical_html_path=/usr/share/icinga
url_html_path=/icinga2-classicui
url_stylesheets_path=/icinga2-classicui/stylesheets
http_charset=utf-8
refresh_rate=30
refresh_type=1
escape_html_tags=1
result_limit=50
show_tac_header=1
use_pending_states=1
first_day_of_week=0
suppress_maintenance_downtime=0
action_url_target=main
notes_url_target=main
use_authentication=1
use_ssl_authentication=0
lowercase_user_name=0
authorized_for_system_information={{ icinga2.classicui.users|join(',')}}
authorized_for_configuration_information={{ icinga2.classicui.users|join(',')}}
authorized_for_full_command_resolution={{ icinga2.classicui.users|join(',')}}
authorized_for_system_commands={{ icinga2.classicui.users|join(',')}}
authorized_for_all_services={{ icinga2.classicui.users|join(',')}}
authorized_for_all_hosts={{ icinga2.classicui.users|join(',')}}
authorized_for_all_service_commands={{ icinga2.classicui.users|join(',')}}
authorized_for_all_host_commands={{ icinga2.classicui.users|join(',')}}
show_all_services_host_is_authorized_for=1
show_partial_hostgroups=0
show_partial_servicegroups=0
default_statusmap_layout=5
status_show_long_plugin_output=0
display_status_totals=0
highlight_table_rows=1
add_notif_num_hard=28
add_notif_num_soft=0
use_logging=0
cgi_log_file=/var/log/icinga/gui/icinga-cgi.log
cgi_log_rotation_method=d
cgi_log_archive_path=/var/log/icinga/gui
enforce_comments_on_actions=0
send_ack_notifications=1
persistent_ack_comments=0
lock_author_names=1
default_downtime_duration=7200
set_expire_ack_by_default=0
default_expiring_acknowledgement_duration=86400
default_expiring_disabled_notifications_duration=86400
tac_show_only_hard_state=0
show_tac_header_pending=1
exclude_customvar_name=PASSWORD,COMMUNITY
exclude_customvar_value=secret
extinfo_show_child_hosts=0
tab_friendly_titles=1
######################################
#    STANDALONE (ICINGA 2) OPTIONS
#    requires standalone_installation=1
######################################
object_cache_file=/var/cache/icinga2/objects.cache
status_file=/var/cache/icinga2/status.dat
resource_file=/etc/icinga/resource.cfg
command_file=/var/run/icinga2/cmd/icinga2.cmd
check_external_commands=1
interval_length=60
status_update_interval=10
log_file=/var/log/icinga2/compat/icinga.log
log_rotation_method=h
log_archive_path=/var/log/icinga2/compat/archives
date_format=us
url_cgi_path=/cgi-bin/icinga2-classicui
#   EOF