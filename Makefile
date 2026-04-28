.PHONY: go java nodejs dotnet help

PORT ?= 8080

help:
	@echo "just-listen — minimal HTTP server comparison"
	@echo ""
	@echo "Targets:"
	@echo "  make go      Run Go server      (requires Go 1.26+)"
	@echo "  make java    Run Java server    (requires JDK 25+)"
	@echo "  make nodejs  Run Node.js server (requires Node.js 24+)"
	@echo "  make dotnet  Run .NET server    (requires .NET 10+)"
	@echo ""
	@echo "All servers listen on port $(PORT). Run one at a time."
	@echo "Test with: curl -i http://localhost:$(PORT)/"

go:
	cd go && go run main.go

java:
	cd java && java Server.java

nodejs:
	cd nodejs && node server.js

dotnet:
	cd dotnet && dotnet run
