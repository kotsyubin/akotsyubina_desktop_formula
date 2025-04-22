{% from "akota_desktop/fellas.jinja" import fellas with context %}

/usr/tsetup.tar.xz:
  file.managed:
    - source: https://telegram.org/dl/desktop/linux
    - skip_verify: true
extract_telegram:
  archive.extracted:
    - name: /usr/
    - source: file:///usr/tsetup.tar.xz
{% for user in fellas %}
telegram_first_run_{{ user }}:
  cmd.run:
    - name: /usr/Telegram/Updater && sleep 1s && pkill Telegram
{% endfor %}