{% set desired_pillar = salt['pillar.get']('packages', ['remmina','apache-directory-studio']) %}
{% set pillar_map = salt['pillar.get']('packagemap', 'akota_desktop/sysadmin/packagemap.jinja') %}
{% include 'akota_desktop/install.sls' %}