{% set policy_file = '/etc/firefox/policies/policies.json' %}
{% if salt['file.file_exists'](policy_file) == True %}
    {% do salt['log.error']("Firefox policies.json file exist, policy merge isn't implemented yet") %}
{% else %}
{{ policy_file }}:
  file.managed:
    - source: salt://akota_desktop/files/firefox_policies.json
    - skip_verify: true
    - makedirs: True
{% endif %}