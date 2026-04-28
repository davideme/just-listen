# just-listen

[![CI](https://github.com/davideme/just-listen/actions/workflows/ci.yml/badge.svg)](https://github.com/davideme/just-listen/actions/workflows/ci.yml)

> The simplest possible HTTP server, in 4 languages.

Each implementation listens on **port 8080**, replies with **HTTP 200** to any
request, and uses **only the standard SDK** — no frameworks, no external dependencies.

## Why?

To see what each language looks like at the floor: before frameworks, before
abstractions, before opinions. Run them, read them, compare them.

## Quick Start

Each server must be run individually (they all use port 8080).

| Language | Command | Prerequisite |
|----------|---------|--------------|
| Go | `make go` | Go 1.26+ |
| Java | `make java` | JDK 25+ |
| Node.js | `make nodejs` | Node.js 24 LTS+ |
| .NET | `make dotnet` | .NET 10+ |

Test any server with:

```bash
curl -i http://localhost:8080/
```

Expected response: `HTTP/1.1 200 OK`

## Implementations

### Go (`go/`)

Uses [`net/http`](https://pkg.go.dev/net/http) from the Go standard library.
An empty handler causes `net/http` to flush a 200 automatically.

```go
package main

import "net/http"

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {})
	http.ListenAndServe(":8080", nil)
}
```

**Run:** `make go` or `cd go && go run main.go`

---

### Java (`java/`)

Uses [`com.sun.net.httpserver.HttpServer`](https://docs.oracle.com/en/java/javase/25/docs/api/jdk.httpserver/com/sun/net/httpserver/HttpServer.html) — ships in every JDK.
Uses **JEP 512 Compact Source Files** (finalized in Java 25): no `class` declaration,
no `javac` step. Uses **virtual threads** (`Executors.newVirtualThreadPerTaskExecutor()`)
for modern Java concurrency.

```java
import com.sun.net.httpserver.HttpServer;
import java.net.InetSocketAddress;
import java.util.concurrent.Executors;

void main() throws Exception {
    var server = HttpServer.create(new InetSocketAddress(8080), 0);
    server.createContext("/", e -> { e.sendResponseHeaders(200, -1); e.close(); });
    server.setExecutor(Executors.newVirtualThreadPerTaskExecutor());
    server.start();
}
```

**Run:** `make java` or `cd java && java Server.java`

---

### Node.js (`nodejs/`)

Uses the built-in [`node:http`](https://nodejs.org/api/http.html) module with ES
module syntax. `node:` prefix is canonical in Node.js 24.

```js
import { createServer } from 'node:http';

createServer((req, res) => res.end()).listen(8080);
```

**Run:** `make nodejs` or `cd nodejs && node server.js`

---

### .NET (`dotnet/`)

Uses [ASP.NET Core Minimal APIs](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis)
via `Microsoft.NET.Sdk.Web` (ships with the .NET 10 SDK — no `dotnet add package`).
Kestrel serves HTTP directly.

```csharp
var app = WebApplication.Create();
app.MapGet("/", () => Results.Ok());
app.Run("http://0.0.0.0:8080");
```

**Run:** `make dotnet` or `cd dotnet && dotnet run`

---

## Comparison

| Language | Version | LOC | Run command | HTTP primitive | Concurrency model |
|----------|---------|-----|-------------|----------------|-------------------|
| Go | 1.26 | 5 | `go run main.go` | `net/http` | Goroutines |
| Java | 25 | 8 | `java Server.java` | `com.sun.net.httpserver` | Virtual threads |
| Node.js | 24 | 2 | `node server.js` | `node:http` | Event loop |
| .NET | 10 | 3 | `dotnet run` | Kestrel (`Sdk.Web`) | Thread pool / async |

## Why not Python, Ruby, or PHP?

Python's `http.server`, Ruby's WEBrick, and PHP's `-S` dev server all explicitly
state they are not for production use. The ecosystem convention for each is to run
application code behind a separate production server (Gunicorn, Puma, PHP-FPM)
proxied by Nginx. These languages don't "serve HTTP themselves" in the same way
Go, Java, Node.js, and .NET do. See [ADR-0002](docs/adr/0002-language-selection.md).

## Architecture Decisions

All structural decisions are documented in [`docs/adr/`](docs/adr/):

| ADR | Decision |
|-----|----------|
| [0001](docs/adr/0001-use-adrs.md) | Use ADRs to document decisions |
| [0002](docs/adr/0002-language-selection.md) | Language selection rationale |
| [0003](docs/adr/0003-standard-library-only.md) | Standard SDK only — no external packages |
| [0004](docs/adr/0004-port-standardization.md) | Standardize on port 8080 |
| [0005](docs/adr/0005-directory-per-language.md) | One directory per language |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) and [TASKS.md](TASKS.md) for open work items.

## License

MIT
