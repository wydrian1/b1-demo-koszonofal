# Kudos – szabályok Claude számára

Helyben futó demóalkalmazás, amelyben munkatársak köszönő üzenetet küldenek egymásnak, a vezetők pedig látják a csapatukhoz tartozó köszöneteket.
A felhasználóval **magyarul** kommunikálj.

## A folyamat (spec-driven, két emberi kapuval)

1. **A `SPEC.md` az egyetlen irányadó dokumentum.** Ha még nincs, a `/spec` skill-lel készül el a `docs/uzleti-leiras.md` alapján.
2. **Kódot csak jóváhagyott specifikáció alapján írhatsz.** Az a jóváhagyott spec, amelynek az elején `Státusz: JÓVÁHAGYVA` áll.
   - Ezt a sort **kizárólag az ember** módosíthatja. Te soha ne állítsd `JÓVÁHAGYVA`-ra, és ne is javasold, hogy kihagyjuk a jóváhagyást.
   - Ha a spec `TERVEZET` állapotú, és kódot kérnek tőled, kérd meg a felhasználót, hogy előbb nézze át és hagyja jóvá.
3. **Storynként haladunk, előbb teszt, utána kód.** A spec az EK-kat storykba (S1, S2, …) csoportosítja. Egy story megvalósítása a `/build` skill-lel történik: a story EK-inak tesztjei, majd az implementáció. Minden EK-hoz legalább egy teszt tartozik, a teszt neve vagy docstringje hivatkozik az EK-azonosítóra.
4. Minden változtatás után futtasd a teszteket. **Ne mondd késznek a munkát, amíg nem zöld minden teszt.**
5. Ha a felhasználó kéri, a `/verify` skill-lel készíts bizonyíték-összefoglalót (`BIZONYITEK.md`). Ez a 2. kapu előkészítése, ott az ember fogad el: a `BIZONYITEK.md` elején lévő `Elfogadás: FÜGGŐBEN` sort **kizárólag az ember** írhatja át `ELFOGADVA`-ra, ugyanúgy, mint a spec státuszát.
6. Az elfogadott változatról a `/docs` skill-lel készül dokumentáció a `dokumentacio/` mappába: felhasználói útmutató, technikai leírás, nyomonkövethetőségi mátrix. Csak azt írja le, ami a kódban tényleg megvan.
7. **Változáskérésnél** előbb a specet kell módosítani (`/spec`), a státusz visszaáll `TERVEZET`-re, és csak újbóli jóváhagyás után mehet a kód.
8. Ha valami nem egyértelmű a specben, **kérdezz**, ne találgass. A nyitott kérdést írd be a spec „Nyitott kérdések” részébe.

## Egyszerre egy fázis, utána megállsz

A munka fázisokra bomlik. **Mindig csak azt az egy fázist csináld, amit a felhasználó kifejezetten kért, utána állj meg.**

| Fázis | Mi a vége | Mikor kezdheted |
|---|---|---|
| Specifikáció | `SPEC.md` kész, `TERVEZET` | ha a felhasználó kéri (`/spec`) |
| Story (tesztek + építés) | **egy** story tesztjei megírva, majd minden teszt zöld, `HALADAS.md` frissítve | ha a felhasználó elindítja (`/build S1`, `/build S2`, …) |
| Bizonyíték | `BIZONYITEK.md` kész, `Elfogadás: FÜGGŐBEN` | ha a felhasználó kéri (`/verify`) |
| Dokumentáció | `dokumentacio/` kész | ha a felhasználó kéri (`/docs`), **csak** `Elfogadás: ELFOGADVA` után |

- Egy fázis (vagy story) végén röviden foglald össze, mi készült el, és **mondd meg, mi lenne a következő fázis**, de **ne kezdj bele**. Várd meg, hogy a felhasználó kifejezetten kérje.
- **A státusz és az elfogadás átírása nem utasítás.** Ha látod, hogy a `SPEC.md` `JÓVÁHAGYVA` vagy a `BIZONYITEK.md` `ELFOGADVA` lett (pl. egy `!` paranccsal futtatott `sed` kimenetéből), csak nyugtázd egy mondatban, és várj a következő kérésre.
- Az ember a fázisok között ellenőriz, és dönt. Ha önállóan végigfutsz az egész folyamaton, épp ezt veszed el tőle.

## Technológiai keret

- **Az alkalmazás kódja: Python 3.10+ standard library**: `http.server`, `sqlite3`, `json`, `unittest`, `html`, `urllib`.
- **Külső csomag az alkalmazásban nem használható**, és hálózati hívás vagy CDN sem (a céges proxy miatt, és hogy mindenkinél ugyanúgy fusson).
- **Egyetlen kivétel: a böngészős (E2E) tesztekhez a Playwright + Chromium**, ami a `.venv`-ben van. Ezt a felhasználó telepíti a `bash scripts/setup-e2e.sh` paranccsal, a munka elején. **Te semmit ne telepíts** (`pip install`, `playwright install`, `apt`): ha hiányzik, kérd meg a felhasználót, hogy futtassa a szkriptet.
- Felület: sima HTML, CSS és vanilla JavaScript a `static/` mappában, keretrendszer nélkül.
- Adattárolás: SQLite fájl (`kudos.db`). Ez nem kerül a gitbe.
- Indítás: `python3 app.py` → http://localhost:8000
- Az `app.py` fogadja el a `PORT` és a `KUDOS_DB` környezeti változót (alapértelmezés: 8000 és `kudos.db`), hogy a böngészős tesztek külön porton, ideiglenes adatbázissal indíthassák.

