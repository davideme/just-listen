# Contributing to just-listen

Thank you for your interest. This is a deliberately constrained project —
please read the constraints before opening a PR.

## The Core Rules

1. **Standard SDK only.** No frameworks, no external packages. See [ADR-0003](docs/adr/0003-standard-library-only.md).
2. **Port 8080.** All servers listen on 8080. See [ADR-0004](docs/adr/0004-port-standardization.md).
3. **HTTP 200 to any request.** The server's only job is to accept and respond.
4. **Minimal and idiomatic.** Prefer fewer lines. Prefer the community's accepted style for the latest stable version.

## How to Contribute

1. Fork the repository and create a branch from `main`.
2. Make your changes. If you're adding a new feature (e.g., Docker support),
   check [TASKS.md](TASKS.md) — your work may correspond to an open task.
3. Test locally: run the server and `curl -i http://localhost:8080/`.
4. Open a pull request using one of the issue templates.

## Adding a New Language

New languages require a new ADR (see the [language port template](.github/ISSUE_TEMPLATE/language_port.md))
proposing the addition and explaining:

- What SDK HTTP primitive is used (no 3rd-party reverse proxy allowed)
- Why it belongs alongside the existing four
- The expected LOC count

See [ADR-0002](docs/adr/0002-language-selection.md) for the current selection rationale.

## Version Targets

| Language | Minimum version |
|----------|----------------|
| Go | 1.26+ |
| Java | JDK 25+ (JEP 512 compact source files) |
| Node.js | 24 LTS+ |
| .NET | 10.0+ |

## Code Style

Each language should follow its community's standard formatting:

- **Go**: `gofmt`
- **Java**: standard JDK style (4-space indent)
- **Node.js**: minimal — keep it concise
- **C# (.NET)**: `dotnet format`

## Opening Issues

Use the issue templates in [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/).
