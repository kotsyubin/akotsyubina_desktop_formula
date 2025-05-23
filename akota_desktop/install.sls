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
    pkg.installed
{% else %}
{% do salt['log.error'](package ~ " isn't avaivable in enabled repos") %}
{% endif %}
{% endfor %}

{% if appimages %}
{% include 'akota_desktop/appimage_install.sls' with context %}
{% endif %}

{% if flatpaks %}
{% include 'akota_desktop/flatpak_install.sls' with context %}
{% endif %}

{% if arches %}
{% include 'akota_desktop/archive_install.sls' with context %}
{% endif %}