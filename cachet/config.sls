# vim: ft=sls
# How to configure cachet
{%- from "cachet/map.jinja" import cachet with context %}

cachet_config_dist:
  file.managed:
    - name: '/var/www/cachet/.env.dist'
    - source: salt://cachet/files/.env
    - user: www-data
    - group : www-data
    - mode: 0600
    - template: jinja
    - require:
      - git: https://github.com/cachethq/Cachet.git

cachet_config:
  file.copy:
    - name: /var/www/cachet/.env
    - source: /var/www/cachet/.env.dist
    - user: www-data
    - group : www-data
    - mode: 0600
    - require:
      - file: cachet_config_dist
