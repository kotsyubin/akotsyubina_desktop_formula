{% set desired_pillar = salt['pillar.get']('packages', ['cpu-x','keyguard','nekoray','qbittorrent',]) %}
{% include 'akota_desktop/install.sls' %}

include:
- .firefox
- .telegram