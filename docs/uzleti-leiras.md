# Üzleti leírás – Köszönőfal (demó változat)

> Ez az eredeti, teljes körű „Belső Köszönő Üzenetküldő Webalkalmazás” igény **egyszerűsített, helyben futtatható** változata egy délutáni gyakorláshoz.
> Ebből készül a `SPEC.md`. Ez a dokumentum az üzleti igényt írja le, nem a technikai megoldást.

## 1. Cél

A munkatársak köszönő üzenetet küldhessenek egymásnak, a vezetők pedig lássák a csapatukhoz kapcsolódó köszöneteket.
Így az elismerés látható és visszakereshető lesz.

## 2. Szereplők

| Szereplő | Mit tehet |
|---|---|
| **Munkatárs** | Köszönetet küld, látja a saját küldött és kapott köszöneteit, értesítést kap |
| **Közvetlen vezető** | Mint egy munkatárs, és látja a **közvetlen beosztottjai** által küldött vagy kapott köszöneteket |
| **B-1 vezető** | Mint egy munkatárs, és látja a **teljes szervezeti köréhez** (minden alatta lévő munkatárshoz) kapcsolódó köszöneteket |

A vezető is munkatárs, tehát ő is küldhet és kaphat köszönetet.

**B-1 vezető (ebben a demóban):** a címzett közvetlen vezetőjének a vezetője. Ha ilyen nincs (mert a címzett közvetlen vezetője már a legfelső szint), akkor nincs B-1 vezető.

## 3. Funkciók

### 3.1. Belépés
- A felhasználó kiválasztja magát egy listából („Belépés mint…”), jelszó nincs.
- A felületen jól látható jelzés mutatja, hogy ez **DEMO** belépés.

### 3.2. Köszönet küldése
- **Címzett:** keresővel választható ki, név, szervezeti egység vagy e-mail-részlet alapján.
- **Üzenet:** szöveg, amiben emoji is lehet (pl. 🙏 🎉 💛).
- A küldés előtt a felhasználó **ellenőrző nézetet** lát (kinek, mit), és ott véglegesíti a küldést.
- Sikeres küldés után **visszaigazolást** kap.
- A küldés dátuma és időpontja automatikusan rögzül.

**Szabályok:**
- Egy üzenetnek pontosan egy címzettje van.
- Magának senki sem küldhet köszönetet.
- Üres (vagy csak szóközből álló) üzenet nem küldhető.
- Az üzenet legfeljebb 500 karakter lehet.

### 3.3. Saját köszöneteim
- Két nézet van: **Kapott** és **Küldött**.
- Minden üzenetnél látszik: a küldő neve, a címzett neve, a szöveg (emojikkal) és a küldés időpontja.
- Az üzenetek a legújabbal kezdődnek.
- **Szabad szavas keresés** van az üzenet szövegében, valamint a küldő vagy a címzett nevében.

### 3.4. Értesítések
Köszönet küldésekor értesítést kap:
- a **címzett**,
- a címzett **közvetlen vezetője** (ha van),
- a címzett **B-1 vezetője** (ha van).

Egy személy egy üzenetről legfeljebb egy értesítést kap. Az értesítés az alkalmazáson belül jelenik meg (pl. csengő ikon, olvasatlan-számláló), és tartalmazza a küldő és a címzett nevét, a dátumot, valamint az üzenet rövid előnézetét. Az értesítés megnyitásakor az olvasottá válik.

### 3.5. Vezetői nézet („Csapatköszönetek”)
- Csak vezetők látják (akiknek van legalább egy beosztottja).
- A vezető azokat az üzeneteket látja, ahol a **küldő vagy a címzett az ő szervezeti körébe tartozik**:
  - közvetlen vezető: a közvetlen beosztottjai,
  - B-1 vezető: minden alatta lévő munkatárs, bármilyen mélységben.
- Más üzenetet **nem láthat**, akkor sem, ha közvetlenül próbálja lekérni.
- Itt is van szabad szavas keresés.

## 4. Ami kimarad a demóból

Az eredeti igényből szándékosan kihagyjuk, és a spec „Kimarad” részében így kell szerepelnie:

- valódi Active Directory és SSO (helyette: `data/munkatarsak.json` és „Belépés mint…”),
- e-mail és Teams értesítés (helyette: alkalmazáson belüli értesítés),
- képfeltöltés és vírusellenőrzés,
- vezetői statisztikák,
- adminisztrátori szerepkör, moderáció, riportok,
- megőrzési és archiválási szabályok,
- szerveres üzemeltetés és deploy,
- teljes WCAG-audit (az alapokra, pl. billentyűzetes használatra és kontrasztra figyelünk).

## 5. Adatforrás

A munkatársak adatai a `data/munkatarsak.json` fájlban vannak (ez helyettesíti az AD-t):
azonosító, név, e-mail, szervezeti egység, beosztás és a közvetlen vezető azonosítója.
Az alkalmazás ezt csak olvassa.

## 6. Üzleti elfogadási elvárások

A megoldás akkor jó, ha:

1. Bármelyik munkatárs be tud lépni a listából.
2. Ki tud választani egy másik munkatársat címzettként a keresővel.
3. Emojit tartalmazó köszönetet tud küldeni, ellenőrző lépés után.
4. Magának nem tud küldeni, és üres üzenetet sem tud küldeni.
5. Az üzenet megjelenik a küldő „Küldött” és a címzett „Kapott” listájában.
6. A címzett, a közvetlen vezetője és a B-1 vezetője értesítést kap, más nem.
7. A vezető a vezetői nézetben csak a saját szervezeti köréhez kapcsolódó üzeneteket látja.
8. A saját és a vezetői nézetben is működik a keresés.
9. A felület a Raiffeisen színeit használja, mobilon is használható, és billentyűzettel is kezelhető.
