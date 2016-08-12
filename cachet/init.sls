# vim: ft=sls
# Init cachet
{%- from "cachet/map.jinja" import cachet with context %}
{# Below is an example of having a toggle for the state #}

{% if cachet.enabled %}
include:
  - cachet.install
  - cachet.config
{% else %}
'cachet-formula disabled':
  test.succeed_without_changes
{% endif %}
