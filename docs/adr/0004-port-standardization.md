# ADR-0004: Standardize on Port 8080

**Status:** Accepted  
**Date:** 2026-04-28

## Context

Each server needs a port to listen on. Using different ports per language would
complicate benchmarking, documentation, and mental overhead for contributors.
Port 80 requires root/admin privileges on most systems. Port 3000, 5000, and 8000
are common but have conflicting defaults across ecosystems.

## Decision

All servers listen on **port 8080**, hardcoded in each source file.

Port 8080 is:
- Universally recognized as an alternate HTTP port.
- Unprivileged (above 1024) on all target operating systems — no `sudo` required.
- Not owned by any single ecosystem's convention.
- Overridable via the `PORT` variable in the Makefile for contributors
  who need flexibility (though the source files themselves always default to 8080).

## Consequences

- Only one server can run at a time on the same machine using the defaults.
- The Makefile documents this limitation explicitly.
- Benchmarking scripts can target `http://localhost:8080` without parameterization.
- A future task (TASK-001: Docker support) will allow all servers to run concurrently
  on different mapped ports (8081–8084).
