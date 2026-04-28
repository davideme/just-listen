# Open Tasks

Open contributions available for community pick-up.
Each task maps to a GitHub issue — claim one by commenting on it.

---

## TASK-001: Add Docker support per language

**Labels:** `enhancement`, `good first issue`, `help wanted`  
**Difficulty:** Easy  
**Languages affected:** All four

### Description

Add a `Dockerfile` to each language directory so the server can be run in a
container without any local runtime installed. Add a root `docker-compose.yml`
so all four servers can run concurrently on different ports.

### Acceptance Criteria

- [ ] Each language directory contains a `Dockerfile` using an official image
- [ ] Container exposes port 8080 and server starts on `docker run`
- [ ] `docker build -t just-listen-<lang> .` succeeds from within the language directory
- [ ] `docker run -p 8080:8080 just-listen-<lang>` → `curl localhost:8080` returns 200
- [ ] Root `docker-compose.yml` maps each language to a different host port (8081–8084)
- [ ] README updated with Docker instructions

---

## TASK-002: Add CI/CD with GitHub Actions (matrix build)

**Labels:** `enhancement`, `ci`, `help wanted`  
**Difficulty:** Medium

### Description

Add a GitHub Actions workflow that starts each server in a matrix, sends a `curl`
request, and verifies the HTTP 200 response.

### Acceptance Criteria

- [ ] `.github/workflows/ci.yml` uses a matrix strategy across all four languages
- [ ] Each job: installs the runtime, starts the server in the background,
      waits for it to be ready, runs `curl -f http://localhost:8080/`, exits cleanly
- [ ] Workflow runs on every push to `main` and on every pull request
- [ ] CI status badge added to README

---

## TASK-003: Add benchmarking with wrk or hey

**Labels:** `enhancement`, `benchmarking`  
**Difficulty:** Medium

### Description

Add a `benchmarks/` directory with a script that runs each server and benchmarks
it using `wrk` or `hey`, collecting requests/sec, p50/p99 latency, and errors.

### Acceptance Criteria

- [ ] `benchmarks/run.sh` is executable and accepts a language name (or `all`)
- [ ] Script starts the server, waits for readiness, benchmarks, prints results, shuts down
- [ ] Results printed as: language, req/sec, p50, p99
- [ ] README comparison table updated with benchmark results (reference machine documented)
- [ ] `benchmarks/results/` added to `.gitignore`

---

## TASK-004: Add HTTPS variant per language

**Labels:** `enhancement`  
**Difficulty:** Hard

### Description

Add an HTTPS variant of each server using self-signed certificates and each
language's SDK TLS support. No external TLS libraries allowed.

### Acceptance Criteria

- [ ] Each language directory gains an `https/` subdirectory
- [ ] Shared `certs/` directory at repo root with a script to generate self-signed cert + key
- [ ] Each HTTPS server listens on port 8443
- [ ] `curl -k https://localhost:8443/` returns HTTP 200
- [ ] SDK TLS only — no external certificate libraries
- [ ] README documents the HTTPS variants
- [ ] `certs/*.pem` and `certs/*.key` in `.gitignore`

---

## TASK-005: Add "Hello, World!" response body

**Labels:** `enhancement`, `good first issue`  
**Difficulty:** Easy  
**Languages affected:** All four

### Description

Currently all servers return an empty body. Add a `Hello, World!` text response
body to each, keeping the implementation as minimal as possible.

### Acceptance Criteria

- [ ] Each server responds with `Content-Type: text/plain`
- [ ] Response body is exactly `Hello, World!\n`
- [ ] `curl http://localhost:8080/` outputs `Hello, World!`
- [ ] LOC increase is minimal (1–3 lines per language)
- [ ] README comparison table updated (LOC counts, example output)

---

## TASK-006: Add a `/health` endpoint

**Labels:** `enhancement`  
**Difficulty:** Easy–Medium

### Description

Add a dedicated `/health` endpoint returning `{"status":"ok"}` with
`Content-Type: application/json`. All other paths continue to return 200.

### Acceptance Criteria

- [ ] `GET /health` → `200 {"status":"ok"}` with `Content-Type: application/json`
- [ ] All other paths continue to return `200`
- [ ] Each implementation remains SDK-only
- [ ] `curl http://localhost:8080/health` outputs `{"status":"ok"}`
- [ ] README updated to document the health endpoint
