# Build Something Real — submission notes

## Project description (paste into the form)

**WYRD — a persistent mind, built on Serverpod.**

WYRD is an AI that keeps living when nobody is talking to it. Between conversations it reads the
news, questions itself, learns words, writes a diary and dreams, and it remembers each person in
one memory shared by everything it does: chat, the research tasks it runs for you in the
background, and NAIJA 2099, the 2D Lagos it governs. In Dialogue Link it can draw charts, run
Python in your browser and build small apps. It's for anyone who wants an assistant that knows
them over time instead of starting from zero in every chat — first of all students and young
people in Lagos (it answers in Pidgin and Yoruba too).

**Serverpod** is the whole backend: one Serverpod 4 server on Serverpod Cloud with 35 endpoints,
55 database tables through Serverpod's ORM and migrations, and 11 future calls that run WYRD's
background life on a schedule, so it keeps thinking with no one connected. Sign-in is Serverpod
Auth, and Serverpod's web server hosts both apps.

**Flutter:** WYRD's Flutter client (sign-in, chat, WYRD's mind and brain, games against WYRD, its diary and dreams)
talks to the same server through Serverpod's generated client, and runs on the web at
wyrd00.serverpod.space/flutter. The main web app is React Native; both share the one Serverpod
backend.

## Links

- App: https://wryd00.serverpod.space
- Flutter client: https://wryd00.serverpod.space/flutter
- Code (Serverpod server + Flutter client): https://github.com/FTMbyTEN/wyrd_serverpod
- Code (main web app): https://github.com/FTMbyTEN/WYRD
- Demo video: _(add the link)_

## Demo video script (under 2 minutes)

| Time | On screen | Say |
|---|---|---|
| 0:00–0:12 | The home screen: the brain moving, "Last thought" | "This is WYRD. It's an AI that keeps thinking when you're not talking to it — this is its last thought, from a minute ago." |
| 0:12–0:35 | Open Dialogue Link, ask: "Draw me a chart of gold over the last 5 days: 4012, 4055, 3990, 3948, 3971, mark 3950 as support" | "It answers with a real chart, drawn right in the reply." |
| 0:35–0:55 | Say: "Remember that my exam is on Friday." New chat → "What do you remember about me?" | "It remembers me across chats — one memory, shared by everything it does." |
| 0:55–1:10 | ENTER 3D | "This is its mind: words it understands, what it's digesting, what it learned today — all live from the server." |
| 1:10–1:25 | The chess card → Accept → one move | "And it'll play you at chess, full strength." |
| 1:25–1:45 | Open wyrd00.serverpod.space/flutter, sign in, send a message | "This is the Flutter client — the same WYRD, the same Serverpod backend, through the generated client." |
| 1:45–2:00 | The GitHub repo README | "One Serverpod server: 35 endpoints, 55 tables, and future calls that keep WYRD alive between conversations. It's live now at wryd00.serverpod.space." |

## Last-mile checks (from the organisers)

- [ ] Open both repository links in a private browser window
- [ ] Watch the demo video from the link you submit, not from your own files
- [ ] Run the core flow once from scratch with a fresh account, the way a judge would
