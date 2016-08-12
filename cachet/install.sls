# vim: ft=sls
# How to install cachet
{%- from "cachet/map.jinja" import cachet with context %}

include:
  - nginx.ng.install
  - php.ng.sqlite

https://github.com/cachethq/Cachet.git:
  git.latest:
    - rev: v2.3.10
    - target: /var/www/cachet
    - unless: test -f /var/www/cachet/.env
    - require:
      - pkg: nginx_install
    - user: www-data

sqlite3:
  pkg:
    - name: sqlite3
    - installed


create-sqlite-database:
  cmd.run:
    - name: touch ./database/database.sqlite
    - cwd: /var/www/cachet
    - creates: /var/www/cachet/database/database.sqlite
    - require:
      - git: https://github.com/cachethq/Cachet.git
    - runas: www-data
    - user: www-data


install-via-composer:
  cmd.run:
    - name: composer install --no-dev -o && php artisan migrate --env dev && php artisan app:install
    - cwd: /var/www/cachet
    - creates: /var/www/cachet/vendor
    - require:
      - cmd: create-sqlite-database
      - file: cachet_config
    - runas: www-data
    - user: www-data
