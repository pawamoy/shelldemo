{% if logo %}<p align="center">
  <img src="https://gl.githack.com/{{ repository_namespace }}/{{ repository_name }}/raw/master/{{ logo }}">
</p>

<h1 align="center">{{ project_description }}</h1>{% else %}<h1 align="center">{{ project_description }}</h1>

<p align="center">{{ project_description }}</p>{% endif %}

<p align="center">
  <a href="https://{{ repository_provider }}/{{ repository_namespace }}/{{ repository_name }}/commits/master">
    <img alt="pipeline status" src="https://{{ repository_provider }}/{{ repository_namespace }}/{{ repository_name }}/badges/master/pipeline.svg" />
  </a>
  <!--<a href="https://{{ repository_provider }}/{{ repository_namespace }}/{{ repository_name }}/commits/master">
    <img alt="coverage report" src="https://{{ repository_provider }}/{{ repository_namespace }}/{{ repository_name }}/badges/master/coverage.svg" />
  </a>-->
  <a href="https://gitter.im/{{ repository_namespace }}/{{ repository_name }}">
    <img alt="gitter chat" src="https://badges.gitter.im/{{ repository_namespace }}/{{ repository_name }}.svg" />
  </a>
</p>

{% for section in readme_sections %}
  {% include "readme_" + section + ".md" with context %}

{% endfor %}
