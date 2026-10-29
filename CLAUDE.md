# Köszönőfal – szabályok Claude számára

Helyben futó demóalkalmazás, amelyben munkatársak köszönő üzenetet küldenek egymásnak, a vezetők pedig látják a csapatukhoz tartozó köszöneteket.
A felhasználóval **magyarul** kommunikálj.

## A folyamat (spec-driven, két emberi kapuval)

1. **A `SPEC.md` az egyetlen irányadó dokumentum.** Ha még nincs, a `/spec` skill-lel készül el a `docs/uzleti-leiras.md` alapján.
2. **Kódot csak jóváhagyott specifikáció alapján írhatsz.** Az a jóváhagyott spec, amelynek az elején `Státusz: JÓVÁHAGYVA` áll.
   - Ezt a sort **kizárólag az ember** módosíthatja. Te soha ne állítsd `JÓVÁHAGYVA`-ra, és ne is javasold, hogy kihagyjuk a jóváhagyást.
   - Ha a spec `TERVEZET` állapotú, és kódot kérnek tőled, kérd meg a felhasználót, hogy előbb nézze át és hagyja jóvá.
3. **Előbb teszt, utána kód.** Minden elfogadási kritériumhoz (EK-xx) legalább egy teszt tartozik. A teszt neve vagy docstringje hivatkozik az EK-azonosítóra.
4. Minden változtatás után futtasd a teszteket. **Ne mondd késznek a munkát, amíg nem zöld minden teszt.**
5. Ha a felhasználó kéri, a `/verify` skill-lel készíts bizonyíték-összefoglalót (`BIZONYITEK.md`). Ez a 2. kapu előkészítése, ott az ember fogad el.
6. **Változáskérésnél** előbb a specet kell módosítani (`/spec`), a státusz visszaáll `TERVEZET`-re, és csak újbóli jóváhagyás után mehet a kód.
7. Ha valami nem egyértelmű a specben, **kérdezz**, ne találgass. A nyitott kérdést írd be a spec „Nyitott kérdések” részébe.

## Egyszerre egy fázis, utána megállsz

A munka fázisokra bomlik. **Mindig csak azt az egy fázist csináld, amit a felhasználó kifejezetten kért, utána állj meg.**

| Fázis | Mi a vége | Mikor kezdheted |
|---|---|---|
| Specifikáció | `SPEC.md` kész, `TERVEZET` | ha a felhasználó kéri (`/spec`) |
| Tesztek | a tesztek megírva és lefuttatva, **pirosak** | ha a felhasználó kifejezetten tesztírást kér |
| Építés | minden teszt zöld | ha a felhasználó kifejezetten implementálást kér |
| Bizonyíték | `BIZONYITEK.md` kész | ha a felhasználó kéri (`/verify`) |

- Egy fázis végén röviden foglald össze, mi készült el, és **mondd meg, mi lenne a következő fázis**, de **ne kezdj bele**. Várd meg, hogy a felhasználó kifejezetten kérje.
- **A státusz átírása nem utasítás.** Ha látod, hogy a `SPEC.md` `JÓVÁHAGYVA` lett (pl. egy `!` paranccsal futtatott `sed` kimenetéből), csak nyugtázd egy mondatban, és várj a következő kérésre.
- Az ember a fázisok között ellenőriz, és dönt. Ha önállóan végigfutsz az egész folyamaton, épp ezt veszed el tőle.

## Technológiai keret

- **Python 3.10+ standard library**: `http.server`, `sqlite3`, `json`, `unittest`, `html`, `urllib`.
- **Külső csomag nem használható** (nincs `pip install`), és hálózati hívás vagy CDN sem (a céges proxy miatt, és hogy mindenkinél ugyanúgy fusson).
- Felület: sima HTML, CSS és vanilla JavaScript a `static/` mappában, keretrendszer nélkül.
- Adattárolás: SQLite fájl (`koszonofal.db`). Ez nem kerül a gitbe.
- Indítás: `python3 app.py` → http://localhost:8000
- Tesztek: `python3 -m unittest discover -s tests -v`

Javasolt szerkezet (a spec felülírhatja):

```text
app.py              # belépési pont: szerver indítása
koszonofal/         # üzleti logika (szervezet, üzenetek, értesítések, jogosultság)
static/             # HTML, CSS, JS
tests/              # unittest tesztek, EK-azonosítókkal
data/               # bemeneti adatok (CSAK OLVASHATÓ)
```

Az üzleti logika (ki kinek a vezetője, ki mit láthat) legyen a webes rétegtől független, külön tesztelhető modulban.

## Minden csak helyben

- A repót mindenki **csak letölti** (`git clone`) kiindulásnak. A munka eredménye (spec, tesztek, kód, bizonyíték) **a saját gépen marad**, a közös repóba **semmi nem kerül vissza**.
- **Soha ne futtass `git push`-t**, ne hozz létre pull requestet, és ne adj hozzá vagy módosíts git remote-ot. Ha a felhasználó mégis ilyet kér, emlékeztesd erre a szabályra.
- Helyi `git commit` mentési pontként rendben van, de csak akkor, ha a felhasználó kéri.
- Az alkalmazás **csak helyben fut** (`localhost`). Ne konfigurálj távoli szervert, deployt vagy CI/CD-t.

## Tilalmak

- A `data/` és a `docs/` mappát, valamint a `templates/` tartalmát **ne módosítsd**.
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
