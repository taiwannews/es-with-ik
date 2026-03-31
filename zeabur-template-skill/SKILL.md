---
name: zeabur-template
description: Help users design and generate Zeabur Template YAML (Template Resource) files, including required metadata/spec structure, service specs, variables, instructions, env/configs, and localization blocks. Use this skill whenever the user asks to create, validate, or update a Zeabur template, mentions zeabur.yaml, Template Resource, or wants a deployable Zeabur template format.
---

# Zeabur Template Skill

You help users create **Zeabur Template Resource YAML** that follows Zeabur's template format. Prioritize correctness of the YAML structure and the rules described in Zeabur docs.

## When To Use
- The user asks to create a Zeabur template, `zeabur.yaml`, or “Template Resource” file.
- The user provides an app/service list and wants a Zeabur template.
- The user wants to localize template content for zh-TW/zh-CN/ja-JP/es-ES.
- The user wants to validate or fix an existing Zeabur template.
- The user asks about template catalog publishing, maintaining/updating templates, or forking a Git service from a template.

## Inputs You Should Gather
Collect the minimum needed information, but do not over-ask:
- Template name, description, tags, icon/cover image URLs, readme.
- Variables (key, type, name, description, default, whether used by services).
- Services list and each service’s source (image or repo), ports, volumes, env, configs, instructions, GPU needs.
- Localization languages and localized fields (description, coverImage, readme, variable names/descriptions).
- If the user is updating a published template: the template code (from the template URL) and the YAML filename they will update with CLI.

If the user does not provide enough, make reasonable assumptions and clearly note them in the output summary.

## Output Format
When generating or updating a template, **always output**:
1. The YAML in a fenced `yaml` block.
2. A short checklist of what to fill or confirm.

If the user asks for a file, place the YAML content in `zeabur.yaml` unless they specify a different filename.

## YAML Structure (Template Resource)
Use this base structure:

```yaml
apiVersion: zeabur.com/v1
kind: Template
metadata:
  name: <TemplateName>
spec:
  description: <Short description>
  icon: <URL>
  coverImage: <URL>
  variables:
    - key: <KEY>
      type: <TYPE>
      name: <Display name>
      description: <What this variable is for>
  tags:
    - <Tag>
  readme: |-
    # <Title>
    <Markdown content>
  services:
    - name: <ServiceName>
      icon: <URL>
      template: PREBUILT
      domainKey: <VARIABLE_KEY> # optional
      spec:
        source:
          image: <docker-image>
        ports:
          - id: <id>
            port: <port>
            type: <HTTP|TCP>
        volumes:
          - id: <id>
            dir: <path>
        instructions:
          - type: <DOMAIN|TEXT|PASSWORD>
            title: <title>
            content: <content>
            category: <optional>
        env:
          <ENV_NAME>:
            default: <value>
            expose: <true|false>
            readonly: <true|false>
        configs:
          - path: <path>
            template: |-
              <content>
            envsubst: <true|false>
            permission: <decimal permission>
        gpu:
          enabled: true
localization:
  zh-TW:
    description: <localized>
    coverImage: <localized>
    variables:
      - key: <same as spec.variables>
        name: <localized>
        description: <localized>
    readme: |-
      <localized markdown>
```

### Notes You Must Follow
- `apiVersion` must be `zeabur.com/v1` and `kind` must be `Template`.
- `spec` is the primary definition; `localization` overrides selected fields per language.
- `variables` support `key`, `type`, `name`, `description`. Align keys with service usage (e.g., `domainKey`).
- `instructions` types are `DOMAIN`, `TEXT`, `PASSWORD`.
- `env.expose` allows other services to use the value via `${VAR}`. `readonly` means the value cannot be modified after creation.
- `configs.permission` must be a **decimal** number converted from UNIX file permissions (e.g., 420 for 0644).
- `gpu.enabled` is boolean; only enable when needed.
- Supported localization languages include `zh-TW`, `zh-CN`, `ja-JP`, `es-ES`. `en-US` is the default and lives in `spec`.

## Template Catalog Guidance
When the user wants to list, browse, or publish templates:
- Tags should follow Zeabur’s template catalog tag taxonomy; suggest the closest existing tags if unsure.
- Provide a short, accurate description and an icon/cover image URL; these fields are surfaced on the catalog.
- Ensure the `readme` is readable for deployers (setup steps, credentials, connection info).

## Fork Git Repo From Template (Git Services)
If the template includes Git services and the user wants to customize code:
- Explain that deploying a template with Git services usually points to the original GitHub repo and will follow its CI/CD.
- Offer the flow: deploy template → open the service settings → use the “Fork” action to fork the repo to the user’s GitHub, so they can modify it without depending on the original template repo.

## Maintain & Update Template
If the user asks to update a published template:
1. Update the Template Resource YAML file.
2. Run CLI update with the template code and file path:
   `npx zeabur@latest template update -c <template-code> -f <template.yaml>`
3. Remind them the template code is the short ID in the template URL (e.g., `/templates/71HORL`).

## CLI Workflows (Template YAML)
If the user asks how to deploy/publish/update a template by CLI, prefer the official commands from Zeabur docs and keep steps minimal. Ask for the YAML filename and whether they want to deploy, publish, update, or delete.

## Update Flow
If the user provides an existing YAML:
1. Parse the YAML and preserve existing values.
2. Apply only requested changes.
3. Validate structure and note any missing required fields.

## Quality Checklist (Include in Output)
- Template Resource shape is valid.
- `spec.services` exists and each service has a `name` and `spec.source`.
- Ports have `id`, `port`, and `type`.
- Any `domainKey` references a defined variable key.
- Localization entries use the same variable keys as `spec.variables`.
- `configs.permission` uses decimal values.

## Example Quick Prompt Handling
If user says: “Make a Zeabur template for a Redis + API app with a public domain,” you should:
- Define variables (e.g., `PUBLIC_DOMAIN`).
- Create two services (Redis + API), wire env references.
- Use `domainKey: PUBLIC_DOMAIN` on the API service.
