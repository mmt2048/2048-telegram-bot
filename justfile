set shell := ["bash", "-uc"]
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

dc := "docker compose"

# List available recipes
default:
    @just --list

[private]
[no-exit-message]
[windows]
check-docker:
    @powershell -Command "if ((Get-Process 'com.docker.backend' -ErrorAction SilentlyContinue) -or (Get-Process 'dockerd' -ErrorAction SilentlyContinue)) { Write-Host 'Docker is running'; exit 0 } else { Write-Host 'Docker is not running'; exit 1 }"

[private]
[no-exit-message]
[unix]
check-docker:
    @if docker info > /dev/null 2>&1; then echo "Docker is running"; else echo "Docker is not running"; exit 1; fi

# Start App
up: check-docker
    {{dc}} up --build -d
    @just logs

# Stop App
down: check-docker
    {{dc}} down

# Restart App
restart: down up

# Show logs
logs tail="200": check-docker
    {{dc}} logs -f --tail={{tail}}