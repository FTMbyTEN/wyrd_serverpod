# WYRD — a persistent mind, built on Serverpod

WYRD is an AI that keeps living when nobody is talking to it. Between conversations it reads the
news, questions itself, learns words, writes a diary and dreams — and it remembers each person
separately, in one memory shared by everything it does. You talk to it in **Dialogue Link**; it
can draw charts and run Python in your browser, build small apps, take on research tasks in the
background, play chess at full strength, and govern **NAIJA 2099**, a 2D Lagos with its own
traffic, police and economy.

**Who it's for:** anyone who wants an assistant that knows them over time instead of starting from
zero in every chat — first of all students and young people in Lagos (it answers in Pidgin and
Yoruba too).

## Try it

| | |
|---|---|
| **The app** (web) | **https://wryd00.serverpod.space** — sign up with an email, then talk to WYRD |
| **The Flutter client** | **https://wryd00.serverpod.space/flutter** — the same account, the same WYRD |
| The API | `https://wryd00.api.serverpod.space` (Serverpod RPC) |

**The core flow:** open the app → sign up → open Dialogue Link and ask WYRD something → tell it
something about yourself ("remember that my exam is on Friday") → start a new chat and ask what it
remembers → press **ENTER 3D** to look inside its mind.

## How it uses Serverpod

The whole backend is one **Serverpod 4** server in this repo (`wyrd_server/`), hosted on
**Serverpod Cloud**:

- **35 endpoints** — chat, the mind, memory, the task agent, games, the city, the owner's
  dashboard — called through the **generated client** (`wyrd_client/`), so every request and
  response is typed end to end.
- **55 database tables** through Serverpod's ORM and migrations: conversations and chats, WYRD's
  memory, beliefs and lexicon, tasks, game matches and ratings, and the city's ledger.
- **11 future calls** run WYRD's background life on a schedule — reading feeds, reasoning,
  questioning itself, the diary, dreams, sleep, growth snapshots and recurring tasks — so it keeps
  thinking with no client connected.
- **Serverpod Auth** (email sign-in) for accounts; owner-only features are checked on the server.
- **Serverpod's web server** hosts the web app, the Flutter client at `/flutter`, and a partner
  API under `/partner/v1`.
- **82 test files**, unit and integration — the integration tests use Serverpod's test tools
  against a real Postgres — with CI on every push.

The model behind WYRD's words is Claude (Haiku 5.5), called only from the server: no key ever
reaches a client.

## How it uses Flutter

`wyrd_flutter/` is WYRD's Flutter client: sign-in, Dialogue Link chat, WYRD's mind and brain, its
diary and dreams, the feed and your profile — all through the same generated Serverpod client and
the same backend as the web app. It runs on the web (served by the Serverpod web server at
`/flutter`), Android, iOS, Windows, macOS and Linux.

WYRD's main web app is written in React Native (Expo) and lives in a separate repository,
[FTMbyTEN/WYRD](https://github.com/FTMbyTEN/WYRD) (`mobile/`). Both clients use this server.

## What's in this repo

```
wyrd_server/    the Serverpod server -- lib/src/mind (chat, memory, the mind's background life),
                agent (the task agent), games, world (NAIJA 2099), drone, partner (the partner API)
wyrd_client/    the client Serverpod generates from the server, used by both apps
wyrd_flutter/   the Flutter client
```

`wyrd_server/README.md` describes the server's parts in more detail.

## Run it yourself

You need Dart, Flutter, the Serverpod CLI (`dart pub global activate serverpod_cli`) and Docker.

1. Copy `wyrd_server/config/passwords.example.yaml` to `wyrd_server/config/passwords.yaml` and
   fill it in (the comments say how).
2. Start the database and the server:

   ```bash
   cd wyrd_server
   docker compose up --build --detach
   dart bin/main.dart --apply-migrations
   ```

3. In another terminal, start the Flutter client:

   ```bash
   cd wyrd_flutter
   flutter run -d chrome
   ```

Without an Anthropic API key WYRD still runs and answers from what it has learned, but without the
model. Tests: `cd wyrd_server && dart test`.
