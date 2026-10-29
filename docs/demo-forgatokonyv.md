# Levezetői forgatókönyv – Köszönőfal demó (kb. 3 óra)

## Cél

A résztvevők saját kezűleg végigvisznek egy kis fejlesztést **spec-driven** módon, Claude Code-dal, és közben élőben látják mindazt, amiről a délelőtti előadás szólt:
kontextus és `CLAUDE.md`, toolok, skillek, az agentic loop (olvas → szerkeszt → futtat → piros → javít), valamint az RBI AI-native SDLC két emberi kapuja.

**Nem cél**, hogy hibátlan alkalmazás készüljön, vagy hogy mindenki befejezze a munkát. Az a cél, hogy a résztvevők megtapasztalják a folyamatot.

## Előkészítés (a workshop előtt)

- [ ] Minden gépen: WSL, `python3 --version` legalább 3.10, `git`, `claude --version`
- [ ] Claude Code beállítva az RBI LLM gatewayre, a modell elérhető (pl. Sonnet 5.5). Próbaüzenet: `claude -p "szia"`
- [ ] A repó klónozható a résztvevők gépéről (hozzáférés, proxy)
- [ ] Levezetőként egy teljes próbafutás előre, időméréssel
- [ ] Tartalék: egy előre elkészült, jóváhagyott `SPEC.md` (ha valaki elakad a spec-lépésnél, attól folytathatja)

## Időbeosztás

| Idő | Lépés | Résztvevő teendője | Mire mutass rá |
|---|---|---|---|
| 0:00 | **Indulás** | `git clone`, `cd`, `claude` | A harness betölti a `CLAUDE.md`-t: ez a „projekt-utasítás” a kontextusban |
| 0:15 | **Specifikáció** | `/spec`, válasz a kérdésekre | Skill működés közben: az ágens kérdez, nem találgat |
| 0:45 | **🟡 1. kapu** | `SPEC.md` átnézése, javíttatás, majd **saját kézzel** `Státusz: JÓVÁHAGYVA` | Az ember dönt, az ágens nem hagyhatja jóvá saját magát |
| 0:55 | **Tesztek** | „Írd meg a teszteket az EK-khoz, még implementáció nélkül.” | Minden kritérium ellenőrizhetővé válik. Futtatás → piros |
| 1:15 | ☕ Szünet | | |
| 1:25 | **Építés** | „Implementáld a jóváhagyott spec szerint, amíg minden teszt zöld.” | Az agentic loop élőben: tool-hívások, engedélykérések, piros → javít |
| 2:25 | **🟡 2. kapu** | `/verify`, `BIZONYITEK.md` elolvasása, kattintós forgatókönyv | Bizonyíték alapján fogadunk el, nem érzésre |
| 2:45 | **Változáskérés** (opcionális) | Lásd lent | A változás is a specen és a kapun megy át |
| 3:00 | **Visszatekintés** | Kerekasztal | Lásd a kérdéseket lent |

## Javasolt promptok lépésenként

**Indulás után** (opcionális bemelegítő):

```text
Foglald össze 5 pontban, milyen szabályok szerint fogsz dolgozni ebben a projektben.
```

Itt látszik, hogy a `CLAUDE.md` bekerült a kontextusba.

**Specifikáció:**

```text
/spec
```

**Jóváhagyás után, tesztek:**

```text
A SPEC.md jóvá van hagyva. Írd meg a teszteket az összes EK-hoz a tests/ mappába,
implementáció nélkül. Futtasd le őket, és mutasd meg, hogy pirosak.
```

**Építés:**

```text
Implementáld az alkalmazást a jóváhagyott SPEC.md szerint. Haladj EK-ról EK-ra,
minden lépés után futtasd a teszteket, és addig dolgozz, amíg minden zöld nem lesz.
```

**Bizonyíték:**

```text
/verify
```

## Kattintós forgatókönyv (2. kapu)

`python3 app.py`, majd http://localhost:8000

