create_appimage_directory:
        file.directory:
            - name: "/usr/appimage"
            - group: users
            - mode: 755
            - makedirs: True
{% for appimage in appimages %}
{% set appimage_data = generic_package_sources["AppImage"][appimage] %}
installing_AppImage_{{ appimage }}:
    file.managed:
        - name: /usr/appimage/{{ appimage }}.AppImage
        - mode: '0755'
        - source: {{ appimage_data["src"] }}
        - skip_verify: True
{% if appimage_data["exec_path"] and appimage_data["comment"] and appimage_data["icon"] %}
installing_{{ appimage }}_icon:
    file.managed:
     - name: /usr/share/icons/{{ appimage_data["icon"] }}
     - source: salt://akota_desktop/files/icons/{{ appimage_data["icon"] }}
installing_desktop_entry_{{ appimage }}.desktop:
    file.managed:
     - name: /usr/share/applications/{{ appimage_data["id"] }}.desktop
     - source: salt://akota_desktop/files/desktopfile_template.jinja
     - template: jinja
     - defaults:
        pretty_name: {{ appimage_data["pretty_name"] }}
        folder: "/usr/appimage"
        icon: {{ appimage_data["icon"] }}
        exec_path: {{ appimage_data["exec_path"] }}
{% endif %}
{% endfor %}