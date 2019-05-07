## Installation
Installation is done with [basher](https://github.com/basherpm/basher):

```bash
basher install {% if repository_provider != "github.com" %}{{ repository_provider }}/{% endif %}{{ repository_namespace }}/{{ repository_name }}
```