1. Lépj be **Horváth Anna** (Fejlesztési Osztály) néven.
2. Új köszönet: keress rá arra, hogy „adat”, és válaszd ki **Farkas Júliát**. Üzenet: „Köszönöm a gyors adatelemzést! 🙏🎉” → ellenőrző nézet → küldés → visszaigazolás.
3. Próbáld meg Horváth Annaként saját magadnak küldeni → a rendszer nem engedi. Üres üzenettel is próbáld meg → nem engedi.
4. Horváth Anna „Küldött” listájában ott az üzenet.
5. Lépj be **Farkas Júliaként**: van értesítés, és a „Kapott” listában ott az üzenet.
6. Lépj be **Szabó Katalinként** (Júlia vezetője): van értesítés, és a vezetői nézetben látszik az üzenet.
7. Lépj be **Kovács Eszterként** (B-1): van értesítés, és a vezetői nézetben látszik az üzenet.
8. Lépj be **Nagy Péterként** (Anna vezetője): **nincs** értesítés (nem ő a címzett vezetője), de a vezetői nézetben **látja** az üzenetet, mert a küldő a beosztottja.
9. Lépj be **Tóth Gáborként**: sem értesítés, sem üzenet nincs a vezetői nézetében.
10. Lépj be **Varga Bence** (nem vezető) néven: a vezetői nézet nem érhető el.

A 8. és a 9. lépés a legérdekesebb: itt derül ki, hogy a jogosultsági logika tényleg a spec szerint működik-e.

## Változáskérés-ötletek (ha marad idő)

- **Statisztika a vezetői nézetben:** az elmúlt 30 napban küldött és kapott köszönetek száma a vezető körében.
- **Emoji-gyorsgombok:** 5 gyakori emoji egy kattintással beszúrható.
- **Képfeltöltés:** PNG/JPG, legfeljebb 2 MB. Jó vitatéma, mert ütközik a „Kimarad” résszel: a hatókört is bővíteni kell.

A szabály: előbb `/spec` a kéréssel, a státusz visszaáll `TERVEZET`-re, majd jóváhagyás, és csak utána jöhet a kód.

## Visszatekintő kérdések

- Hol kellett beavatkoznod? Mit csinált volna rosszul az ágens, ha nincs spec?
- Mennyi időt vitt el a spec, és mennyit spórolt meg később?
- Mit láttál a „háttérben”: milyen toolokat hívott, mikor kért engedélyt?
- Melyik saját területi feladatotokhoz lenne használható ez a folyamat?

## Hibaelhárítás

| Tünet | Teendő |
|---|---|
| `claude` nem éri el a modellt | Gateway-beállítás és proxy ellenőrzése; `claude -p "szia"` |
| Az ágens `pip install`-t akar futtatni | Utasítsd el, és utalj a `CLAUDE.md` technológiai keretére |
| A 8000-es port foglalt | `python3 app.py` helyett a spec szerinti portparaméter, vagy állítsd le a másik folyamatot |
| Valaki elakad a spec-lépésnél | Adj neki tartalék `SPEC.md`-t, és hagyja jóvá ő maga |
| Az ágens körbe-körbe javít | Állítsd meg (Esc), kérdezd meg, mit gondol a hibáról, és szűkítsd a feladatot egy EK-ra |

## Az eredeti igény és a demó megfeleltetése

| Eredeti követelmény | Demóban |
|---|---|
| AD + SSO bejelentkezés | `data/munkatarsak.json` + „Belépés mint…” (DEMO jelzéssel) |
| AD-alapú címzettkereső | Keresés a JSON-ban név, egység vagy e-mail szerint |
| Emoji-támogatás | Unicode emoji a szövegben |
| Képfeltöltés, vírusellenőrzés | Kimarad (változáskérés-ötlet) |
| E-mail / Teams értesítés | Alkalmazáson belüli értesítés |
| Közvetlen és B-1 vezető értesítése | Megmarad, a JSON-hierarchiából számolva |
| Vezetői nézet felelősségi kör szerint | Megmarad (a demó szíve) |
| Statisztikák | Kimarad (változáskérés-ötlet) |
| Admin, moderáció, riport | Kimarad |
| Naplózás, megőrzés, DPIA | Kimarad (beszélgetési téma: élesben ez kötelező) |
| Arculat, reszponzivitás, WCAG | Raiffeisen színek, reszponzív, billentyűzettel kezelhető (alapszint) |
| Szerveres üzemeltetés, CI/CD | Helyben fut: `python3 app.py` |
