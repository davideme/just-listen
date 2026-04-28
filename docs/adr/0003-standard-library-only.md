# ADR-0003: Standard Library Only — No External Dependencies

**Status:** Accepted  
**Date:** 2026-04-28

## Context

HTTP frameworks (Express, Spring Boot, ASP.NET MVC, Gin) are extremely popular,
but they introduce version pinning, package management steps, and framework-specific
idioms that obscure what the language itself provides.

The goal of this project is to reveal the "floor" of each language — the minimal
surface area a developer needs to accept HTTP connections without installing anything
beyond the language runtime or SDK.

## Decision

Every server implementation MUST use only what ships with the language's standard
installation. No external package managers or registries may be used.

| Language | Allowed primitive | Package file | External deps |
|----------|-------------------|--------------|---------------|
| Go | `net/http` from stdlib | `go.mod` (module declaration only) | None — no `require` directives |
| Java | `com.sun.net.httpserver.HttpServer` from JDK | None (no Maven/Gradle) | None |
| Node.js | `node:http` built-in module | `package.json` (`"type": "module"` only) | None — no `dependencies` |
| .NET | `Microsoft.NET.Sdk.Web` (ships with .NET SDK) | `dotnet.csproj` | None — no `dotnet add package` |

Pull requests that add external framework dependencies will be rejected.

## Consequences

- Zero-step dependency installation for each language (beyond the runtime itself).
- Implementations stay small enough to read in under one minute.
- Some behaviors (routing, HTTPS, middleware) are intentionally out of scope at this layer.
- The constraint is a feature: it makes the comparison fair across languages.
- `.NET` uses `Microsoft.NET.Sdk.Web` rather than the plain `Microsoft.NET.Sdk`.
  This is considered "standard" because it ships with the .NET SDK installation —
  no separate download or `dotnet add package` is required.
