nginx:
    pkg:
        - installed
    service:
        - running
        - require:
            - pkg: nginx
            - file: {{ pillar['www']['server'] }}
            - file: /var/log/nginx
            - user: www_user
        - watch:
            - file: site_enabled
            - file: /etc/nginx/nginx.conf

{{ pillar['www']['base'] }}:
    file.managed:
        - source: salt://nginx.base
        - require:
            - pkg: nginx

webserver_link_base:
    file.directory:
        - name: {{ pillar['www']['basedir'] }}

webserver_symlink:
    file.symlink:
        - name: {{ pillar['www']['server'] }}
        - target: {{ pillar['project']['target'] }}/website/_site
        - require:
            - user: www_user
            - file: {{ pillar['www']['base'] }}
            - file: webserver_link_base
            - git: {{ pillar['project']['repository'] }}

/var/log/nginx:
    file.directory:
        - user: www-data
        - group: www-data
        - recurse:
            - user
            - group
        - require:
            - pkg: nginx

/etc/nginx/sites-enabled/default:
    file:
        - absent

site_available:
    file.managed:
        - name: /etc/nginx/sites-available/{{ pillar['name'] }}
        - source: salt://nginx.conf
        - template: jinja
        - require:
            - pkg: nginx
            - user: www_user
            - file: webserver_symlink

site_enabled:
    file.managed:
        - name: /etc/nginx/sites-enabled/{{ pillar['name'] }}
        - source: salt://nginx.conf
        - template: jinja
        - require:
            - pkg: nginx
            - user: www_user
            - file: site_available
