
{{ pillar['supervisor']['config'] }}:
    file.managed:
        - source: salt://supervisor.conf
        - template: jinja
        - require:
            - gem: jekyll
            - user: www_user
            - git: {{ pillar['project']['repository'] }}
            - file: {{ pillar['www']['server'] }}

start_supervisor:
    service.running:
        - name: supervisor
        - require:
            - file: {{ pillar['supervisor']['config'] }}

restart:
    supervisord.running:
        - name: {{ pillar['name'] }}
        - restart: true
        - require:
            - git: {{ pillar['project']['repository'] }}

supervisor_logfile:
    file.directory:
        - name: /var/log/supervisor
        - user: root
        - group: root
