# ADR-0001: Use Architecture Decision Records

**Status:** Accepted  
**Date:** 2026-04-28

## Context

This repository makes several non-obvious decisions: which languages to include,
which runtime constraints to impose, how to structure directories, and which port
to standardize on. Without documentation, contributors have no way to understand
why things are the way they are, and may accidentally revert intentional choices.

## Decision

We will use Architecture Decision Records (ADRs) in the Nygard format, stored in
`docs/adr/`, numbered sequentially with zero-padded four-digit identifiers
(e.g., `0001-use-adrs.md`).

ADRs are immutable once accepted. Superseding a decision requires a new ADR that
references the old one and sets the old one's status to "Superseded by ADR-XXXX".

## Consequences

- New contributors can read `docs/adr/` to understand the project's constraints before opening PRs.
- Decisions have a traceable rationale.
- ADR maintenance is a small ongoing cost (new ADR per significant decision).
- We use the simplest possible format — plain Markdown, no tooling required.
