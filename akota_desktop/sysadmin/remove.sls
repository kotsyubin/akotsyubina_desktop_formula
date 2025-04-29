{% set desired_pillar = salt['pillar.get']('packages', ['Apache Directory Studio']) %}
{% set pillar_map = salt['pillar.get']('packagemap', 'akota_desktop/sysadmin/packagemap.jinja') %}
{% include 'akota_desktop/remove.sls' %}