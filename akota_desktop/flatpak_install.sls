flatpak:
    pkg.installed
{% for flatpak in flatpaks %}
{% set flatpak_data = generic_package_sources["Flatpak"][flatpak] %}
installing_Flatpak_{{ flatpak }}:
    file.managed:
        - name: /tmp/{{ flatpak }}.flatpak
        - mode: '0755'
        - source: {{ flatpak_data["src"] }}
        - skip_verify: True
    cmd.run:
        - name: "flatpak install -y /tmp/{{ flatpak }}.flatpak"
{% endfor %}