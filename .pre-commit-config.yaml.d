---
exclude: >
  (?x)^(
    .config/constraints.txt|
    .config/.*requirements.*|
    .vscode/extensions.json|
    .vscode/settings.json|
    examples/broken/encoding.yml|
    examples/broken/encoding.j2|
    examples/broken/yaml-with-tabs/invalid-due-tabs.yaml|
    examples/playbooks/collections/.*|
    examples/playbooks/vars/empty.transformed.yml|
    examples/playbooks/vars/empty.yml|
    src/ansiblelint/schemas/rulebook.json|
    test/schemas/data/licenses.json|
    test/schemas/negative_test|
    test/schemas/package-lock.json
  )$
repos:
  - repo: meta
    hooks:
      - id: check-useless-excludes
  # https://github.com/pappasam/toml-sort/issues/69
  # - repo: https://github.com/pappasam/toml-sort
  #   rev: v0.23.1
  #   hooks:
  #     - id: toml-sort-fix
  - repo: https://github.com/pre-commit/mirrors-prettier
    # keep it before yamllint
    rev: v4.0.0-alpha.8
    hooks:
      - id: prettier
        # Temporary excludes so we can gradually normalize the formatting
        exclude: >
          (?x)^(
            .*\.md$|
            examples/other/some.j2.yaml|
            examples/playbooks/collections/.*|
            examples/playbooks/example.yml|
            examples/playbooks/invalid-transform.yml|
            examples/playbooks/multiline-brackets.*|
            examples/playbooks/templates/not-valid.yaml|
            examples/playbooks/vars/empty.transformed.yml|
            examples/playbooks/vars/empty.yml|
            examples/playbooks/with-skip-tag-id.yml|
            examples/playbooks/with-umlaut-.*|
            examples/yamllint/.*|
            src/ansiblelint/schemas/(molecule|tasks|playbook|rulebook).json|
            test/fixtures/formatting-before/.*|
            test/schemas/(negative_test|test)/.*\.md|
            test/schemas/data/.*|
            src/ansiblelint/schemas/ansible-navigator-config.json
          )$
        always_run: true
        additional_dependencies:
          - prettier@3.2.4
          - prettier-plugin-toml@2.0.1
          - prettier-plugin-sort-json@3.1.0
  - repo: https://github.com/python-jsonschema/check-jsonschema
    rev: 0.28.2
    hooks:
      - id: check-github-workflows
  - repo: https://github.com/pre-commit/pre-commit-hooks.git
    rev: v4.6.0
    hooks:
      - id: end-of-file-fixer
        # ignore formatting-prettier to have an accurate prettier comparison
        exclude: >
          (?x)^(
            test/eco/.*.result|
            examples/yamllint/.*|
            test/fixtures/formatting-before/.*|
            test/fixtures/formatting-prettier/.*
          )$
      - id: trailing-whitespace
        exclude: >
          (?x)^(
            examples/playbooks/(with-skip-tag-id|unicode).yml|
            examples/playbooks/example.yml|
            examples/yamllint/.*|
            test/eco/.*.result|
            test/fixtures/formatting-before/.*
          )$
      - id: mixed-line-ending
      - id: fix-byte-order-marker
      - id: check-executables-have-shebangs
      - id: check-merge-conflict
      - id: debug-statements
        language_version: python3
  - repo: https://github.com/codespell-project/codespell
    rev: v2.2.6
    hooks:
      - id: codespell
        exclude: >
          (?x)^(
            .config/dictionary.txt|
            examples/broken/encoding.j2|
            test/schemas/negative_test/.*|
            test/schemas/test/.*|
            src/ansiblelint/schemas/.*\.json
          )$
        additional_dependencies:
          - tomli
  #- repo: https://github.com/adrienverge/yamllint.git
  #rev: v1.35.1
  #hooks:
  #- id: yamllint
  #exclude: >
  #(?x)^(
  #examples/playbooks/templates/.*|
  #examples/yamllint/.*|
  #examples/other/some.j2.yaml|
  #examples/playbooks/collections/.*|
  #test/fixtures/formatting-before/.*
  #)$
  #files: \.(yaml|yml)$
  #types: [file, yaml]
  #entry: yamllint --strict
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: "v0.4.4"
    hooks:
      - id: ruff
        args: [--fix, --exit-non-zero-on-fix]
  - repo: https://github.com/psf/black
    rev: 24.4.2
    hooks:
      - id: black
        language_version: python3
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.10.0
    hooks:
      - id: mypy
        # empty args needed in order to match mypy cli behavior
        args: [--strict]
        additional_dependencies:
          - ansible-compat>=24.5.1
          - black>=22.10.0
          - cryptography>=39.0.1
          - filelock>=3.12.2
          - importlib_metadata
          - jinja2
          - license-expression >= 30.3.0
          - pytest-mock
          - pytest>=7.2.2
          - rich>=13.2.0
          - ruamel-yaml-clib>=0.2.8
          - ruamel-yaml>=0.18.6
          - subprocess-tee
          - types-PyYAML
          - types-jsonschema>=4.20.0.0
          - types-pkg_resources
          - types-setuptools
          - wcmatch
        exclude: >
          (?x)^(
            test/local-content/.*|
            plugins/.*
          )$
  - repo: https://github.com/pycqa/pylint
    rev: v3.1.0
    hooks:
      - id: pylint
        args:
          - --output-format=colorized
        additional_dependencies:
          - ansible-compat>=24.5.1
          - ansible-core>=2.14.0
          - black>=22.10.0
          - docutils
          - filelock>=3.12.2
          - importlib_metadata
          - jsonschema>=4.20.0
          - license-expression >= 30.3.0
          - pytest-mock
          - pytest>=7.2.2
          - pyyaml
          - rich>=13.2.0
          - ruamel-yaml-clib>=0.2.7
          - ruamel-yaml>=0.18.2
          - setuptools # needed for pkg_resources import
          - typing_extensions
          - wcmatch
          - yamllint
  #- repo: https://github.com/jazzband/pip-tools
  #rev: 7.4.1
  #hooks:
  #- id: pip-compile
  #name: lock
  #alias: lock
  #always_run: true
  #entry: pip-compile --upgrade --no-annotate --output-file=.config/requirements-lock.txt pyproject.toml --strip-extras --unsafe-package ruamel-yaml-clib --unsafe-package resolvelib
  #files: ^.config\/.*requirements.*$
  #language: python
  #language_version: "3.10" # minimal we support officially
  #pass_filenames: false
  #stages: [manual]
  #additional_dependencies:
  #- pip>=22.3.1
  #- id: pip-compile
  #name: deps
  #alias: deps
  #always_run: true
  #entry: pip-compile --no-annotate --output-file=.config/constraints.txt pyproject.toml --all-extras --strip-extras --unsafe-package wcmatch --unsafe-package ruamel-yaml-clib --unsafe-package resolvelib
  #files: ^.config\/.*requirements.*$
  #language: python
  #language_version: "3.10" # minimal we support officially
  #pass_filenames: false
  #additional_dependencies:
  #- pip>=22.3.1
  #- id: pip-compile
  #entry: pip-compile -v --no-annotate --output-file=.config/constraints.txt pyproject.toml --all-extras --strip-extras --unsafe-package wcmatch --unsafe-package ruamel-yaml-clib --unsafe-package resolvelib --upgrade
  #language: python
  #always_run: true
  #pass_filenames: false
  #files: ^.config\/.*requirements.*$
  #alias: up
  #stages: [manual]
  #language_version: "3.10" # minimal we support officially
  #additional_dependencies:
  #- pip>=22.3.1
  - # keep at bottom as these are slower
    repo: local
    hooks:
      - id: schemas
        name: update json schemas
        entry: python3 src/ansiblelint/schemas/__main__.py
        language: python
        pass_filenames: false
        always_run: true
        # stages: [manual]
