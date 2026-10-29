# SPEC – Köszönőfal

Státusz: TERVEZET
Verzió: 1.0
Utolsó módosítás: ÉÉÉÉ-HH-NN

> A `Státusz` sort **csak az ember** állíthatja `JÓVÁHAGYVA`-ra (1. kapu). Amíg `TERVEZET`, kód nem készülhet.

## 1. Cél
<!-- 2-3 mondat: mit old meg, kinek. -->

## 2. Hatókör

### 2.1. Benne van
<!-- Felsorolás. Csak ami az üzleti leírásból következik. -->

### 2.2. Kimarad
<!-- Minden, ami szándékosan kimarad, és mi helyettesíti (ha valami). -->

## 3. Szereplők és jogosultságok
<!-- Táblázat: szereplő → mit lát, mit tehet. A "B-1 vezető" pontos definíciója. -->

## 4. Adatmodell
<!-- Entitások és mezők (pl. Munkatárs – a JSON-ból, Köszönet, Értesítés). Kulcsok, kötelező mezők, korlátok. -->

## 5. Képernyők és folyamatok
<!-- Képernyőnként: mi látszik, mit lehet csinálni. A küldés lépései az ellenőrző nézettel. -->

## 6. Üzleti szabályok
<!-- Számozott szabályok (SZ-01, SZ-02 ...). Pl. önmagának nem küldhet, max. hossz, értesítendők köre, láthatóság. -->

## 7. Elfogadási kritériumok
<!--
Minden kritérium:
- egyedi azonosító: EK-01, EK-02, ...
- Adott / Amikor / Akkor formában,
- konkrét, automatikusan tesztelhető (lehetőleg a data/munkatarsak.json neveivel),
- hivatkozik a szabályra, amit ellenőriz (pl. SZ-03).

Példa:
EK-07 (SZ-05) – Adott: Horváth Anna (u05) köszönetet küld Farkas Júliának (u09).
               Akkor: értesítést kap Farkas Júlia, Szabó Katalin (közvetlen vezető) és Kovács Eszter (B-1), más nem.
-->

## 8. Nem funkcionális elvárások
<!-- Technológiai keret (CLAUDE.md szerint), biztonság (escape, paraméterezett SQL, szerveroldali jogosultság), arculat, akadálymentesség alapjai. -->

## 9. Nyitott kérdések
<!-- Amit az embernek kell eldöntenie. Jóváhagyás előtt ennek üresnek kell lennie, vagy minden pontnál ott a döntés. -->

## 10. Változásnapló
| Verzió | Dátum | Változás | Érintett EK-k |
|---|---|---|---|
| 1.0 | ÉÉÉÉ-HH-NN | Első változat | – |
