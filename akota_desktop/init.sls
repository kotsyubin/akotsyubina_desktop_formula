{% set desired_pillar = salt['pillar.get']('packages', ['zoxide','cpu-x','keyguard','nekoray','qbittorrent','bat']) %}
{% set pillar_map = salt['pillar.get']('packagemap', 'akota_desktop/packagemap.jinja') %}
{% include 'akota_desktop/install.sls' %}

include:
- .firefox