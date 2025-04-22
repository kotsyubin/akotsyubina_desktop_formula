{% set firefox_cfgloc = '/usr/lib64/firefox/defaults/pref/akota-prefs.js' %}
firefox:
    pkg.absent
{{ firefox_cfgloc }}:
    file.absent
/etc/firefox/policies.json:
    file.absent