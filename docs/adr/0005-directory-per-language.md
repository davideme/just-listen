# ADR-0005: One Directory Per Language

**Status:** Accepted  
**Date:** 2026-04-28

## Context

The files for each language need to live somewhere. Options considered:

1. **Flat root**: all files at the root (e.g., `main.go`, `Server.java`).
2. **Directory per language** (e.g., `go/`, `java/`).
3. **Monorepo with workspace tooling** (e.g., Turborepo, Nx).

## Decision

One top-level directory per language, named after the canonical CLI/runtime name:
`go/`, `java/`, `nodejs/`, `dotnet/`.

Naming rationale:
- `go/` — matches the `go` CLI binary name.
- `java/` — matches the `java` runtime binary name.
- `nodejs/` — matches the `node` binary's ecosystem name. `node/` was rejected
  because it conflicts with Node.js's own `node:` built-in module protocol prefix,
  which could be confusing in documentation.
- `dotnet/` — matches the `dotnet` CLI binary name. `csharp/` was rejected because
  the directory houses the runtime/SDK choice, not just the language.

## Consequences

- Each language has its own ecosystem files (`.gitignore`, `go.mod`, `package.json`,
  `dotnet.csproj`) that do not pollute other directories.
- `go run`, `java`, `node`, and `dotnet run` work cleanly when run from within
  the language directory.
- Contributors can clone and work on a single language without context-switching.
- The Makefile must `cd` into each subdirectory before running commands.
- Adding a new language is purely additive: create a new directory, no existing
  files need to change.
- Option 1 (flat root) was rejected because `go.mod` and `package.json` at the root
  would confuse language tooling.
- Option 3 (monorepo tooling) was rejected as contradicting ADR-0003 (no external deps).
