# Felület és arculat – Kudos

> Kötelező útmutató a felülethez. A cél egy **igényes, modern, belső vállalati webalkalmazás** a Raiffeisen színvilágában, ne egy „nyers HTML-űrlap”.
> Minden külső függőség nélkül: saját CSS, vanilla JS, emoji vagy inline SVG ikonok, rendszerbetű. Nincs CDN, nincs webfont-letöltés.

## 1. Design tokenek

A `static/` mappában egy közös CSS-fájl elején, CSS-változóként:

```css
:root {
  /* Raiffeisen paletta */
  --yellow:      #FEE600;  /* RBI Primary Yellow: elsődleges gomb, kiemelés, aktív menü */
  --yellow-2:    #FFD403;  /* hover */
  --yellow-soft: #FFF0A6;  /* halvány kiemelés, kiválasztott elem háttere */
  --offblack:    #2B2D33;  /* szöveg, fejléc háttér */
  --grey-1:      #F8F6F2;  /* oldal háttér (Warm Grey 50%) */
  --grey-2:      #F1EDE6;  /* elválasztó felületek (Warm Grey) */
  --grey-3:      #D5D5D6;  /* keretek */
  --grey-4:      #808185;  /* másodlagos szöveg */
  --white:       #FFFFFF;  /* kártyák */

  /* kategória-színek (másodlagos paletta) */
  --cat-egyuttmukodes: #67D0AB;  /* zöld */
  --cat-segitseg:      #51C2F2;  /* kék */
  --cat-otlet:         #9D88D9;  /* lila */
  --cat-ugyfel:        #FF8B6B;  /* korall */
  --cat-kiemelkedo:    #F9BB30;  /* sárga 3 */

  --ok:    #489B79;
  --error: #C65C4A;

  --radius: 14px;
  --radius-sm: 8px;
  --shadow: 0 1px 2px rgba(43,45,51,.06), 0 4px 16px rgba(43,45,51,.06);
  --shadow-hover: 0 2px 4px rgba(43,45,51,.08), 0 10px 28px rgba(43,45,51,.10);
  --font: "Amalia", "Segoe UI", system-ui, -apple-system, Roboto, Arial, sans-serif;
}
```

**Szabály:** sárga háttéren a szöveg mindig `--offblack`. Sárga **szöveget** fehér vagy világos háttéren ne használj (nem olvasható).

**Térközök:** 4 / 8 / 12 / 16 / 24 / 32 / 48 px skála. **Betűméretek:** 13 (címke) · 15 (alap) · 17 (üzenetszöveg) · 22 (kártyacím) · 28 (oldalcím).

## 2. Elrendezés

```text
┌───────────────────────────────────────────────────────────────┐
│ ▰ Kudos   Fal · Új köszönet · Saját · Csapat   🔔3  (HA)▾ │  ← sötét (Off Black) fejléc, sárga aktív menü-aláhúzás
├───────────────────────────────────────────────────────────────┤
│  DEMO belépés: Horváth Anna · Fejlesztési Osztály   [Váltás]  │  ← vékony sárga sáv
│                                                               │
│  Oldalcím                                    [ + Új köszönet ] │
│  [ kereső……………… ] [Kategória ▾] [Időszak ▾]                    │
│                                                               │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐               │
│  │ kártya      │ │ kártya      │ │ kártya      │   ← rács: 3 / 2 / 1 oszlop
│  └─────────────┘ └─────────────┘ └─────────────┘               │
└───────────────────────────────────────────────────────────────┘
```

- Tartalom max. szélesség 1200 px, középre igazítva, 24 px oldalsó margó (mobilon 16 px).
- **Töréspontok:** ≥ 1024 px: 3 oszlopos kártyarács · 640–1023 px: 2 oszlop · < 640 px: 1 oszlop, és a fő menü **alsó tab-sávba** kerül (ikon + rövid felirat).
- A fejléc lapozáskor is fent marad (sticky).
- A logó helyett szöveges jel: egy kis sárga, ferde ék (parallelogramma) és a „Kudos” felirat. **Ne használd a hivatalos Raiffeisen-logót.**

## 3. Komponensek