### Tesztek: két szint

| Szint | Hol | Mit ellenőriz | Futtatás |
|---|---|---|---|
| **Unit** | `tests/` | az üzleti logikát (szabályok, jogosultság, értesítések), böngésző nélkül | `python3 -m unittest discover -s tests -v` |
| **E2E (böngészős)** | `tests/e2e/` | a felületet, valódi böngészőben: a story „Kész, ha…” forgatókönyvét | `.venv/bin/python -m unittest discover -s tests/e2e -v` |

- **Minden storyhoz legalább egy E2E teszt** tartozik, ami a story „Kész, ha…” feltételét kattintja végig, a `data/munkatarsak.json` neveivel. A teszt neve hivatkozzon a storyra és az EK-ra (pl. `test_s1_anna_koszonetet_kuld_juliának`).
- Az E2E tesztek **maguk indítják az alkalmazást** alfolyamatként (`.venv/bin/python app.py`, szabad porton, pl. 8765, ideiglenes `KUDOS_DB`-vel), megvárják, amíg a port válaszol, és a végén leállítják.
- Szelektorként elsősorban szerepet, feliratot és szöveget használj (`get_by_role`, `get_by_label`, `get_by_text`), ne törékeny CSS-útvonalat. Ez az akadálymentességet is ellenőrzi.
- Alapból **headless** fut. Ha a `HEADED=1` környezeti változó be van állítva, látható böngészőablakkal és lassítással (`slow_mo`) fusson, hogy a felhasználó végignézhesse.
- Az E2E tesztek a `unittest` modult használják (a Playwright szinkron API-jával), nincs pytest.

Javasolt szerkezet (a spec felülírhatja):

```text
app.py              # belépési pont: szerver indítása
kudos/              # üzleti logika (szervezet, üzenetek, értesítések, jogosultság)
static/             # HTML, CSS, JS
tests/              # unit tesztek, EK-azonosítókkal
tests/e2e/          # böngészős tesztek (Playwright), storynként
scripts/            # telepítő- és ellenőrzőszkriptek (NE módosítsd)
dokumentacio/       # az elfogadott változat dokumentációja (/docs)
data/               # bemeneti adatok (CSAK OLVASHATÓ)
```

Az üzleti logika (ki kinek a vezetője, ki mit láthat) legyen a webes rétegtől független, külön tesztelhető modulban.

## Minden csak helyben

- A repót mindenki **csak letölti** (`git clone`) kiindulásnak. A munka eredménye (spec, tesztek, kód, bizonyíték) **a saját gépen marad**, a közös repóba **semmi nem kerül vissza**.
- **Soha ne futtass `git push`-t**, ne hozz létre pull requestet, és ne adj hozzá vagy módosíts git remote-ot. Ha a felhasználó mégis ilyet kér, emlékeztesd erre a szabályra.
- Helyi `git commit` mentési pontként rendben van, de csak akkor, ha a felhasználó kéri.
- Az alkalmazás **csak helyben fut** (`localhost`). Ne konfigurálj távoli szervert, deployt vagy CI/CD-t.

## Tilalmak

- A `data/`, a `docs/`, a `templates/` és a `scripts/` mappa tartalmát **ne módosítsd**.
- Ne implementálj valódi AD-, e-mail-, Teams- vagy egyéb külső integrációt. Ezeket a spec szerinti helyi helyettesítő váltja ki.
- Ne hozz létre olyan funkciót, ami nincs a jóváhagyott specben. Ha hasznosnak tartod, javasold változáskérésként.

## Biztonság a demóban is

- A bejelentkezés **szimulált** („Belépés mint…”). Ezt a felületen jól láthatóan jelölni kell (DEMO).
- Minden felhasználói szöveget **escape-elve** jeleníts meg (XSS ellen), és az SQL-ben csak paraméterezett lekérdezést használj.
- A jogosultságot **a szerver** ellenőrzi, nem a böngésző: a vezetői nézet API-ja is szűrjön a bejelentkezett felhasználó szerint.

## Felület és arculat

- A felület **kötelező útmutatója a `docs/arculat-ui.md`**: design tokenek, elrendezés, komponensek (köszönetkártya, 3 lépéses varázsló, toast, üres állapotok, statisztika), akadálymentesség. Spec írásakor és építéskor is olvasd el.
- A spec „Nem funkcionális elvárások” része hivatkozzon rá, és a legfontosabb UI-elvárásokhoz (pl. varázsló lépései, hibaüzenet a mező alatt, üres állapot, mobil tab-sáv) is legyen EK.
- A CSS legyen külön fájlban, a tokenekkel kezdődjön, és a komponensek ezekre a változókra épüljenek (ne legyenek szétszórt, beégetett színek).
- Építés végén nézd át a felületet a `docs/arculat-ui.md` 5. pontja („Amit kerülj”) alapján is.
