nodejs:
    pkgrepo.managed:
        - humanname: Node.js Repo
        - ppa: chris-lea/node.js
        - refresh: true
        
ruby2.2:
    pkgrepo.managed:
        - humanname: rubys.s Repo
        - ppa: brightbox/ruby-ng
        - refresh: true

pkgs:
    pkg.installed:
        - pkgs:
            - git
            - ruby2.2
            - ruby2.2-dev
            - supervisor
            - make
            - nodejs
        - require:
            - pkgrepo: nodejs
            - pkgrepo: ruby2.2
jekyll:
    gem.installed:
        - require:
            - pkg: pkgs

