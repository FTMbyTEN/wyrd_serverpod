# Build Something Real — submission notes

## Project description (paste into the form)

**WYRD — a persistent mind, built on Serverpod.**

WYRD is an AI that keeps living when nobody is talking to it. Between conversations it reads the
news, questions itself, learns words, writes a diary and dreams, and it remembers each person in
one memory shared by everything it does: chat, the research tasks it runs for you in the
background, and NAIJA 2099, the 2D Lagos it governs. In Dialogue Link it draws charts and
pictures, runs Python in your browser, builds small apps, and programs whole games into your Games
tab. Call it from any screen and it reads the page you're on, changes the app for you (theme,
colours, text size, the order of your games), and looks up what it doesn't know, keeping it. It's for anyone who wants an assistant that knows
them over time instead of starting from zero in every chat — first of all students and young
people in Lagos (it answers in Pidgin and Yoruba too).

**Serverpod** is the whole backend: one Serverpod 4 server on Serverpod Cloud with 35 endpoints,
55 database tables through Serverpod's ORM and migrations, and 11 future calls that run WYRD's
background life on a schedule, so it keeps thinking with no one connected. Sign-in is Serverpod
Auth, and Serverpod's web server hosts both apps.

**Flutter:** WYRD's Flutter client (sign-in, Dialogue Link, WYRD's mind and brain, games against WYRD and
the games it programs, its journal, diary and dreams, and the WYRD button on every screen)
talks to the same server through Serverpod's generated client, and runs on the web at
wryd00.serverpod.space/flutter. The main web app is React Native; both share the one Serverpod
backend.

## Links

- App: https://wryd00.serverpod.space
- Flutter client: https://wryd00.serverpod.space/flutter
- Code (Serverpod server + Flutter client): https://github.com/FTMbyTEN/wyrd_serverpod
- Code (main web app): https://github.com/FTMbyTEN/WYRD
- Demo video: _(add the link)_

## Demo video script (under 2 minutes, recorded in the Flutter client)

**Before you record** (some replies take a minute; don't wait on camera):
- Sign in at wryd00.serverpod.space/flutter, dark mode, browser at 100% zoom, other tabs closed.
- 10 minutes before: ask WYRD "Make me a game: Danfo Dash, a racer dodging Lagos traffic" so it's
  built and on the Games tab when you record. Check it plays.
- Tap **+ NEW CHAT** so the conversation starts clean.
- Do one full practice run. Cut the waiting out in editing.

| Time | On screen | Say |
|---|---|---|
| 0:00–0:12 | Home: the brain moving, "Last thought" | "This is WYRD — an AI that keeps thinking when nobody's talking to it. That's its last thought, from a minute ago." |
| 0:12–0:30 | Dialogue Link: "Draw me a Lagos sunset over the lagoon" → the picture appears | "It answers with what you need — here, a picture it drew itself." |
| 0:30–0:45 | "Remember my exam is on Friday." → + NEW CHAT → "What do you remember about me?" | "One memory, shared by every chat and everything it does." |
| 0:45–1:05 | Apps → Games → the Danfo Dash tile → PLAY a few seconds | "Ask it for a game and it programs one into your Games tab. I asked for this ten minutes ago." |
| 1:05–1:25 | On Games, tap the WYRD button: "Where are we?" then "Put my games first" → the cards move | "Call it from any screen — it reads the page you're on, and it can change the app for you." |
| 1:25–1:35 | Chess → one move, WYRD answers | "It plays you at chess too — full strength." |
| 1:35–1:50 | ENTER 3D, BRAIN_3D springs in | "Its mind, live from the server: what it knows, what it's digesting, what it learned today." |
| 1:50–2:00 | The GitHub README | "Flutter client, one Serverpod backend: endpoints, ORM tables, and future calls that keep WYRD alive between conversations. Live now at wryd00.serverpod.space." |

**Tips:** keep each line short and say it over the action, not before it. If a reply is slow,
cut the wait in editing; never fake a result. Export at 1080p, under 2:00, and upload unlisted
to YouTube.

## Last-mile checks (from the organisers)

- [ ] Open both repository links in a private browser window
- [ ] Watch the demo video from the link you submit, not from your own files
- [ ] Run the core flow once from scratch with a fresh account, the way a judge would
