Docsite:
  'role:docsite':
    -match: grain
    - all
  'G@type:staging and G@roledocsite':
    - match: compound
    - staging
  'G@type:Production and G@roledocsite':
    - match: compound
    - Production
