# Üzleti leírás – Kudos (demó változat)

> Ez az eredeti, teljes körű „Belső Köszönő Üzenetküldő Webalkalmazás” igény **egyszerűsített, helyben futtatható** változata egy délutáni gyakorláshoz.
> Ebből készül a `SPEC.md`. Ez a dokumentum az üzleti igényt írja le, nem a technikai megoldást.
> A felület megjelenésére vonatkozó elvárások külön dokumentumban vannak: `docs/arculat-ui.md`.

## 1. Cél

A munkatársak köszönő üzenetet küldhessenek egymásnak, a vezetők pedig lássák a csapatukhoz kapcsolódó köszöneteket, és átfogó képet kapjanak róluk.
Így az elismerés látható, visszakereshető és mérhető lesz. A munkatárs maga döntheti el, hogy egy köszönet csak a közvetlen érintetteké, vagy az egész szervezet láthatja-e.

## 2. Szereplők

### Szervezeti szintek

A szint **pozíció**, a `data/munkatarsak.json` `szint` mezője adja meg (mint egy AD-attribútum):

| Szint | Kik | Megjegyzés |
|---|---|---|
| **B** | board tag (igazgatósági tag) | Fölötte már csak a CEO áll, ő nincs az adatokban |
| **B-1** | főosztályvezető | a board tag alatti szint |
| **B-2** | osztályvezető | a legalacsonyabb vezetői szint |
| – | alkalmazott | nincs beosztottja |

### Szereplők

| Szereplő | Mit tehet |
|---|---|
| **Munkatárs** (bárki) | Köszönetet küld, látja a saját küldött és kapott köszöneteit és a közös falat, reagál, értesítést kap |
| **Vezető** (B-2, B-1, B) | Mint egy munkatárs, és látja a **szervezeti köréhez** kapcsolódó köszöneteket és azok statisztikáit |

A vezető **szervezeti köre**: minden alatta lévő munkatárs, bármilyen mélységben. B-2-nél ez az osztálya, B-1-nél a teljes főosztálya, B-nél minden alá tartozó főosztály.
A vezető is munkatárs, tehát ő is küldhet és kaphat köszönetet.

**A címzett B-1 vezetője:** a címzett feletti vezetői láncban lévő, **B-1 szintű** vezető (vagyis a címzett főosztályvezetője).
- Ha a címzett közvetlen vezetője maga a B-1 (pl. egy osztályvezető kap köszönetet), akkor ugyanaz a személy közvetlen vezetőként és B-1-ként is érintett.
- Ha a címzett maga B-1 vagy B szintű, akkor nincs „B-1 vezetője”.

## 3. Funkciók

### 3.1. Belépés
- A felhasználó kiválasztja magát egy listából („Belépés mint…”), jelszó nincs.
- A felületen jól látható jelzés mutatja, hogy ez **DEMO** belépés.

### 3.2. Köszönet küldése
- **Címzett:** keresővel választható ki, név, szervezeti egység vagy e-mail-részlet alapján. A találati listában látszik a név, a beosztás és az egység.
- **Kategória** (kötelező, pontosan egy):

  | Kategória | Jelentés |
  |---|---|
  | 🤝 Együttműködés | közös munka, csapatjáték |
  | 🚀 Gyors segítség | kisegített egy szorult helyzetben |
  | 💡 Jó ötlet | új megoldás, javaslat |
  | 🎯 Ügyfélfókusz | ügyfélért tett extra erőfeszítés |
  | ⭐ Kiemelkedő munka | átlagon felüli teljesítmény |

- **Üzenet:** szöveg, amiben emoji is lehet (pl. 🙏 🎉 💛).
- **Láthatóság:** **Privát** (alapértelmezett) vagy **Nyilvános a falon**.
  - Privát: csak a küldő, a címzett és a jogosult vezetők látják.
  - Nyilvános: ezen felül minden munkatárs látja a közös falon.
- A küldés előtt a felhasználó **ellenőrző nézetet** lát (kinek, milyen kategóriában, mit, milyen láthatósággal), és ott véglegesíti a küldést, vagy visszalép szerkeszteni.
- Sikeres küldés után **visszaigazolást** kap.
- A küldés dátuma és időpontja automatikusan rögzül.

**Szabályok:**
- Egy üzenetnek pontosan egy címzettje van.
- Magának senki sem küldhet köszönetet.
- Üres (vagy csak szóközből álló) üzenet nem küldhető.
- Az üzenet legfeljebb 500 karakter lehet. Írás közben látszik, hány karakter van még hátra.
- Kategória nélkül nem küldhető.
- **Ugyanannak a címzettnek naponta legfeljebb 3 köszönet** küldhető ugyanattól a küldőtől (a köszönet ne váljon „spammé”). A 4. próbálkozásnál érthető hibaüzenet jelenik meg.

### 3.3. Saját köszöneteim
- Két nézet van: **Kapott** és **Küldött**, mindkettőn látszik a darabszám.
- Minden üzenetnél látszik: a küldő neve, a címzett neve, a kategória, a szöveg (emojikkal), a láthatóság, a reakciók száma és a küldés időpontja.
- Az üzenetek a legújabbal kezdődnek.
- **Szűrés és keresés:**
  - szabad szavas keresés az üzenet szövegében, valamint a küldő vagy a címzett nevében,
  - kategória szerinti szűrés,
  - időszak szerinti szűrés (pl. elmúlt 7 nap, 30 nap, összes).

