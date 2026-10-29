---
name: spec
description: A SPEC.md specifikáció megírása vagy módosítása a docs/uzleti-leiras.md alapján, a templates/SPEC-sablon.md szerkezetében. Használd, amikor specifikációt kell készíteni, vagy változáskérés érkezik egy már létező spechez. Kódot nem ír.
---

# Specifikáció írása vagy módosítása

Ez a skill **csak dokumentumot** készít. Kódot és tesztet nem írsz, amíg a spec nincs jóváhagyva.

## Új spec (ha még nincs `SPEC.md`)

1. Olvasd el: `docs/uzleti-leiras.md`, `templates/SPEC-sablon.md`, `data/munkatarsak.json`, `CLAUDE.md`.
2. **Tegyél fel legfeljebb 4 tisztázó kérdést, az `AskUserQuestion` eszközzel** (választós felület), ne szöveges listában.
   - Csak azt kérdezd, ami tényleg nem következik a leírásból (pl. rendezés, mi számít „szervezeti körnek”, mi történjen határesetben).
   - Kérdésenként 2–4 konkrét, egymást kizáró opciót adj. Az általad javasolt opció legyen az **első**, a címkéje végén „(Ajánlott)” jelöléssel, a leírásában egy mondattal az indok.
   - Rövid fejlécet (header) adj minden kérdésnek, pl. „Rendezés”, „B-1 határeset”.
   - Ne adj „Egyéb” opciót, azt a felület magától hozzáadja.
   - Ha az eszköz nem érhető el, akkor tedd fel a kérdéseket számozott listában, mindegyikhez javasolt alapértelmezéssel.
3. A válaszok után írd meg a `SPEC.md`-t **szakaszonként, látható haladással**, ne egyetlen nagy fájlírással (különben a felhasználó percekig csak egy pörgő jelzőt lát):
   - **Közvetlenül a válaszok után, mielőtt a tartalmon gondolkodnál**, írj ki egy nyugtázó sort a döntésekkel, pl. `✅ Rögzítettem: rendezés dátum szerint, … – indul a SPEC.md írása (11 szakasz).` Ez legyen az első, amit a felhasználó lát.
   - **Ne tervezd meg előre fejben a teljes specet.** Minden szakaszt közvetlenül a megírása előtt, röviden gondolj végig. Az előre, egyben végiggondolt spec a legfőbb oka a hosszú csendnek.
   - Ezután rögtön vegyél fel egy **feladatlistát** a beépített todo/feladatlista eszközzel, a sablon szakaszaival (1. Cél … 11. Változásnapló). Így a felületen látszik, hol tartasz.
   - Hozd létre a `SPEC.md` **vázát**: a fejléc (státusz, verzió, dátum) és a szakaszcímek, a szakaszok helyén `(készül…)` jelöléssel.
   - Ezután **szakaszonként** töltsd ki egy-egy kis szerkesztéssel. Minden szakasz előtt írj ki egy rövid státuszsort, pl. `✍️ 4/11 – Adatmodell`, utána pedig pipáld ki a feladatlistában.
   - A hosszú részt (Elfogadási kritériumok) 3–5 EK-s adagokban írd, az adagok között egy-egy státuszsorral (pl. `✍️ 7/11 – EK-01…EK-05`).

   Tartalmi elvárások, **pontosan a sablon szerkezetében**:
   - `Státusz: TERVEZET`, `Verzió: 1.0`, mai dátum.
   - A „Kimarad” rész sorolja fel az üzleti leírás 4. pontjának minden elemét.
   - Üzleti szabályok: `SZ-01`, `SZ-02`, … számozással.
   - Elfogadási kritériumok: `EK-01`, `EK-02`, …, Adott / Amikor / Akkor formában, **konkrét nevekkel a JSON-ból**, mindegyik automatikusan tesztelhető, és hivatkozik a szabályra, amit ellenőriz.
   - Legyen külön EK a negatív esetekre is: önmagának küldés, üres üzenet, túl hosszú üzenet, illetéktelen vezetői hozzáférés.
   - Az üzleti leírás 6. pontjának minden eleme legyen lefedve legalább egy EK-val.
   - **Storyk** (8. szakasz): az EK-kat csoportosítsd 5–7 **vertikális** storyba (felület + logika + adat együtt), a megvalósítás sorrendjében, `S1`, `S2`, … azonosítóval.
     - Minden EK **pontosan egy** storyban szerepeljen. Új EK-t ezért ne találj ki.
     - Minden story után legyen böngészőben kipróbálható, működő állapot. A „Kész, ha…” oszlop konkrét nevekkel írja le, mit kell látni.
     - Az első storyk (kb. S1–S4) adjanak egy minimálisan használható változatot (MVP), a többi épüljön rájuk.
     - Egy storyban legfeljebb kb. 8 EK legyen, hogy egy kör áttekinthető maradjon.
4. Írd ki röviden a felhasználónak:
   - hány szabály és hány EK készült,
   - melyik üzleti elvárást melyik EK fedi le (rövid táblázat),
   - a storyk listája egy-egy sorban, az MVP jelölésével,
   - a nyitott kérdéseket, ha maradt ilyen.
5. **Állj meg.** Kérd meg a felhasználót, hogy nézze át a `SPEC.md`-t, és ha rendben van, **saját maga** írja át a státuszt `JÓVÁHAGYVA`-ra (ez az 1. kapu). A státuszt te ne módosítsd. **A jóváhagyás után se kezdj bele magadtól a tesztírásba:** nyugtázd, és mondd meg, hogy a következő lépés a `/build S1`, de várd meg, hogy a felhasználó elindítsa (lásd a `CLAUDE.md` „Egyszerre egy fázis” részét).

## Változáskérés (ha már van `SPEC.md`)

1. Olvasd el a jelenlegi `SPEC.md`-t és a kérést. Ha a kérés ütközik a „Kimarad” résszel, mondd ki, és kérdezd meg, hogy a hatókört is bővítsük-e.
2. Módosítsd a specet **célzott, kis szerkesztésekkel** (ne írd újra az egész fájlt), mindegyik előtt egy rövid státuszsorral:
   - növeld a verziót (pl. 1.0 → 1.1),
   - a státuszt állítsd vissza `TERVEZET`-re,
   - az új vagy módosult szabályokat és EK-kat jelöld (pl. „(1.1-ben új)”), a meglévő azonosítókat ne számozd át,
   - az új EK-kat sorold be egy storyba: jellemzően egy **új storyba** (pl. S7), hogy a kész storykat ne kelljen újranyitni,
   - töltsd ki a változásnaplót, benne az érintett EK-kal.
3. Írd ki, mi változott, és melyik meglévő tesztet érinti.
4. **Állj meg**, és kérj újbóli jóváhagyást.
