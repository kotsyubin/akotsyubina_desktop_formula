{% set desired_pillar = salt['pillar.get']('packages', ['tagstudio']) %}
{% set pillar_map = salt['pillar.get']('packagemap', 'akota_desktop/data_hoarding/packagemap.jinja') %}
{% include 'akota_desktop/remove.sls' %}