### 3.1. Köszönetkártya
```text
┌──────────────────────────────────────────┐
│ (HA) Horváth Anna  →  (FJ) Farkas Júlia   │  avatarok: monogram, színes kör
│      Fejlesztési Oszt.     Adat Oszt.     │
│                                          │
│ [🤝 Együttműködés]               🌐 / 🔒  │  kategória-chip + láthatóság ikon
│                                          │
│ „Köszönöm a gyors adatelemzést! 🙏🎉”      │  17 px, sorköz 1.5
│                                          │
│ 2 órája                      [👏 4]       │  relatív idő (hover: pontos) + taps gomb
└──────────────────────────────────────────┘
```
- Fehér háttér, `--radius`, `--shadow`, hoverre `--shadow-hover` és 2 px-es felemelkedés (`transform`).
- Bal oldalon 4 px-es színes csík a **kategória színével**.
- **Avatar:** 36 px-es kör, a név monogramja, a háttérszín a munkatárs azonosítójából determinisztikusan (mindig ugyanaz) a kategóriaszínek és a sárga közül.
- **Taps gomb:** ha a felhasználó már tapsolt, kitöltött sárga háttér, egyébként keretes. Kattintásra rövid „pop” animáció.

### 3.2. Gombok
- **Elsődleges:** sárga háttér, Off Black szöveg, 600-as vastagság, 44 px magas, `--radius-sm`. Hover: `--yellow-2`.
- **Másodlagos:** fehér háttér, `--grey-3` keret.
- **Szöveges:** háttér nélkül, aláhúzás hoverre.
- Letiltott állapot: 50% átlátszóság, `cursor: not-allowed`.

### 3.3. Új köszönet: 3 lépéses varázsló
1. **Kinek?** Nagy kereső, alatta élő találati lista avatarral, beosztással, egységgel. **Billentyűzettel** is navigálható (↑ ↓ Enter Esc).
2. **Mit?** Kategória-választó **5 nagy kártyagombként** (emoji + név + egysoros leírás). Szövegmező karakterszámlálóval (`423 / 500`, a vége felé narancs, túllépésnél piros). Láthatóság-kapcsoló: 🔒 Privát / 🌐 Nyilvános.
3. **Ellenőrzés:** a köszönet **pontosan úgy jelenik meg, ahogy majd a kártyán fog**, alatta [Vissza] és [Küldés] gomb.

Fent egy lépésjelző (1 — 2 — 3) mutatja, hol tart a felhasználó. Sikeres küldés után **toast-értesítés** (lent középen, 4 mp, `aria-live="polite"`), majd átirányítás a „Küldött” listára.

### 3.4. Hibák és üres állapotok
- Űrlaphiba a mező alatt, piros szöveggel és ikonnal, **nem** felugró ablakban (pl. „Ugyanannak a munkatársnak ma már 3 köszönetet küldtél.”).
- **Üres állapot** minden listánál: nagy emoji, egy mondat, és egy elsődleges gomb (pl. 🌱 „Még nem kaptál köszönetet. Te már küldtél ma valakinek?” [+ Új köszönet]).

### 3.5. Értesítések
- Csengő ikon a fejlécben, sárga számláló-buborékkal.
- Kattintásra legördülő panel: legújabb elöl, az olvasatlanok halvány sárga (`--yellow-soft`) háttérrel. Fent: „Mind olvasott”.

### 3.6. Vezetői statisztika
- Felül 4 **mutató-kártya** egy sorban (mobilon 2×2): nagy szám (28 px, félkövér), alatta címke. Pl. „24 · kapott köszönet”.
- Alattuk **kategória-megoszlás** vízszintes sávdiagramként, tisztán CSS-sel (`width: %`), a kategória színeivel, a sáv végén a darabszámmal.
- „Top 3” lista avatarral és helyezéssel (🥇 🥈 🥉).

## 4. Akadálymentesség (alapszint)
- Minden interaktív elem elérhető **Tab**-bal, a fókusz jól látható: 3 px-es sárga keret + 2 px-es Off Black belső keret.
- Ikon-gomboknak `aria-label`, a toastnak `aria-live`.
- A kontraszt legalább 4.5:1 a szövegeknél.
- A kattintható felületek legalább 44×44 px-esek.
- Animációk: `prefers-reduced-motion` esetén kikapcsolva.

## 5. Amit kerülj
- Alapértelmezett, formázatlan böngésző-űrlapelemek, kék linkek, Times New Roman.
- Táblázat mint fő megjelenítés (a köszönet kártya, nem sor).
- `alert()` / `confirm()` felugró ablakok.
- Külső CSS-keretrendszer, ikonkészlet, webfont vagy CDN.
