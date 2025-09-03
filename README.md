## 2048 Telegram Bot

A minimal Telegram bot that launches a Web App (mini app) for a 2048-like game/promo experience. Built with Aiogram v3 and designed to run locally or in Docker.

### Features
- **/start greeting**: Sends an HTML-formatted welcome message in Russian.
- **Web App launcher**: Inline button “Поехали! 🚀” opens the Web App at `https://frontend.mmtgame.ru/`.
- **Chat menu button**: Sets persistent “Играть” menu button linking to the same Web App.
- **Long polling**: Uses Dispatcher polling with Aiogram v3.

### Requirements
- **Python**: 3.12+
- One of:
  - **uv** (recommended) — see [uv docs](https://docs.astral.sh/uv/)
  - **Docker** or **Docker Compose**

### Configuration
- **Environment variables**:
  - `BOT_TOKEN` — Telegram Bot API token (from `@BotFather`).

Consider creating a local `.env` file:

```env
BOT_TOKEN=123456:ABC-DEF...
```

## Run locally (uv)
```powershell
# 1) Install dependencies
uv sync

# 2) Run the bot
uv run -m src
```

## Run locally (pip)
If you prefer pip/venv (note: dependencies are defined in `pyproject.toml`).

```powershell
python -m venv .venv
./.venv/Scripts/Activate.ps1
pip install --upgrade pip
pip install aiogram>=3.22.0
python -m src
```

## Docker
Build and run using the provided multi-stage `Dockerfile` (uses `uv` in the builder stage, Python slim runtime):

```powershell
# Build image
docker build -t 2048-bot .

# Run container
docker run --rm -e BOT_TOKEN=$env:BOT_TOKEN 2048-bot
```

## Docker Compose
An example `compose.yaml` is included. Ensure the build context points to the repository root where the `Dockerfile` lives. From the project root:

```powershell
# If you keep BOT_TOKEN in .env (same dir as compose.yaml), Compose will pick it up
docker compose up --build -d

# View logs
docker compose logs -f
```

If your Compose file uses a different build context, either update it to `.` or run Compose from the directory that contains the `Dockerfile`.

## How it works
- Entry point: `python -m src` executes `src/__main__.py`.
- On `/start`, the bot replies with an HTML-formatted message and an inline keyboard button to open the Web App.
- Also sets a persistent chat menu button pointing to the same Web App URL.

## Useful links
- **Aiogram v3 docs**: https://docs.aiogram.dev/
- **uv docs**: https://docs.astral.sh/uv/

## License
Add your preferred license here (e.g., MIT).


