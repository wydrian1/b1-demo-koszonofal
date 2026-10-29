---
name: build
description: Egyetlen story megvalósítása a jóváhagyott SPEC.md alapján: előbb a story EK-inak tesztjei (piros), utána az implementáció, amíg minden teszt zöld, majd megállás. Használd, amikor a felhasználó egy story megvalósítását kéri, pl. "/build S2".
argument-hint: "[story azonosító, pl. S1]"
---

# Egy story megvalósítása: tesztek → építés → megállás

A megvalósítandó story: **$ARGUMENTS**

Ha fent nem szerepel story-azonosító, vagy nem találod a specben, kérdezd meg a felhasználót az `AskUserQuestion` eszközzel. Opcióként a még el nem készült storykat ajánld fel, az első a soron következő legyen.

## 0. Előfeltételek

1. A `SPEC.md` elején `Státusz: JÓVÁHAGYVA` áll. Ha nem, **állj meg**, és kérd a jóváhagyást (1. kapu).
2. Keresd ki a story sorát a spec „Storyk és szállítási sorrend” részéből: a célját, az EK-it és a „Kész, ha…” feltételt.
3. Nézd meg a `HALADAS.md`-t (ha létezik). Ha egy korábbi story még nincs kész, és ez a story épít rá, szólj, és kérdezd meg, hogy így is folytassuk-e.
4. **Mielőtt bármit írnál, mutasd be röviden a storyt** (legfeljebb 8–10 sor), hogy a felhasználó tudja, mi következik:

   ```markdown
   ▶ S2 – Saját köszöneteim

   Felhasználói történet: Munkatársként vissza akarom keresni a kapott és küldött köszöneteimet, hogy …
   Mi készül el: kapott és küldött lista darabszámmal · keresés · kategória- és időszakszűrő
   EK-k: EK-08 (kapott lista) · EK-09 (küldött lista) · EK-10 (keresés) · EK-11 (szűrők)
   Kész, ha: Farkas Júlia a „Kapott” listában látja Horváth Anna köszönetét, és rá tud keresni.
   ```

   Az EK-knál elég egy-két szavas címke. A szöveget a spec „Storyk” sorából és az EK-kból állítsd össze, ne találj ki újat.
5. Ezután vegyél fel egy **feladatlistát** a beépített todo/feladatlista eszközzel: egy sor a tesztekre, utána **EK-nként** egy-egy sor, a végén egy sor a teljes tesztfuttatásra.

## 1. Tesztek (piros)

1. Írd meg a story **összes EK-jának** tesztjét a `tests/` mappába. Minden teszt neve vagy docstringje hivatkozzon az EK-azonosítóra (pl. `test_ek07_ertesites_b1_vezetonek`). Fájlonként egy story legyen, pl. `tests/test_s2_sajat_listak.py`.
2. Futtasd le **csak ezeket** a teszteket, és mutasd meg röviden, hogy pirosak (hány teszt, hány bukott).
3. Ha egy új teszt implementáció nélkül is zöld, az gyanús: jelezd, és javítsd a tesztet.

Ezután **ne állj meg**, folytasd az építéssel. A tesztek megírása és az építés egy kör része.

## 2. Építés (zöld)

1. Implementálj **EK-ról EK-ra**. Minden EK előtt írj ki egy rövid státuszsort (pl. `🔨 EK-07 – értesítés a B-1 vezetőnek`), utána futtasd a story tesztjeit, és pipáld ki a feladatlistában.
2. Csak azt építsd meg, ami **ehhez a storyhoz** kell. Ne kezdj bele a következő story funkcióiba, akkor sem, ha „kézre esnek”.
3. A felületet a `docs/arculat-ui.md` szerint építsd.
4. A végén futtasd az **összes** tesztet (`python3 -m unittest discover -s tests -v`), hogy a korábbi storyk sem romlottak el. Ha valami eltört, javítsd.
5. Ha 3 próbálkozás után is piros marad egy teszt, **állj meg**, írd le, mi a hiba és mit gondolsz róla, és kérdezd meg a felhasználót, hogyan tovább.

## 3. Lezárás és megállás

1. Frissítsd (vagy hozd létre) a `HALADAS.md`-t. Egy sor storynként:

   ```markdown
   | Story | Dátum | EK-k | Tesztek (zöld / összes) | Állapot |
   |---|---|---|---|---|
   | S2 | ÉÉÉÉ-HH-NN | EK-05…EK-11 | 14 / 14 | kész |
   ```

2. Írd ki a felhasználónak röviden:
   - mi készült el ebben a storyban,
   - a tesztek eredményét (story és összes),
   - **hogyan nézze meg a böngészőben**: 3–5 lépéses, konkrét kattintós ellenőrzés a „Kész, ha…” feltétel alapján, a `data/munkatarsak.json` neveivel (az alkalmazás indítása: `python3 app.py`, majd http://localhost:8000),
   - mi a következő story (pl. „Következő: `/build S3` – Értesítések”).
3. **Állj meg.** A következő storyba csak akkor kezdj, ha a felhasználó elindítja.
