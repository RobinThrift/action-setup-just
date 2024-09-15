nmbin := absolute_path("./node_modules/.bin")

_default:
  @just --list

build:
    ncc build src/index.ts --minify

run: build
    rm -rf .tmp
    mkdir -p .tmp/cache .tmp/temp
    RUNNER_TOOL_CACHE=.tmp/cache \
    RUNNER_TEMP=.tmp/temp \
    GITHUB_TOKEN={{env_var_or_default("GITHUB_TOKEN", env_var_or_default("HOMEBREW_GITHUB_API_TOKEN", ""))}} \
    node dist/index.js
    rm -rf .tmp

fmt:
    {{ nmbin }}/biome format --write src/*.ts

lint:
    {{ nmbin }}/biome check --write src/*.ts

typecheck:
    {{ nmbin }}/tsc --noEmit --incremental false
