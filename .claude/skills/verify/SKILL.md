---
name: verify
description: Lefuttatja az összes tesztet, és BIZONYITEK.md-t készít arról, hogy a jóváhagyott SPEC.md elfogadási kritériumait (EK-xx) melyik teszt igazolja, és mi lett az eredmény. Használd a munka végén, a 2. kapu (emberi elfogadás) előtt.
---

# Bizonyíték-összefoglaló (2. kapu előkészítése)

1. Ellenőrizd, hogy a `SPEC.md` elején `Státusz: JÓVÁHAGYVA` áll. Ha nem, állj meg, és szólj: jóváhagyott spec nélkül nincs mit igazolni.
2. Futtasd le az összes tesztet:

   ```bash
   python3 -m unittest discover -s tests -v
   .venv/bin/python -m unittest discover -s tests/e2e -v
   ```

3. Gyűjtsd ki a `SPEC.md`-ből az összes EK-azonosítót, a tesztekből pedig, hogy melyik teszt melyik EK-ra hivatkozik.
4. Készítsd el a `BIZONYITEK.md`-t **szakaszonként, látható haladással**: előbb a váz a szakaszcímekkel, utána egyenként töltsd ki őket kis szerkesztésekkel, mindegyik előtt egy rövid státuszsorral (pl. `🧾 2/5 – Kritériumok lefedettsége`). A szerkezet:

   ```markdown
   # Bizonyíték – Kudos

   Spec verzió: X.Y · Dátum: ÉÉÉÉ-HH-NN · Unit: N db, ebből zöld: M · E2E: K db, ebből zöld: L

   ## Kritériumok lefedettsége
   | EK | Rövid leírás | Teszt(ek) | Eredmény |
   |---|---|---|---|
   | EK-01 | … | test_… | ✅ / ❌ |

   ## Böngészős (E2E) tesztek storynként
   | Story | E2E teszt | Mit kattint végig | Eredmény |
   |---|---|---|---|
   | S1 | test_s1_… | Horváth Anna köszönetet küld Farkas Júliának | ✅ / ❌ |

   ## Lefedetlen kritériumok
   (Amelyik EK-hoz nincs teszt. Ha nincs ilyen: „Nincs.”)

   ## Kézi ellenőrzés az elfogadóknak
   Rövid, számozott kattintós forgatókönyv konkrét nevekkel
   (pl. „Lépj be Horváth Annaként…”), és mit kell látni az egyes lépések után.

   ## Ismert korlátok
   (Ami a „Kimarad” rész szerint nincs benne, plusz bármi, amit menet közben észrevettél.)

   ## Teszt-kimenet (összefoglaló)
   Az utolsó futás végeredménye (a teljes kimenet helyett az összesítő sorok).
   ```

5. Ha bármelyik teszt piros, vagy van lefedetlen EK, **ne nevezd késznek a munkát**: írd ki, mi hiányzik, és kérdezd meg, hogy javítsd-e.
6. Ha minden zöld, kérd meg a felhasználót, hogy olvassa el a `BIZONYITEK.md`-t, járja végig a kézi forgatókönyvet (`python3 app.py`, majd http://localhost:8000), és ő döntsön az elfogadásról (2. kapu).
