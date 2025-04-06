{% from "akota_desktop/packagemap.jinja" import package_sources with context %}
{% from "akota_desktop/packagemap.jinja" import generic_package_sources %}
{% set desired = desired_pillar %}
{% set appimages = [] %}
{% set flatpaks = [] %}

{% set default_pkgs = package_sources["default"] %}

{% for package in desired %} 
    {% if package not in default_pkgs and package not in generic_package_sources["AppImage"] and package not in generic_package_sources["Flatpak"] %}
         {% do salt['slsutil.update'](default_pkgs, {package: package}) %}
    {% elif package in generic_package_sources["Flatpak"] %}
        {% set flatpaks = flatpaks.append(package) %}
        {% set desired = desired.remove(package) %}
    {% endif %}
{% endfor %}

{% for package in desired %} 
    {% if package in generic_package_sources["AppImage"] %}
        {% set flatpaks = appimages.append(package) %}
        {% set desired = desired.remove(package) %}
    {% endif %}
{% endfor %}

{% for package in desired %}
{{ package }}:
    pkg.installed
{% endfor %}

{% if appimages %}
create_appimage_directory:
        file.directory:
            - name: "/usr/appimage"
            - group: users
            - mode: 755
            - makedirs: True
{% for appimage in appimages %}
installing_AppImage_{{ appimage }}:
    file.managed:
        - name: /usr/appimage/{{ appimage }}.AppImage
        - mode: '0755'
        - source: {{ generic_package_sources["AppImage"][appimage] }}
        - skip_verify: True
{% endfor %}
{% endif %}

{% if flatpaks %}
flatpak:
    pkg.installed
{% for flatpak in flatpaks %}
installing_Flatpak_{{ flatpak }}:
    file.managed:
        - name: /tmp/{{ flatpak }}.flatpak
        - mode: '0755'
        - source: {{ generic_package_sources["Flatpak"][flatpak] }}
        - skip_verify: True
    cmd.run:
        - name: "flatpak install -y /tmp/{{ flatpak }}.flatpak"
{% endfor %}
{% endif %}