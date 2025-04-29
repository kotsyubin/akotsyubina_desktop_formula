{% for archive in arches %}
{% set archive_data = generic_package_sources["Archive"][archive] %}
extract_{{ archive }}:
  archive.extracted:
    - name: /usr/{{ archive }}
    - source: {{ archive_data["src"] }}
    - skip_verify: True
{% if archive_data["exec_path"] is defined and archive_data["comment"] is defined and archive_data["icon"] is defined %}
installing_{{ archive }}_icon:
    file.managed:
     - name: /usr/share/icons/{{ archive_data["icon"] }}
     - source: salt://akota_desktop/files/icons/{{ archive_data["icon"] }}
installing_desktop_entry_{{ archive }}.desktop:
    file.managed:
     - name: /usr/share/applications/{{ archive_data["id"] }}.desktop
     - source: salt://akota_desktop/files/desktopfile_template.jinja
     - template: jinja
     - defaults: 
       pretty_name: {{ archive_data["pretty_name"] }}
       description: {{ archive_data["comment"] }}
       folder: {{"/usr/" ~  archive }}
       exec_path: {{ archive_data["exec_path"] }}
       icon: {{ archive_data["icon"] }}
{% endif %}
{% endfor %}