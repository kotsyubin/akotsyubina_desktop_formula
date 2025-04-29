{% set map_path = pillar_map %}
{% from map_path import package_sources with context %}
{% from map_path import generic_package_sources %}
{% set desired = desired_pillar %}
{% set appimages = [] %}
{% set flatpaks = [] %}
{% set arches = [] %}

{% set default_pkgs = package_sources["default"] %}

{% for package in desired %}
    {% if package not in default_pkgs and package not in generic_package_sources["AppImage"] and package not in generic_package_sources["Flatpak"] and package not in generic_package_sources["Archive"] %}
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
    {% elif package in generic_package_sources["Archive"] %}
        {% set arches = arches.append(package) %}
        {% set desired = desired.remove(package) %}
    {% endif %}
{% endfor %}

{% for package in desired %}
{% if ( salt['pkg.available_version'](package) or salt['pkg.version'](package)) %}
{{ package }}:
    pkg.purged
{% else %}
{% do salt['log.error'](package ~ " isn't avaivable in enabled repos") %}
{% endif %}
{% endfor %}

{% if appimages %}
{% for appimage in appimages %}
Removing_AppImage_{{ appimage }}:
    file.absent:
        - name: /usr/appimage/{{ appimage }}.AppImage
{% if appimage["desktopfile"] %}
{% do salt['log.error'](".desktop file removal isn't implemented yet!") %}
{% endif %}
{% endfor %}
{% endif %}

{% if flatpaks %}
flatpak:
    pkg.installed
{% for flatpak in flatpaks %}
    cmd.run:
        - name: "flatpak uninstall -y {{ generic_package_sources["Flatpak"][flatpak]["id"] }}"
{% endfor %}

{% endif %}

{% if arches %}
{% for archive in arches %}
removing_{{ archive }}:
  file.absent:
    - name: /usr/{{ archive }}
removing_{{ archive }}_icon:
  file.absent:
    - name: /usr/share/icons/{{ generic_package_sources["Archive"][archive]["icon"] }}
removing_{{ archive }}_desktop_entry:
    file.absent:
     - name: /usr/share/applications/{{ generic_package_sources["Archive"][archive]["id"] }}.desktop
{% endfor %}
{% endif %}