### 3.4. Közös fal
- A kezdőoldal a **Kudos fal**: az összes **nyilvános** köszönet, a legújabbal kezdve.
- Kategória szerint szűrhető.
- Privát köszönet itt soha nem jelenik meg, senkinek.

### 3.5. Reakciók
- Bármely köszönetre, amit a felhasználó lát, reagálhat egy **👏 tapssal**.
- Egy személy egy köszönetre legfeljebb egyszer tapsolhat. Újabb kattintásra a taps visszavonódik.
- A köszönet mellett látszik a tapsok száma, és hogy a felhasználó tapsolt-e már.
- Reakció csak olyan köszönetre adható, amelyet a felhasználó láthat. Egy privát köszönetre egy illetéktelen munkatárs akkor sem tud tapsolni, ha közvetlenül próbálja.

### 3.6. Értesítések
Köszönet küldésekor értesítést kap:
- a **címzett**,
- a címzett **közvetlen vezetője** (ha van),
- a címzett **B-1 vezetője** (ha van, lásd a 2. pontot).

A board tag (B) csak akkor kap értesítést, ha ő a címzett közvetlen vezetője. Egy személy egy üzenetről legfeljebb egy értesítést kap, akkor is, ha több szerepben érintett. Az értesítés az alkalmazáson belül jelenik meg (csengő ikon, olvasatlan-számláló), és tartalmazza a küldő és a címzett nevét, a kategóriát, a dátumot, valamint az üzenet rövid előnézetét.
Az értesítés megnyitásakor olvasottá válik. Az összes értesítés egyszerre is olvasottnak jelölhető.

### 3.7. Vezetői nézet („Csapatköszönetek”)
- Csak vezetők látják (B-2, B-1 és B szint, vagyis akiknek van legalább egy beosztottja).
- A vezető azokat az üzeneteket látja (privátokat és nyilvánosakat is), ahol a **küldő vagy a címzett az ő szervezeti körébe tartozik** (minden alatta lévő munkatárs, bármilyen mélységben).
- Más üzenetet **nem láthat**, akkor sem, ha közvetlenül próbálja lekérni.
- Itt is van keresés, kategória- és időszakszűrés.

### 3.8. Vezetői statisztika
A vezetői nézet tetején, a vezető szervezeti körére és a kiválasztott időszakra (alapértelmezés: elmúlt 30 nap):
- a körbe tartozók által **küldött** és **kapott** köszönetek száma,
- a köszönetek **megoszlása kategóriák szerint** (egyszerű sávdiagram),
- a **3 legtöbb köszönetet kapott** munkatárs a körből (holtversenynél ábécérendben),
- a körből **hány különböző munkatárs** küldött legalább egy köszönetet (aktív küldők).

A statisztika csak a vezető saját körére vonatkozó adatokból számolható. Más kör adata nem szivároghat bele.

## 4. Ami kimarad a demóból

Az eredeti igényből szándékosan kihagyjuk, és a spec „Kimarad” részében így kell szerepelnie:

- valódi Active Directory és SSO (helyette: `data/munkatarsak.json` és „Belépés mint…”),
- e-mail és Teams értesítés (helyette: alkalmazáson belüli értesítés),
- képfeltöltés és vírusellenőrzés,
- adminisztrátori szerepkör, moderáció, riportok,
- megőrzési és archiválási szabályok,
- szerveres üzemeltetés és deploy,
- teljes WCAG-audit (az alapokra, pl. billentyűzetes használatra és kontrasztra figyelünk).

## 5. Adatforrás

A munkatársak adatai a `data/munkatarsak.json` fájlban vannak (ez helyettesíti az AD-t):
azonosító, név, e-mail, szervezeti egység, beosztás, **szint** (B, B-1, B-2 vagy üres) és a közvetlen vezető azonosítója.
Az alkalmazás ezt csak olvassa.

## 6. Üzleti elfogadási elvárások

A megoldás akkor jó, ha:

1. Bármelyik munkatárs be tud lépni a listából.
2. Ki tud választani egy másik munkatársat címzettként a keresővel.
3. Kategóriával és emojival ellátott köszönetet tud küldeni, ellenőrző lépés után, privát vagy nyilvános láthatósággal.
4. Nem tud küldeni magának, üres vagy túl hosszú üzenetet, kategória nélkül, illetve ugyanannak a címzettnek naponta 3-nál többet.
5. Az üzenet megjelenik a küldő „Küldött” és a címzett „Kapott” listájában.
6. A nyilvános köszönet mindenkinek megjelenik a közös falon, a privát senkinek.
7. Tapsolni lehet, egy személy egy köszönetre csak egyszer, és csak olyanra, amit láthat.
8. A címzett, a közvetlen vezetője és a B-1 vezetője értesítést kap, más nem, és senki sem kap kettőt ugyanarról az üzenetről.
9. A vezető a vezetői nézetben csak a saját szervezeti köréhez kapcsolódó üzeneteket látja, a statisztikája is csak ezekből számol.
10. A saját és a vezetői nézetben is működik a keresés, a kategória- és az időszakszűrés.
11. A felület megfelel a `docs/arculat-ui.md` elvárásainak: Raiffeisen színek, igényes kártyás megjelenés, mobilon is használható, billentyűzettel is kezelhető.
