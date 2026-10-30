---
name: docs
description: A 2. kapu (elfogadás) után elkészíti a Kudos alkalmazás dokumentációját a dokumentacio/ mappába - felhasználói útmutató képernyőképekkel, technikai leírás és nyomonkövethetőségi mátrix -, a jóváhagyott SPEC.md, az elfogadott BIZONYITEK.md és a tényleges kód alapján. Kódot nem módosít.
---

# Dokumentáció az elfogadott változatról

Ez a skill **csak dokumentációt** készít. A kódhoz, a tesztekhez, a `SPEC.md`-hez és a `BIZONYITEK.md`-hez nem nyúlsz.

## 0. Előfeltételek

1. A `SPEC.md` elején `Státusz: JÓVÁHAGYVA` áll.
2. Van `BIZONYITEK.md`, és az elején `Elfogadás: ELFOGADVA` áll (ezt a 2. kapuban az ember írja át). Ha `FÜGGŐBEN` vagy hiányzik, **állj meg**: kérd meg a felhasználót, hogy előbb járja végig a 2. kaput. Az elfogadást te ne állítsd be.
3. Futtasd le az összes tesztet (unit és E2E). Ha valami piros, **állj meg**, és szólj: elfogadott állapotról csak zöld tesztekkel készülhet dokumentáció.
4. Írj ki egy rövid, látható tervet (5–8 sor): milyen dokumentumok készülnek, és mi lesz bennük (lásd lent).

## 1. A dokumentumok

Mindegyik előtt írj ki egy rövid státuszsort (pl. `📘 2/4 – Technikai leírás`). Minden dokumentumot **szakaszonként**, kis szerkesztésekkel írj, ne egyetlen nagy fájlírással.

1. **`dokumentacio/kepek/`: képernyőképek.** Írj egy kis szkriptet (`dokumentacio/kepek_keszitese.py`), ami a `.venv` Playwrightjával, **ideiglenes `KUDOS_DB`-vel és külön porton** elindítja az alkalmazást, létrehoz néhány minta-köszönetet a `data/munkatarsak.json` neveivel, és képet készít a kulcsképernyőkről: belépés, köszönetküldő varázsló (mindhárom lépés), saját lista, közös fal, értesítések, vezetői nézet statisztikával, és mobilnézet (keskeny ablak). Futtasd le: `.venv/bin/python dokumentacio/kepek_keszitese.py`. A felhasználó `kudos.db`-jét ne használd és ne módosítsd.
2. **`dokumentacio/felhasznaloi-utmutato.md`: üzleti felhasználóknak**, közérthetően, szakzsargon nélkül:
   - mire való a Kudos, és kinek,
   - belépés (DEMO), köszönet küldése lépésről lépésre, a képekkel,
   - saját köszönetek, közös fal, 👏, értesítések,
   - vezetőknek: vezetői nézet és statisztika, és **ki mit lát** (egy táblázat szerepkörönként: munkatárs, B-2, B-1, B),
   - szabályok egyszerűen (pl. napi 3 köszönet ugyanannak, privát és nyilvános),
   - gyakori kérdések (3–5 db).
3. **`dokumentacio/technikai-leiras.md`: fejlesztőknek és üzemeltetőknek**:
   - architektúra: modulok és felelősségük, egy egyszerű ábra (Mermaid `flowchart`),
   - adatmodell: táblák, mezők, kulcsok (a tényleges sémából),
   - HTTP végpontok: metódus, útvonal, ki hívhatja, mit ad vissza (a tényleges kódból),
   - jogosultsági logika: hogyan számolódik a vezető köre és a B-1 vezető,
   - konfiguráció (`PORT`, `KUDOS_DB`), futtatás, tesztek (unit, E2E, `HEADED=1`),
   - biztonsági megoldások (escape, paraméterezett SQL, szerveroldali jogosultság),
   - ismert korlátok (a spec „Kimarad” része és a `BIZONYITEK.md` korlátai).
4. **`dokumentacio/nyomonkovethetoseg.md`: auditálhatóság.** Egy mátrix: EK → story → teszt(ek) → megvalósító kód (fájl és függvény) → eredmény. A végén a spec verziója, az elfogadás dátuma és a tesztek összesítése.
5. **`dokumentacio/README.md`: tartalomjegyzék** a fenti dokumentumokra, egy-egy mondattal.

## 2. Szabályok

- **Csak azt írd le, ami a kódban tényleg megvan, és el lett fogadva.** A forrás a kód, a `SPEC.md` és a `BIZONYITEK.md`. Ne találj ki funkciót, és ne írj le tervezett, de meg nem valósított dolgot.
- Ha **eltérést** találsz a spec és a kód között, ne javítsd a kódot. Írd be a technikai leírás „Eltérések” részébe, és jelezd az összefoglalóban.
- Magyarul, rövid mondatokkal, a felhasználói útmutatóban tegező formában.
- A képekre relatív útvonallal hivatkozz (`kepek/…png`), hogy a Markdown-nézőkben is megjelenjenek.

## 3. Lezárás és megállás

1. Írd ki a felhasználónak egy táblázatban a létrejött dokumentumokat (fájl, kinek szól, terjedelem), a képek számát, és az esetleges eltéréseket.
2. Javasold, hogyan nézze meg: pl. VS Code-ban a Markdown-előnézettel (`Ctrl+Shift+V`), vagy `! ls dokumentacio`.
3. **Állj meg.**
