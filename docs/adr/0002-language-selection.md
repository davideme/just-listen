# ADR-0002: Language Selection

**Status:** Accepted  
**Date:** 2026-04-28

## Context

The project aims to compare "the simplest possible HTTP server" across a
representative set of mainstream languages. The selection criteria are:

1. The language must be widely used and taught.
2. The language must serve HTTP natively — using its standard SDK, with no
   3rd-party reverse proxy (Nginx, Unicorn, Gunicorn, etc.) required in front.
3. The set should cover multiple paradigms (compiled, JVM, interpreted/event-loop, managed runtime).

## Decision

We include exactly four languages: **Go, Java, Node.js, and .NET**.

| Language | Stdlib HTTP primitive | Paradigm | Run command |
|----------|-----------------------|----------|-------------|
| Go | `net/http` | Compiled, typed | `go run main.go` |
| Java | `com.sun.net.httpserver.HttpServer` | Compiled, JVM + virtual threads | `java Server.java` |
| Node.js | `node:http` module | Interpreted, event loop | `node server.js` |
| .NET | Kestrel via `Microsoft.NET.Sdk.Web` | Managed runtime, async | `dotnet run` |

### Included — rationale

**Go**: `net/http` is a production-grade HTTP server in the standard library.
Goroutines handle concurrency natively. No external dependency required.

**Java**: `com.sun.net.httpserver.HttpServer` ships in every JDK. Virtual threads
(finalized in Java 21) make it a first-class production choice. JEP 512 (Java 25)
allows running source files directly with `java Server.java` — no compilation step.

**Node.js**: The built-in `node:http` module runs an HTTP server using V8's event loop.
No external packages required. The `node:` prefix (canonical since Node.js 14.18+)
signals a built-in core module.

**.NET**: `Microsoft.NET.Sdk.Web` ships with the .NET SDK. It bundles Kestrel, a
production-grade HTTP server. ASP.NET Core Minimal APIs (3 lines) are the modern
idiomatic approach. No `dotnet add package` required.

### Excluded — rationale

| Language | Reason |
|----------|--------|
| Python | `http.server` is documented as not suitable for production; ecosystem convention is Gunicorn/uWSGI behind Nginx |
| Ruby | WEBrick is not production-ready; convention is Unicorn/Puma behind Nginx |
| PHP | Built-in `-S` dev server is explicitly not for production; convention is PHP-FPM behind Nginx |
| Rust | `std` has no HTTP server; an external crate (hyper, axum) is required |
| C/C++ | No stdlib HTTP; raw POSIX socket programming is not a comparable abstraction |
| .NET `HttpListener` | Ships in `System.Net` stdlib but is deprecated and not recommended for new code by the .NET team |

## Consequences

- Four implementations are maintained in parallel.
- Any new language addition requires a new ADR demonstrating it meets both selection criteria.
- The Java implementation uses `com.sun.net.httpserver` (a `com.sun.*` internal API).
  This is intentional and documented; it ships in every JDK and is the only
  zero-dependency option. The alternative (`HttpListener`-style raw sockets) is far more complex.
