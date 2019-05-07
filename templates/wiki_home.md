# Welcome to the {{ project_name }} wiki!

{% if scripts %}
## Scripts
{% if scripts is string %}{% set scripts=scripts.split() %}{% endif %}
{% for script in scripts %}
- [{{ script }}]({{ script }})
{% endfor %}
{% endif %}

{% if libraries %}
## Libraries
{% if libraries is string %}{% set libraries=libraries.split() %}{% endif %}
{% for library in libraries %}
- [{{ library }}]({{ library }})
{% endfor %}
{% endif %}
