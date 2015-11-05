nodejs:
    pkgrepo.managed:
        - humanname: Node.js Repo
        - ppa: chris-lea/node.js
        - refresh: true

pkgs:
    pkg.installed:
        - pkgs:
            - git
            - ruby
            - supervisor
            - ruby-dev
            - make
            - nodejs
        - require:
            - pkgrepo: nodejs

jekyll:
    gem.installed:
        - require:
            - pkg: pkgs

{{ pillar['project']['repository'] }}:
    git.latest:
        - target: {{ pillar['project']['target'] }}
        - user: {{ pillar['user'] }}
        - group: {{ pillar['group'] }}
        - require:
            - pkg: pkgs
            - file: github_public
            - file: github_private

{{ pillar['project']['log'] }}:
    file.directory:
        - require:
            - pkg: pkgs
