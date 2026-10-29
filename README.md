# Kudos – spec-driven demó Claude Code-dal

Gyakorló feladat a B-1 vezetői AI-workshop délutáni részéhez.
Egy kis belső köszönetküldő alkalmazást, a **Kudos**-t, építünk **a saját gépen, WSL-ben**, Claude Code-dal.
Nem „vibe coding”: előbb **specifikáció**, utána **tesztek**, és csak ezután **kód**, két emberi jóváhagyási ponttal.

> Az alkalmazás csak helyben fut, kitalált adatokkal. Nincs AD, e-mail, szerver vagy deploy.
> A repót csak **letöltöd**, a munkád a saját gépeden marad. Ide **nem kell visszacommitolni** semmit.

**📘 Lépésről lépésre útmutató: [Kudos lab guide](https://wydrian1.github.io/b1training/lab/)**

## Előfeltételek

- WSL (Ubuntu), benne `python3` (3.10 vagy újabb) és `git`
- Claude Code, beállítva az RBI LLM gatewayre (pl. Sonnet 5.5 modellel)

Ellenőrzés:

```bash
python3 --version
claude --version
```

## Indulás

```bash
git clone https://github.com/wydrian1/b1-demo-kudos.git kudos
cd kudos
claude
```

Az első üzenet Claude-nak:

```text
/spec
```

Claude elolvassa az üzleti leírást (`docs/uzleti-leiras.md`), feltesz néhány tisztázó kérdést, és megírja a `SPEC.md`-t. **Kódot még nem ír.**

## A folyamat

| Lépés | Ki | Mi történik |
|---|---|---|
| 1. Specifikáció | Claude (`/spec`) | `SPEC.md` készül, státusz: `TERVEZET` |
| 2. **🟡 1. kapu** | **Te** | Átnézed a specet. Ha jó, **te magad** írod át a státuszt `JÓVÁHAGYVA`-ra |
| 3. Tesztek | Claude | Minden elfogadási kritériumhoz (EK-xx) teszt készül, ezek eleinte pirosak |
| 4. Építés | Claude | Addig dolgozik, amíg minden teszt zöld |
| 5. Bizonyíték | Claude (`/verify`) | `BIZONYITEK.md`: melyik kritériumot melyik teszt igazolja, mi az eredmény |
| 6. **🟡 2. kapu** | **Te** | Elolvasod a bizonyítékot, végigkattintod a kézi ellenőrzést (lab guide 2. kapu), és elfogadod vagy visszadobod |

## Futtatás (ha már elkészült)

```bash
python3 app.py
```

Majd a böngészőben: http://localhost:8000

Tesztek:

```bash
python3 -m unittest discover -s tests -v
```

## Mi van a repóban?

| Fájl | Szerep |
|---|---|
| `CLAUDE.md` | Szabályok az ágensnek (technológia, folyamat, tilalmak) |
| `docs/uzleti-leiras.md` | Az egyszerűsített üzleti igény, **ebből** indul minden |
| `docs/arculat-ui.md` | A felület kötelező útmutatója: színek, komponensek, elrendezés |
| `templates/SPEC-sablon.md` | A specifikáció kötelező szerkezete |
| `data/munkatarsak.json` | Kitalált munkatársak és szervezeti hierarchia (az AD helyett) |
| `.claude/skills/spec/` | `/spec`: specifikáció írása vagy módosítása |
| `.claude/skills/verify/` | `/verify`: tesztek futtatása és bizonyíték-összefoglaló |
